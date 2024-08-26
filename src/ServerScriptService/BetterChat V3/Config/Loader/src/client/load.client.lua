-- Author: @Jumpathy
-- Name: start.lua
-- Description: Chat system start on client

local replicatedStorage = game:GetService("ReplicatedStorage")
local userInput = game:GetService("UserInputService")
local guiService = game:GetService("GuiService")
local runService = game:GetService("RunService")
local chatService = game:GetService("Chat")
local players = game:GetService("Players")
local heartbeat = runService.Heartbeat

-- platform:

local scaleToOffset = function(size)
	local viewportSize = workspace.CurrentCamera.ViewportSize
	return(UDim2.fromOffset(
		math.clamp((viewportSize.X * size.X.Scale) + size.X.Offset,50,math.huge),
		math.clamp((viewportSize.Y * size.Y.Scale) + size.Y.Offset,50,math.huge)
	))
end

local platform = function()
	if(userInput.TouchEnabled) then
		return((workspace.CurrentCamera.ViewportSize.Y < 600) and "Phone" or "Tablet")
	else
		return(guiService:IsTenFootInterface() and "Console" or "Desktop")
	end
end

local currentPlatform = platform()
if(currentPlatform ~= "Console") then
	-- wait for server:

	local betterchat_shared = replicatedStorage:WaitForChild("betterchat_shared")
	local network = require(betterchat_shared:WaitForChild("network"))
	local addons = betterchat_shared:WaitForChild("addons"):WaitForChild("Client")
	local signal = require(betterchat_shared:WaitForChild("signal"))
	local wrap = require(betterchat_shared:WaitForChild("wrap"))
	
	-- info:
	
	local debugMode = betterchat_shared:GetAttribute("debugMode")
	
	-- client:

	local container = script.Parent
	local modules = container:WaitForChild("modules")
	local core = modules:WaitForChild("core")

	local connections = require(core:WaitForChild("connections"))
	local privacy = require(modules:WaitForChild("privacy"))
	local bubbleChat = require(modules:WaitForChild("bubbleChat"):WaitForChild("main"))
	local settingsMenu = require(core:WaitForChild("settingsMenu"))
	
	local localPlayer = game:GetService("Players").LocalPlayer
	local playerGui = localPlayer.PlayerGui
	
	if(not privacy.chatDisabled) then

		-- change:
		
		local elements = core:WaitForChild("elements")
		local gui = require(elements:WaitForChild("chatGui"))()
		gui.Parent = playerGui
		
		local container = gui:WaitForChild("Container")
		
		local chatbarContainer = container:WaitForChild("ChatBarContainer"):WaitForChild("Main")
		local chatbox = chatbarContainer:WaitForChild("Container"):WaitForChild("Box"):WaitForChild("Input")
		local config = network:invoke("requestConfig")
		
		local environment = {
			utility = require(core:WaitForChild("utility")),
			localization = require(core:WaitForChild("localization"))(),
			richText = require(betterchat_shared:WaitForChild("formatting"):WaitForChild("richText"))(config),
			connections = connections,
			network = network,
			config = config,
			messages = {},
			main_ui = container,
			lastRefresh = tick(),
			gui = gui,
			container = container,
			addons = addons,
			signal = signal,
			betterchat_shared = betterchat_shared,
			onEmoji = signal.new(),
			interceptions = {},
			addToCache = {}
		}
		
		environment.config.UI.ColorOptions = environment.config.UI.ColorOptions or {
			ChatbarColor = Color3.fromRGB(255,255,255),
			Buttons = {
				ResizeButton = { --> UI resize button
					BackgroundColor = Color3.fromRGB(52,52,52),
					IconColor = Color3.fromRGB(255,255,255)
				},
				ChannelButton = { --> Channel bar channel buttons: (also autofill too lol)
					BackgroundColor = Color3.fromRGB(0,0,0),
					TextColor = Color3.fromRGB(255,255,255)
				},
				AutofillButton = { --> Autofill buttons
					BackgroundColor = Color3.fromRGB(30,30,30),
					TextColor = Color3.fromRGB(255,255,255)
				},
				ReplyAndChannel = { --> On the chatbar, when whispering or replying this icon shows up
					BackgroundColor = Color3.fromRGB(253,80,111), --> 253,80,111
					TextAndIconColor = Color3.fromRGB(255,255,255)
				}
			},
			Window = {
				BackgroundColor = Color3.fromRGB(0,0,0),
			}
		}
		
		-- channel bar:
		
		function environment:getTextSize()
			return chatbox.TextSize
		end
		
		environment.doDestroy = function(object)
			object.Parent = nil
			local class = object:GetAttribute("Class")
			if(class == "regular") then
				environment.addToCache[class](object)
			end
		end
		
		environment.processData = function(messageData,origin)
			for _,interception in pairs(environment.interceptions) do
				interception(messageData,origin)
			end
			return messageData
		end
		
		local channelBarEnabled = environment.config.UI.ChannelBarEnabled
		if(channelBarEnabled) then
			container:WaitForChild("Channelbar").Visible = true
		end
		environment.channelBarUi = container.Channelbar:WaitForChild("Main"):WaitForChild("Container"):WaitForChild("Scroller")

		
		-- bubble:
		
		local label = Instance.new("TextLabel")
		label.RichText = true
		
		local getTextContent = function(text)
			label.Text = text
			return label.ContentText
		end
		environment.bubbleChatEnabled = false
		environment.bubbleChatConfig = environment.config.BubbleChat.Config
		
		if(environment.config.BubbleChat.Enabled) then
			bubbleChat.init(environment.config.BubbleChat,environment.network,environment)
			environment.bubbleChatEnabled = true
		elseif(chatService.BubbleChatEnabled) then
			local config = environment.config.BubbleChat.Config
			local getUserSettings = function(player)
				return {
					BackgroundColor3 = player:GetAttribute("BubbleBackgroundColor") or config.BubbleBackgroundColor ,
					TextColor3 = player:GetAttribute("BubbleTextColor") or config.BubbleTextColor,
					TextSize = player:GetAttribute("TextSize") or config.TextSize,
					["Font"] = Enum.Font[player:GetAttribute("BubbleFont") or config.BubbleFont.Name],
					["CornerRadius"] = UDim.new(0,player:GetAttribute("BubbleRoundness") or config.Roundness),
					["BubbleDuration"] = config.FadeoutTime
				}
			end
			local userSpecificSettings = {}
			network.onClientEvent("receiveMessage",function(data)
				if(data.is_singular) then
					local player = data.messages[1].player
					if(player and player.Character) then
						if(environment.config.BubbleChat.ApplyValidConfigToDefaultBubbleChat) then
							for _,user in pairs(players:GetPlayers()) do
								userSpecificSettings[user.UserId] = getUserSettings(user)
							end
							chatService:SetBubbleChatSettings({
								UserSpecificSettings = userSpecificSettings --> (roblox decides to deep copy tables and i dont think changes will replicate)
							})
						end
						chatService:Chat(player.Character,getTextContent(environment.richText:markdown(data.messages[1]["message"])))
					end
				end
			end)
		end
		
		task.spawn(function()
			if(environment.config.SettingsMenu.Enabled) then
				-- settings menu:
				settingsMenu(environment)
			end
		end)
		
		-- util
		
		local message_senders
		
		task.spawn(function()
			local saveChat = gui:WaitForChild("SaveChat")
			local container = saveChat:WaitForChild("Container")
			local button = container:WaitForChild("Slot"):Clone()
			container.Slot:Destroy()

			local close = function()
				environment.tweenPosition(saveChat,UDim2.fromScale(0.5,-1.5),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.25,true)
			end

			function environment:openSaveChat(message)
				saveChat.Position = UDim2.fromScale(0.5,-1.5)
				environment.tweenPosition(saveChat,UDim2.fromScale(0.5,0.5),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.25,true)

				for _,child in pairs(container:GetChildren()) do
					if(child:IsA("TextButton")) then
						child:Destroy()
					end
				end

				for i = 1,20 do
					local option = button:Clone()
					option.Parent = container
					option.Text = ("Slot %s"):format(i)
					environment.utility:linkObjectSignals(option,{
						option.MouseButton1Click:Connect(function()
							task.spawn(function()
								environment:saveToSlot(i,message)
								message_senders.makeSm(("You can now say '/%s' to send that message again"):format(i))
							end)
							close()
						end)
					})
				end
			end

			saveChat:WaitForChild("Header"):WaitForChild("UI"):WaitForChild("Close").MouseButton1Click:Connect(close)
		end)
		
		-- prefixes internal:
		
		function environment:generateReplyCode(id)
			return("reply_"..id)
		end
		
		-- setup:
		
		local chatWindowVisible = environment.config.UI.ChatWindowVisible
		local chatSizes = environment.config.UI.ChatSizes
		local chatModules = require(core:WaitForChild("chat"))(environment)
		local chatbar = chatModules.chatbar:setup(chatbarContainer,chatbox)
		local chatWindow = chatModules.chatWindow:setup(container,chatbar)
		environment.chatWindowVisible = chatWindowVisible
		
		if(not chatWindowVisible) then
			container.ChatBarContainer.Position = UDim2.new(0,0,0,0)
			container.ChatBarContainer.AnchorPoint = Vector2.new(0,0)
			container.ChatWindow.Visible = false
		end

		-- scale:
		
		local baseSize = scaleToOffset(chatSizes[currentPlatform])
		local lastScale
		container.Size = baseSize

		workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			local key = tick()
			lastScale = key
			runService.Heartbeat:Wait()
			if(lastScale == key) then
				if not environment.stopSizing then
					local newSize = scaleToOffset(chatSizes[currentPlatform])
					local sizeDiff = baseSize - newSize
					container.Size = (newSize + sizeDiff)
					baseSize = newSize
				end
			end
		end)
	
		environment.utility.descendantOfClassAdded(gui,"UICorner",function(corner)
			local roundness = environment.config.UI.Rounding
			if(corner.Name ~= "Ignore") then
				corner.CornerRadius = UDim.new(0,roundness)
			end
		end)
		
		function environment:refreshRounding()
			local roundness = environment.config.UI.Rounding
			for _,object in pairs(gui:GetDescendants()) do
				if(object:IsA("UICorner") and object.Name ~= "Ignore") then
					object.CornerRadius = UDim.new(0,roundness)
				end
			end
		end
		
		-- text scale
		
		local ogTextSizes = {}
		local lastTextSize = environment.config.UI.BaseTextSize
		local base = lastTextSize
		
		local scale = function(obj,original)
			pcall(function()
				local difference = (lastTextSize - base)
				obj.TextSize = original + difference
			end)
		end
		
		function environment:setTextSize(new)
			lastTextSize = new
			for object,original in pairs(ogTextSizes) do
				task.spawn(scale,object,original)
			end
		end
		
		for _,obj in pairs(gui:GetDescendants()) do
			local success,hasTextSize = pcall(function()
				return obj["TextSize"]
			end)
			if(success and hasTextSize) then
				if(not ogTextSizes[obj]) then
					ogTextSizes[obj] = obj.TextSize
				end
			end
		end
		
		gui.DescendantAdded:Connect(function(obj)
			local success,hasTextSize = pcall(function()
				return obj["TextSize"]
			end)
			if(success and hasTextSize) then
				if(not ogTextSizes[obj]) then
					ogTextSizes[obj] = obj.TextSize
				end
			end
			scale(obj,ogTextSizes[obj])
		end)

		-- message:

		local messages = core:WaitForChild("messages")
		local queue = {}

		message_senders = {
			reply = require(messages:WaitForChild("reply"))(environment),
			system = require(messages:WaitForChild("system"))(environment,queue),
			default = require(messages:WaitForChild("default"))(environment),
			makeSm = function(message,override)
				if not override then
					message_senders.system(
						unpack(environment.localization:produceSystemMessage(message))
					)
				else
					message_senders.system("",message)
				end
				environment:checkScrollerPos(false,0)
			end,
		}

		environment.message_senders = message_senders

		-- received:

		local scroller = environment.mainUi.scroller
		local realScroller = scroller.Parent
		local messageLimit = environment.config.Messages.ChannelMessageLimit

		local clearScroller = function()
			for k,v in pairs(queue) do
				table.remove(queue,k)
			end
			for _,child in pairs(scroller:GetChildren()) do
				if(child:IsA("Frame")) then
					environment.doDestroy(child)
				end
			end
		end
		
		local count = 0
		local currentChannel

		local onMessage = function(message)
			count += 1
			connections:Fire("ChatWindow","MessagesChanged",count)
		end

		local handleDeletionOfOldMessages = function()
			if(#queue > messageLimit) then
				local idx = #queue
				local obj = queue[idx]
				environment.doDestroy(obj)
				table.remove(queue,idx)
			end
		end
		
		function environment:sendSystemMessage(text)
			local object = message_senders.system("",text)
			table.insert(queue,1,object)
		end
		
		local getObject = function(data)
			if(data.class == "regular") then
				return message_senders.default(data)
			elseif(data.class == "reply") then
				return message_senders.reply(data,queue)
			end
		end
		
		local onCreated = function(object,data,extra)
			environment.messages[data.id] = {
				object = object,
				data = data,
				extra = extra
			}
		end
		
		local mutelist = {}
		local canMuteSelf = true
		environment.mutelist = mutelist
		
		local createNewMessage = function(data) -- this function initiates every message ever sent :eyes:
			if(mutelist[data.senderId]) then
				return
			end
			local existingMessageById = environment.messages[data.id]
			if(existingMessageById) then
				if(data.class == "reply") then
					existingMessageById.extra.replace(data,queue)
				else
					local api = environment:checkThread(data.id)
					if(api) then
						api:editBaseMessage(data)
					end
					local currentKey = table.find(queue,existingMessageById.object)
					if(currentKey) then
						local object = getObject(data)
						onCreated(object,data)
						queue[currentKey] = object
						existingMessageById.object:Destroy()
					end
				end
			else
				local object,extra = getObject(data)
				onCreated(object,data,extra)
				table.insert(queue,1,object)
				onMessage(object)
			end
			handleDeletionOfOldMessages()
		end
		
		local muteKeys = {
			[false] = "GameChat_ChatMain_SpeakerHasBeenUnMuted",
			[true] = "GameChat_ChatMain_SpeakerHasBeenMuted",
			["failed"] = "GameChat_DoMuteCommand_CannotMuteSelf"
		}
		
		local announceMute = function(player,state)
			message_senders.makeSm(environment.localization:localize(muteKeys[state]):format(player.Name))
		end
		
		function environment:mute(player)
			if(localPlayer == player and (not canMuteSelf)) then
				message_senders.makeSm(environment.localization:localize(muteKeys["failed"]))
				return
			end
			mutelist[player.UserId] = true
			announceMute(player,true)
		end
		
		function environment:deleteMessage(message)
			network:fire("deleteMessage",message.id,message.channelFrom)
		end
		
		function environment:unmute(player)
			if(localPlayer == player and (not canMuteSelf)) then
				return
			end
			mutelist[player.UserId] = false
			announceMute(player,false)
		end
		
		local includeBeginningMessageAndScroll = function(id)
			local sm = message_senders.system(unpack(environment.localization:getWelcomeMessage(id)))
			table.insert(queue,sm)
			onMessage(sm)
			environment:checkScrollerPos(true,0)
		end
		
		environment.channelChanged = signal.new()
		local batchCount = 0
		
		local refreshHistory = function(channel)
			batchCount += 1
			currentChannel = channel
			local received = network:invoke("requestHistory",channel)
			environment.lastRefresh = tick()
			local current = environment.lastRefresh
			environment.messages = {}
			environment.threads = {}
			heartbeat:Wait()
			clearScroller()
			local last = 0
			local key = 0
			for _,data in pairs(received.messages) do
				environment.processData(data,"chat")
				key += 1
				if(data.id ~= nil) then
					last = data.id
				end
					if(not data.replyingTo) then
						data.massMessageLoad = true
						createNewMessage(data)
					else
						data.massMessageLoad = true
						repeat
							runService.Heartbeat:Wait()
						until(environment.messages[data.replyingTo.id])
						if(environment.lastRefresh == current) then
							createNewMessage(data)
						end
					end
				-- chunking (makes loading much faster, as well as optimizations to only load the message function after the mouse hovers on it)
				if(key == 10) then
					task.wait(0.05)
					key = 0
				end
			end
			includeBeginningMessageAndScroll((last or 9999)+1)
			environment.channelChanged:Fire(channel)
		end
		
		local onMessageReceived = function(received) --> this message will handle every single message ever displayed in the chat, kinda crazy tbh
			for _,data in pairs(received.messages) do
				if debugMode then
					local current = batchCount
					print("[BetterChat]: Creating",data.id,"for batch",current)
				end
				data = environment.processData(data,"chat")
				task.spawn(function()
					if(channelBarEnabled) then
						if(currentChannel == data.channelFrom) then
							createNewMessage(data)
						elseif(data.filteredSuccessfully) then
							environment:addNotificationToChannel(data.channelFrom)
						end
					else
						createNewMessage(data)
					end
				end)
			end
		end

		network.onClientEvent("receiveMessage",onMessageReceived)
		network.onClientEvent("receiveMessageCreation",onMessageReceived)
		network.onClientEvent("editMessage",createNewMessage)
		
		local doFormat = function(number) -- written by: waves5217 (@https://devforum.roblox.com/t/help-with-floating-point-errors/2474289/3)
			local formatted = string.format("%.3f", number) --> omit to three decimals
			formatted = formatted:gsub("%.?0+$", "") --> remove the dot and trailing zeroes
			return tonumber(formatted)
		end

		function environment:atBottom()
			return(doFormat(realScroller.CanvasPosition.Y) == doFormat(realScroller.AbsoluteCanvasSize.Y - realScroller.AbsoluteSize.Y))
		end

		function environment:checkScrollerPos(bypass,len)
			if(doFormat(realScroller.CanvasPosition.Y) == doFormat(realScroller.AbsoluteCanvasSize.Y - realScroller.AbsoluteSize.Y) or bypass) then
				task.spawn(function()
					heartbeat:Wait()
					environment.utility:tween({realScroller,(len or 0.25),{
						["CanvasPosition"] = Vector2.new(0,doFormat(realScroller.AbsoluteCanvasSize.Y))
					}})
				end)
			end
		end

		function environment:addMessageToQueue(message)
			onMessage(message)
			table.insert(queue,1,message)
			handleDeletionOfOldMessages()
		end

		function environment:fetchChannelHistory(channelName)
			environment.currentChannel = channelName
			refreshHistory(channelName)
		end
		
		-- core ui:

		local chatOpenState = false
		local locked = false
		
		local toggleChatState = function()
			if(locked) then
				return
			end
			connections:Fire("ChatWindow","VisibilityStateChanged",(not chatOpenState))
			chatOpenState = not chatOpenState
			container.Visible = chatOpenState
		end
		
		function environment:setChatOpenState(state)
			chatOpenState = state
		end
		
		function environment:setChatLocked(state)
			locked = state
		end
		
		connections:Connect("ChatWindow","ToggleVisibility",toggleChatState)
		toggleChatState()
		
		connections:Connect("ChatWindow","CoreGuiEnabled",function(state)
			container.Visible = state
		end)
				
		-- notifiers
		
		local players = game:GetService("Players")
		local starterGui = game:GetService("StarterGui")
		local notifiers = environment.config.Notifiers
		
		if(notifiers.FriendJoinNotifier) then
			players.PlayerAdded:Connect(function(plr)
				if(plr:IsFriendsWith(localPlayer.UserId)) then
					message_senders.makeSm(environment.localization:localize("GameChat_FriendChatNotifier_JoinMessage"):format(plr.Name))
				end
			end)
		end
		
		if(notifiers.TeamChangeNotifier) then
			local changed = function(name)
				message_senders.makeSm(environment.localization:localize("GameChat_TeamChat_NowInTeam"):format(name))
			end
			localPlayer:GetPropertyChangedSignal("Team"):Connect(function()
				local teamName = localPlayer.Team and localPlayer.Team.Name or "Neutral"
				changed(teamName)
			end)
		end
		
		if(notifiers.BlockedUserNotifier) then
			local blockKeys = {
				["blocked"] = "GameChat_ChatMain_SpeakerHasBeenBlocked",
				["unblocked"] = "GameChat_ChatMain_SpeakerHasBeenUnBlocked"
			}
			
			local blockEvents = {
				["blocked"] = starterGui:GetCore("PlayerBlockedEvent"),
				["unblocked"] = starterGui:GetCore("PlayerUnblockedEvent")
			}
			
			for keyToTrigger,event in pairs(blockEvents) do
				event.Event:Connect(function(player)
					message_senders.makeSm(environment.localization:localize(blockKeys[keyToTrigger]):format(player.Name))
				end)
			end
		end
		
		-- custom commands
		
		environment.utility.childAdded(addons:WaitForChild("Commands"),function(command)
			command.Parent = core:WaitForChild("commands"):WaitForChild("list")
		end)
		
		-- plugins
		
		local api = require(core:WaitForChild("api"))(environment,wrap,connections)
		environment.utility.childAdded(addons:FindFirstChild("Plugins") or Instance.new("Folder"),function(module)
			require(module)(api)
		end)
	end
end