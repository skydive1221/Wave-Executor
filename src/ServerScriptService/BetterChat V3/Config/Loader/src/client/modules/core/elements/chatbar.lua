-- Author: @Jumpathy
-- Name: chatbar.lua
-- Description: Set up the chatbar :D

local textService = game:GetService("TextService")
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local players = game:GetService("Players")
local chatService = game:GetService("Chat")
local collectionService = game:GetService("CollectionService")

local localPlayer = players.LocalPlayer
local heartbeat = runService.Heartbeat
local space = string.char(32)
local history = require(script.Parent.Parent:WaitForChild("history"))
local autofillFolder = script.Parent.Parent:WaitForChild("autofill")
local initCommandProcessor = require(script.Parent.Parent:WaitForChild("commands"):WaitForChild("processor"))
local autofillModule = require(autofillFolder:WaitForChild("autofill"))
local autofillManager = require(autofillFolder:WaitForChild("manager"))
local autofillListFolder = autofillFolder:WaitForChild("autofills")
local extraData

local getWhisperChannel = function(id)
	local array = {math.abs(id),math.abs(localPlayer.UserId)}
	table.sort(array)
	return "whisper_" .. table.concat(array,"_")
end

return function(environment)
	-------- Variables: --------

	local utility,connections,localization = environment.utility,environment.connections,environment.localization
	local chatbar,messageHistory = {},{}
	local pointer,padding,idx = 0,4,0
	local chatbarContainer,chatbox,count,chatboxApi = nil,nil,nil,nil
	local commandProcessor = initCommandProcessor(environment)
	local separate = environment.config.UI.SeparateChatbarFromMenu

	-------- Functions: --------

	function environment:getExtraData()
		return extraData
	end

	local fixWhitespace = function(message)
		local disallowedWhitespace = environment.config.Messages.DisallowedWhitespace
		for _,character in pairs(disallowedWhitespace) do
			if(character == "\t") then
				message = message:gsub(character,string.char(32))
			else
				message = message:gsub(character,"")
			end
		end
		message = message:gsub("\n","")
		message = message:gsub("[ ]+"," ")
		return message
	end

	local getRawTextSizeInPx = function(chatbox,text,inf)
		local text,textSize,font = (text or chatbox.Text),chatbox.TextSize,chatbox.Font
		local sizeClamp = Vector2.new((inf and math.huge or chatbox.AbsoluteSize.X),math.huge)
		return textService:GetTextSize(text,textSize,font,sizeClamp)
	end

	local setplaceholderText = function(message)
		chatbox.PlaceholderText = message or chatbox.PlaceholderText
	end
	
	local process = function(message)
		if environment.config.Messages.RemoveFormattingForChattedEvent then
			message = environment.richText:markdown(message,true)
			message = environment.richText:strip(message)
			connections:Fire("ChatWindow","MessagePosted",message)
		else
			connections:Fire("ChatWindow","MessagePosted",message)
		end
	end

	local sendMessage = function(message)
		table.insert(messageHistory,1,message)
		if(#messageHistory >= 100) then
			table.remove(messageHistory,#messageHistory)
		end
		chatbox.Text = chatboxApi:CalculateText("")
		local isCommand = commandProcessor:parse(message)
		if(not isCommand) then
			local success,hasResponse,localizationData = environment.network:invoke("requestMessage",fixWhitespace(message),environment.currentChannel,extraData)
			if(hasResponse and (not success)) then
				environment:addMessageToQueue(environment.message_senders.makeSm(localization:localizeResponse(unpack(localizationData))))
			elseif(success) then
				process(message)
			end
		else
			process(message)
		end
	end

	function environment:onEdit(message)
		connections:Fire("ChatWindow","MessagePosted",message)
	end

	local base = function()
		return(chatbox.TextSize * (2 + 1/3))
	end

	-------- Setup: --------

	function chatbar:setup(a,b)
		chatbarContainer,chatbox = a,b

		local autofill = autofillModule(environment,chatbox)
		local resize = chatbox.Parent.Parent:WaitForChild("Resize")
		local icon = resize:WaitForChild("Icon")
		local channelButton = resize.Parent:WaitForChild("Container"):WaitForChild("Channel")
		local label = channelButton:WaitForChild("Label")
		local offset = 10
		local single,isReply = nil,nil
		environment.currentChannel = "Main"

		local colorOptions = environment.config.UI.ColorOptions
		channelButton.ReplyIcon.ImageColor3 = colorOptions.Buttons.ReplyAndChannel.TextAndIconColor
		channelButton.BackgroundColor3 = colorOptions.Buttons.ReplyAndChannel.BackgroundColor

		function environment:setChannel(name,is,display,extra)
			extraData = extra
			environment.currentChannel = name
			isReply = is
			channelButton.ReplyIcon.Visible = (is == true)

			if(not isReply) then
				if(not name) then
					channelButton.Visible = false
				else
					label.Text = (display or name)
					channelButton.Visible = true
				end
			else
				label.Text = ""
				channelButton.Visible = true
				channelButton.Size = UDim2.new(0,20,0,20)
			end

			pcall(function()
				environment:clearChannelNotifications(name)
				if(environment.currentChannel ~= name) then
					environment:openChannelFromBar(name)
				end
			end)
		end

		function environment:whisper(user)
			if(user ~= localPlayer) then
				local displayName = user:GetAttribute("DisplayName")
				environment:setChannel(getWhisperChannel(user.UserId),false,environment.localization:getMessagePrefix("To") .. " " .. displayName)
			end
		end

		local typingIndicator = function()
			if(environment.config.BubbleChat.Enabled) then
				return environment.bubbleChatEnabled and environment.bubbleChatConfig.TypingIndicator
			end
		end

		-------- API: --------

		local locked = false
		chatboxApi = {
			CalculateText = function(self,text)
				return string.rep(string.char(32),(count or 0)) .. text
			end,
			GetText = function()
				return chatbox.Text:sub(idx,#chatbox.Text)
			end,
			LockChatbar = function(text)
				setplaceholderText(localization:getChatbarPlaceholder(true))
				chatbox.TextEditable = false
				locked = true
			end,
			UnlockChatbar = function()
				setplaceholderText(localization:getChatbarPlaceholder())
				chatbox.TextEditable = true
				locked = false
			end,
		}

		environment.chatboxApi = chatboxApi

		chatbox.Focused:Connect(function()
			if(locked) then
				chatbox:ReleaseFocus()
			end
		end)

		environment.network.onClientEvent("receiveMuteUpdate",function(muted)
			chatboxApi[muted and "LockChatbar" or "UnlockChatbar"]()
		end)

		-------- Up/down message --------

		local on = function()
			chatbox.Text = chatboxApi:CalculateText(messageHistory[pointer])
			chatbox.CursorPosition = 10000
		end

		userInput.InputBegan:Connect(function(input)
			pcall(function()
				if(chatbox:IsFocused()) then
					if(not environment.autofillOpen) then
						if(input.KeyCode == Enum.KeyCode.Up) then
							pointer = math.clamp(pointer + 1,1,#messageHistory)
							on()
						elseif(input.KeyCode == Enum.KeyCode.Down) then
							pointer = math.clamp(pointer - 1,1,#messageHistory)
							on()
						end
					end
				end
			end)
		end)

		-------- More functions: --------

		local get = function(t)
			return getRawTextSizeInPx(label,t,true)
		end

		local getSpaces = function(text)
			local spaceCount = 3
			local minSize = get(text) + get(string.rep(space,spaceCount))
			local lastSize
			repeat
				spaceCount += 1
				lastSize = get(string.rep(space,spaceCount))
			until(spaceCount >= 1000 or (lastSize.X >= minSize.X)) 
			return spaceCount
		end

		local lastText,expiresAt = "",0

		local timeout = function()
			task.spawn(function()
				local current = expiresAt
				task.wait((expiresAt-tick()))
				if(current == expiresAt) then
					environment.network:fire("typingIndicator",false)
				end
			end)
		end

		local logChange = function()
			if(typingIndicator() and chatbox:IsFocused() and (not locked)) then
				environment.network:fire("typingIndicator",true)
				expiresAt = tick() + 5
				timeout()
			end
		end

		local textChanged

		local newVisibility = function(recurse)
			local isVis = resize.Visible
			offset = (isVis and -(resize.AbsoluteSize.X * 1.6) or -10)
			if(environment.cornerPosition:find("Bottom")) then
				offset = -10
			end
			if(not recurse) then
				textChanged()
			end
		end

		local container = resize.Parent:WaitForChild("Container")
		chatbox.Font = environment.config.UI.Fonts.TextFont
		chatbox.Bar.Font = environment.config.UI.Fonts.TextFont

		collectionService:AddTag(chatbox,"TextFont")
		collectionService:AddTag(chatbox.Bar,"TextFont")

		textChanged = function()
			if(utf8.len(utf8.nfcnormalize(chatbox.Text)) > environment.config.Messages.MaximumLength) then
				chatbox.Text = lastText
				return
			end
			logChange()
			lastText = chatbox.Text
			local size = getRawTextSizeInPx(chatbox)

			-- buttons:

			local baseSize = (base() - (chatbox.TextSize)) + (chatbox.TextSize) + padding
			container.Position = UDim2.new(0.5,0,0,baseSize/2)

			local sizeForResize = math.ceil(baseSize * 25/36)
			resize.Size = UDim2.fromOffset(sizeForResize,sizeForResize)
			local paddingLeft = (10 + sizeForResize + 5)
			if(environment.mainUi) then
				local scroller = environment.mainUi.channelBar.Main.Container.Scroller
				if(environment.cornerPosition == "TopLeft") then
					resize.AnchorPoint = Vector2.new(1,0.5)
					resize.Position = UDim2.new(1,-5,0,baseSize/2)
				elseif(environment.cornerPosition == "BottomRight") then
					resize.AnchorPoint = Vector2.new(0,0.5)
					resize.Position = UDim2.new(0,5,0,baseSize/2)
					if(resize.Visible) then
						scroller.Size = UDim2.new(1,-paddingLeft,1,0)
					else
						scroller.Size = UDim2.new(1,-10,1,0)
					end
				elseif(environment.cornerPosition == "TopRight") then
					resize.AnchorPoint = Vector2.new(0,0.5)
					resize.Position = UDim2.new(0,5,0,baseSize/2)
					chatbox.Parent.Position = UDim2.new(0,paddingLeft-5,0.5,0)
				elseif(environment.cornerPosition == "BottomLeft") then
					resize.AnchorPoint = Vector2.new(1,0.5)
					resize.Position = UDim2.new(1,-5,0,baseSize/2)
					if(resize.Visible) then
						scroller.Position = UDim2.new(0,5,0.5,0)
						scroller.AnchorPoint = Vector2.new(0,0.5)
						scroller.Size = UDim2.new(1,-paddingLeft,1,0)
					else
						scroller.Position = UDim2.new(1,-5,0.5,0)
						scroller.AnchorPoint = Vector2.new(1,0.5)
						scroller.Size = UDim2.new(1,-10,1,0)
					end
				end
			end
			newVisibility(true)

			if(environment.refreshChannelSizes) then
				environment.refreshChannelSizes(chatbox.TextSize)
			end

			-- chatbar scaling:

			local totalSize = UDim2.new(1,0,0,(base() - (chatbox.TextSize)) + (size.Y) + padding)
			utility:tween({chatbox.Parent,0.05,{ -- white box
				Size = UDim2.new(1,offset,0,(base() - (chatbox.TextSize * 2)) + (size.Y) + (padding * 2))
			}},{chatbox,0.05,{ -- actual box
				Size = UDim2.new(1,-10,0,math.ceil(size.Y)),
			}},{chatbox.Parent.Parent.Parent,0.05,{ -- main thing
				Size = totalSize
			}})

			if(not separate) then
				local window = chatbox.Parent.Parent.Parent.Parent.Parent.ChatWindow
				window.Main.Size = UDim2.new(1,0,1,(totalSize.Y.Offset - (baseSize)))
				window.Main.Scroller.Size = UDim2.new(1,-15,1,-(totalSize.Y.Offset + 5))
			end
		end

		local deselectChannel = function()
			channelButton.Visible = false
		end

		local calculateCursor = function()
			heartbeat:Wait()
			local cursor,start = chatbox.CursorPosition,chatbox.SelectionStart
			local max = math.max(cursor,start)
			if(channelButton.Visible) then
				if(max < idx and (chatbox:IsFocused())) then
					deselectChannel()
				elseif(chatbox:IsFocused()) then
					local min = math.min(cursor,start)
					if(min ~= -1 and min < idx) then
						chatbox.SelectionStart = idx
					end
				end
			end
		end

		local onChannel = function()
			heartbeat:Wait()
			if(channelButton.Visible) then --> vomit code below
				-- fetch text size for channel button
				local textSize = isReply and {X = 25} or getRawTextSizeInPx(label,nil,true)
				-- set the size of the button
				label.Size = UDim2.new(0,textSize.X,1,0)
				channelButton.Size = (not isReply and UDim2.new(0,textSize.X + 10,0,20) or channelButton.Size)
				-- forgot what this does but it's important
				idx = 1 + (count or 0)
				-- get the spaces for the chatbar (eg: 'hello' -> '    ' if that makes sense)
				count = getSpaces(isReply and "   " or label.Text)
				chatbox.Text = string.rep(string.char(32),count) .. chatbox.Text:sub(idx,#chatbox.Text)
				-- set it to only get text after the spaces and put the cursor at the end when a channel's selected
				idx = count + 1
				chatbox.CursorPosition += 1000
				chatbox:CaptureFocus()
			else
				environment.currentChannel = "Main"
				if(idx > 1) then
					chatbox.Text = chatbox.Text:sub(idx,#chatbox.Text)
				end
				count = nil
				extraData = nil
				idx = 1
			end
		end

		-------- Connections: --------

		chatbox:GetPropertyChangedSignal("TextSize"):Connect(textChanged)
		chatbox:GetPropertyChangedSignal("Text"):Connect(textChanged)
		textChanged()

		setplaceholderText(localization:getChatbarPlaceholder())
		chatbox.Focused:Connect(logChange)
		chatbox.FocusLost:Connect(function(enterPressed,input)
			if(typingIndicator()) then
				environment.network:fire("typingIndicator",false)
			end
			if(enterPressed) then
				sendMessage(chatbox.Text:sub(idx,#chatbox.Text))
			end
		end)

		-- WARNING: USING THIS TO FAKE MESSAGES WILL LAND YOU IN MODERATION TROUBLE.
		-- THIS IS ONLY USED FOR QUICKCHAT

		function environment:sendMessageInternally(text)
			if(typingIndicator()) then
				environment.network:fire("typingIndicator",false)
			end
			sendMessage(text)
		end

		chatbox:GetPropertyChangedSignal("CursorPosition"):Connect(calculateCursor)
		chatbox:GetPropertyChangedSignal("SelectionStart"):Connect(calculateCursor)
		environment.textChanged = textChanged

		resize:GetPropertyChangedSignal("Visible"):Connect(newVisibility)
		newVisibility()

		label:GetPropertyChangedSignal("Text"):Connect(onChannel)
		channelButton:GetPropertyChangedSignal("Visible"):Connect(onChannel)
		onChannel()

		-------- Undo / redo support: --------

		history(chatbox,chatboxApi)

		-------- Autofills: --------

		local autofillsList = {}

		local onAutofill = function(rawModule)
			local module = require(rawModule)
			if(type(module) == "function") then
				module = module(environment.config)
			end
			autofillsList[rawModule.Name] = module
		end

		autofillListFolder.ChildAdded:Connect(onAutofill)
		for _,child in pairs(autofillListFolder:GetChildren()) do
			task.spawn(onAutofill,child)
		end

		autofillManager(autofill,autofillsList,chatbox,environment)

		-------- Return: --------

		return {
			chatbox = chatbox,
			chatbar = chatbox.Parent.Parent.Parent
		}
	end

	-------- Core connections: --------

	local focusChatbar = function(state)
		if not environment.main_ui.Visible and typeof(state) == "EnumItem" then
			environment.main_ui.Visible = true
			connections:Fire("ChatWindow","VisibilityStateChanged",true)
			environment:setChatOpenState(true)
		end
		if(typeof(state) == "EnumItem") then
			state = true
		end
		if(state) then
			chatbox:CaptureFocus()
		else
			chatbox:ReleaseFocus()
		end
	end

	userInput.InputBegan:Connect(function(input,gameProcessed)
		if not gameProcessed and input.KeyCode == Enum.KeyCode.Return then
			task.wait()
			focusChatbar(true)
		end
	end)

	connections:Connect("ChatWindow","SpecialKeyPressed",focusChatbar)
	--connections:Connect("ChatWindow","ChatBarFocusChanged",focusChatbar)

	if environment.config.BubbleChat.Enabled and environment.config.BubbleChat.Config.TypingIndicator then
		localPlayer:GetAttributeChangedSignal("TypingIndicatorEnabled"):Connect(function()
			if not localPlayer:GetAttribute("TypingIndicatorEnabled") then
				environment.network:fire("typingIndicator",false)
			end
		end)
	end

	return chatbar
end