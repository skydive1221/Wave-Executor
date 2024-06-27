-- Author: @Jumpathy
-- Name: billboard.lua
-- Description: Billboard gui for bubble chat lol
-- Small credits:
-- @McThor2 - [Math help](https://devforum.roblox.com/t/raycast-between-2-attachments/976915/8)
-- @sleitnick - [Raycasting help](https://devforum.roblox.com/t/detect-if-player-is-looking-at-object/1479746/5)

local billboard = {}
local useRaycastingToDetermineVisibility = true

function billboard.init(config,network,environment)
	local ui = require(script.Parent:WaitForChild("ui")).init(config)
	local stackModule = require(script.Parent:WaitForChild("stack"))(environment).init(config)

	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer

	local containerGui = Instance.new("ScreenGui")
	containerGui.Name = "bubbleChat"
	containerGui.Parent = localPlayer.PlayerGui
	containerGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	containerGui.ResetOnSpawn = false
	environment.bubbleChatContainer = containerGui

	function billboard:holster(player)
		local isLocalPlayer = (player == localPlayer)
		local connections = {}
		local linked = {}
		local typingIndicator,gui,stack,lastState = nil,nil,nil,nil
		local link = function(signal)
			table.insert(connections,signal)
		end
		link(player.Changed:Connect(function()
			if(player:GetFullName() == player.Name) then
				for _,connection in pairs(connections) do
					connection:Disconnect()
				end
				connections = nil
				linked = nil
			end
		end))
		local linkAlwaysOnTop = function(gui,adornee)
			local camera = workspace.CurrentCamera
			local raycastParams = RaycastParams.new()
			raycastParams.IgnoreWater = true
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude
			raycastParams.FilterDescendantsInstances = {adornee.Parent}
			link(camera.Changed:Connect(function()
				local vector,inViewport = camera:WorldToViewportPoint(adornee.Position)
				local onScreen = inViewport and vector.Z > 0
				if(onScreen) then
					local raycastResult = workspace:Raycast(camera.CFrame.Position,(adornee.Position - camera.CFrame.Position),raycastParams)
					local isVisible = not raycastResult
					gui.AlwaysOnTop = isVisible
				else
					gui.AlwaysOnTop = false
				end
			end))
		end
		local onCharacter = function(character)
			gui = ui.billboard.new(tostring(player.UserId))
			gui.Parent = containerGui
			gui.Adornee = character:WaitForChild("Head")
			gui.StudsOffset = Vector3.new(0,isLocalPlayer and 3.5 or 4,isLocalPlayer and 2 or 0.1)
			typingIndicator = ui.typingIndicator.new(gui.Container)
			typingIndicator.Visible = false
			stack = stackModule.new(gui)
			linked[character] = gui
			if(useRaycastingToDetermineVisibility) then
				linkAlwaysOnTop(gui,gui.Adornee)
			end
		end
		local onRemoving = function(character)
			if(linked[character]) then
				linked[character]:Destroy()
				linked[character] = nil
				stack:Destroy()
				lastState = nil
			end
		end
		link(player.CharacterAdded:Connect(onCharacter))
		link(player.CharacterRemoving:Connect(onRemoving))
		if(player.Character) then
			task.spawn(onCharacter,player.Character)
		end
		if(config.Config.TypingIndicator) then
			link(network.onClientEvent("typingIndicator",function(p,state) 
				if(p == player and p.Character) then
					typingIndicator.Visible = state
					if(lastState ~= state) then
						lastState = state
						if(state) then
							stack:push(typingIndicator,true)
						else
							stack:remove(typingIndicator)
						end
					end
				end 
			end))
		end
		
		environment.betterchatv3bubbles = {}
		
		link(network.onClientEvent("editMessage",function(data)
			if(environment.betterchatv3bubbles[data.guid]) then
				if data.deleted then
					stack:remove(environment.betterchatv3bubbles[data.guid],true)
					stack:fade(environment.betterchatv3bubbles[data.guid],0)
				end
			end
		end))

		link(network.onClientEvent("receiveMessage",function(data)
			if(data.is_singular and data.messages[1].player == player and (environment.bubbleChatEnabled) and player.Character) then
				local markdownEnabled = data.messages[1]["markdownEnabled"]
				local msg = data.messages[1]["message"]
				if(not environment.mutelist[player.UserId]) then
					local bubble = ui.bubble.new(
						markdownEnabled and environment.richText:markdown(msg) or environment.richText:escape(msg)
						,gui.Container)
					environment.betterchatv3bubbles[data.messages[1].guid] = bubble
					stack:push(
						bubble,false,data.messages[1]["guid"]						
					)
				end
			end
		end))
	end
end

return billboard