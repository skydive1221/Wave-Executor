-- Author: @Jumpathy
-- Name: billboard.lua
-- Description: Billboard gui for bubble chat lol
-- Small credits:
-- @McThor2 - [Math help](https://devforum.roblox.com/t/raycast-between-2-attachments/976915/8)
-- @sleitnick - [Raycasting help](https://devforum.roblox.com/t/detect-if-player-is-looking-at-object/1479746/5)

local billboard = {}
local useRaycastingToDetermineVisibility = true
local collectionService = game:GetService("CollectionService")
local connections = {}

local onDescendant = function(object,callback)
	for _,descendant in pairs(object:GetDescendants()) do
		task.spawn(callback,descendant)
	end
	return object.DescendantAdded:Connect(callback)
end

function billboard.init(config,network,environment)
	local httpService = game:GetService("HttpService")

	environment.holstered = {}
	local ui = require(script.Parent:WaitForChild("ui")).init(config)
	local stackModule = require(script.Parent:WaitForChild("stack"))(environment).init(config)
	local padding = config.Config.Padding
	local camera = workspace.CurrentCamera
	local billboardData = {}

	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer

	local containerGui = Instance.new("ScreenGui")
	containerGui.Name = "bubbleChat"
	containerGui.Parent = localPlayer.PlayerGui
	containerGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	containerGui.ResetOnSpawn = false
	environment.bubbleChatContainer = containerGui

	local linkAlwaysOnTop = function(gui,adornee)
		local raycastParams = RaycastParams.new()
		raycastParams.IgnoreWater = true
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = {adornee.Parent}
		billboardData[gui] = {
			adornee = adornee,
			params = raycastParams
		}
	end

	camera.Changed:Connect(function()
		for gui,billboard in pairs(billboardData) do
			if gui:GetFullName() == gui.Name or billboard.adornee:GetFullName() == billboard.adornee.Name then
				billboardData[gui] = nil
			else
				local result = (billboard.adornee.Position - camera.CFrame.Position)
				if(result.magnitude < gui.MaxDistance) then
					local vector,inViewport = camera:WorldToViewportPoint(billboard.adornee.Position)
					local onScreen = inViewport and vector.Z > 0
					if(onScreen) then
						local raycastResult = workspace:Raycast(camera.CFrame.Position,result,billboard.params)
						gui.AlwaysOnTop = not raycastResult
					else
						gui.AlwaysOnTop = false
					end
				end
			end
		end
	end)

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

		local onCharacter = function(character)
			gui = ui.billboard.new(tostring(player.UserId),player)
			gui.Parent = containerGui
			gui.Adornee = character:WaitForChild("Head")
			gui.StudsOffset = Vector3.new(0,isLocalPlayer and 9.5 or 10.5,isLocalPlayer and 2 or 0.1)

			typingIndicator = ui.typingIndicator.new(gui.Container)
			typingIndicator.Visible = false
			stack = stackModule.new(gui)
			linked[character] = gui

			if(useRaycastingToDetermineVisibility) then
				linkAlwaysOnTop(gui,gui.Adornee)
			end

			local objs = {}

			local newColor = function(obj,propertyName)
				local bgColor = player:GetAttribute("BubbleBackgroundColor")
				local indicatorColor = player:GetAttribute("TypingIndicatorColor")
				local textColor = player:GetAttribute("BubbleTextColor")

				if(obj and obj:GetFullName() ~= obj.Name) then
					if obj:GetAttribute("TypingIndicator") then
						obj[propertyName] = indicatorColor
					else
						local success,hasText = pcall(function()
							return obj.Text
						end)
						if success then
							obj["TextColor3"] = textColor
						else
							obj[propertyName] = bgColor
						end
					end
				else 
					objs[obj] = nil
				end
			end

			connections[character] = connections[character] or {}

			table.insert(connections[character],onDescendant(gui,function(object)
				pcall(function()
					if object.BackgroundColor3 then
						objs[object] = "BackgroundColor3"
						if object.ImageColor3 and not object:GetAttribute("IsEmoji") then
							objs[object] = "ImageColor3"
						end
					end
				end)
				if objs[object] then
					newColor(object,objs[object])
				end
			end))

			local update = function()
				for obj,property in pairs(objs) do
					newColor(obj,property)
				end
			end

			table.insert(connections[character],player:GetAttributeChangedSignal("BubbleBackgroundColor"):Connect(update))
			table.insert(connections[character],player:GetAttributeChangedSignal("TypingIndicatorColor"):Connect(update))
			table.insert(connections[character],player:GetAttributeChangedSignal("BubbleTextColor"):Connect(update))
		end

		local onRemoving = function(character)
			if(linked[character]) then
				linked[character]:Destroy()
				linked[character] = nil
				stack:Destroy()
				lastState = nil
				if connections[character] then
					for _,connection in pairs(connections[character]) do
						connection:Disconnect()
					end
					connections[character] = nil
				end
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
					if(lastState ~= state) then
						lastState = state
						if(state and p:GetAttribute("TypingIndicatorEnabled")) then
							typingIndicator.Visible = true
							stack:push(typingIndicator,true)
						else
							typingIndicator.Visible = false
							stack:remove(typingIndicator)
						end
					end
				end 
			end))
		end

		environment.betterchatv3bubbles = {}
		environment.stacks = {}

		link(network.onClientEvent("editMessage",function(data)
			if(environment.betterchatv3bubbles[data.guid]) then
				local stack = environment.stacks[data.guid]
				if not stack then
					return
				end
				stack:remove(environment.betterchatv3bubbles[data.guid],true)
				stack:fade(environment.betterchatv3bubbles[data.guid],0)					
				if not data.deleted then
					local text = data.message .. environment.editedStamp
					local guid = data.guid

					if data.customEmojis then
						local sample = ui.bubble.new(text,gui.Container)
						text = environment:processEmojis(sample.Label,data,text)
						sample:Destroy()
					end

					local bubble = ui.bubble.new(text,gui.Container)
					environment.betterchatv3bubbles[guid] = bubble
					stack:push(
						bubble,false,guid					
					)

					if(data.customEmojis) then	
						environment:attachCustomEmojis(bubble.Label,text,data.customEmojis,data.spacing,function(pos)
							pos += UDim2.fromOffset(padding,padding)
							return pos
						end)
					end
				end
			end
		end))

		link(network.onClientEvent("receiveMessage",function(data)
			if(data.is_singular and data.messages[1].player == player and (environment.bubbleChatEnabled) and player.Character) then
				data.messages[1] = environment.processData(data.messages[1],"bubbleChat")
				local markdownEnabled = data.messages[1]["markdownEnabled"]
				local data = data.messages[1]
				local msg = data["message"]
				if(not environment.mutelist[player.UserId]) then
					local text = markdownEnabled and environment.richText:markdown(msg) or environment.richText:escape(msg)
					if(data.customEmojis) then
						local sample = ui.bubble.new(text,gui.Container)
						text = environment:processEmojis(sample.Label,data,msg)
						sample:Destroy()
					end
					local bubble = ui.bubble.new(text,gui.Container)
					environment.betterchatv3bubbles[data.guid] = bubble
					environment.stacks[data.guid] = stack
					stack:push(
						bubble,false,data["guid"]						
					)
					if(data.customEmojis) then
						environment:attachCustomEmojis(bubble.Label,msg,data.customEmojis,data.spacing,function(pos)
							pos += UDim2.fromOffset(padding,padding)
							return pos
						end)
					end
				end
			end
		end))

		environment.holstered[player] = {
			setTypingIndicatorVisible = function(self,state)
				typingIndicator.Visible = state
				if(lastState ~= state) then
					lastState = state
					if(state) then
						stack:push(typingIndicator,true)
					else
						stack:remove(typingIndicator)
					end
				end
			end,
			createMessage = function(self,text)
				local revisible = false
				if lastState then
					revisible = true
					environment.holstered[player]:setTypingIndicatorVisible(false)
				end
				local guid = httpService:GenerateGUID()
				local bubble = ui.bubble.new(text,gui.Container)
				environment.betterchatv3bubbles[guid] = bubble
				environment.stacks[guid] = stack
				stack:push(
					bubble,false,guid					
				)
				if revisible then
					environment.holstered[player]:setTypingIndicatorVisible(true)
				end
			end,
			getUi = function()
				return ui
			end,
		}
	end

	function billboard:create(part,adornee,options)
		options = options or {}
		local gui = ui.billboard.new(httpService:GenerateGUID())
		gui.Parent = containerGui
		gui.Adornee = adornee or part
		gui.StudsOffset = Vector3.new(0,10.5,0.1)

		local typingIndicator = ui.typingIndicator.new(gui.Container)
		typingIndicator.Visible = false

		if(useRaycastingToDetermineVisibility) then
			linkAlwaysOnTop(gui,gui.Adornee)
		end

		local objs = {}

		local bubbleBackgroundColor = config.Config.BubbleBackgroundColor
		local typingIndicatorColor = config.Config.TypingIndicatorColor
		local bubbleTextColor = config.Config.BubbleTextColor

		local newColor = function(obj,propertyName)
			local bgColor = bubbleBackgroundColor
			local indicatorColor = typingIndicatorColor
			local textColor = bubbleTextColor

			if(obj and obj:GetFullName() ~= obj.Name) then
				if obj:GetAttribute("TypingIndicator") then
					obj[propertyName] = indicatorColor
				else
					local success,hasText = pcall(function()
						return obj.Text
					end)
					if success then
						obj["TextColor3"] = textColor
					else
						obj[propertyName] = bgColor
					end
				end
			else 
				objs[obj] = nil
			end
		end

		onDescendant(gui,function(object)
			pcall(function()
				if object.BackgroundColor3 then
					objs[object] = "BackgroundColor3"
					if object.ImageColor3 and not object:GetAttribute("IsEmoji") then
						objs[object] = "ImageColor3"
					end
				end
			end)
			if objs[object] then
				newColor(object,objs[object])
			end
		end)

		local update = function()
			for obj,property in pairs(objs) do
				newColor(obj,property)
			end
		end

		local stack = stackModule.new(gui,{
			FadeoutTime = options.FadeoutTime or config.Config.FadeoutTime,
			MaxMessages = options.MaxMessages or config.Config.MaxMessages,
			EasingStyle = options.EasingStyle or config.Config.EasingStyle,
			Length = options.Length or config.Config.Length
		})

		local lastState = false

		return {
			createMessage = function(self,text)
				local revisible = false
				if lastState then
					revisible = true
					self:setTypingIndicatorVisible(false)
				end
				local guid = httpService:GenerateGUID()
				local bubble = ui.bubble.new(text,gui.Container)
				environment.betterchatv3bubbles[guid] = bubble
				environment.stacks[guid] = stack
				stack:push(
					bubble,false,guid					
				)
				if revisible then
					self:setTypingIndicatorVisible(true)
				end
				return {
					Destroy = function()
						stack:fade(bubble)
						stack:remove(bubble)
					end
				}
			end,
			setColors = function(self,colors)
				bubbleBackgroundColor = colors.BubbleBackgroundColor or bubbleBackgroundColor
				typingIndicatorColor = colors.TypingIndicatorColor or typingIndicatorColor
				bubbleTextColor = colors.BubbleTextColor or bubbleTextColor
				update()
			end,
			setTypingIndicatorVisible = function(self,state)
				typingIndicator.Visible = state
				if(lastState ~= state) then
					lastState = state
					if(state) then
						stack:push(typingIndicator,true)
					else
						stack:remove(typingIndicator)
					end
				end
			end,
			getUi = function()
				return gui
			end,
		}
	end
end

return billboard