-- Author: @Jumpathy
-- Name: default.lua
-- Description: User messages base

local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local players = game:GetService("Players")
local textService = game:GetService("TextService")
local collectionService = game:GetService("CollectionService")
local heartbeat = runService.Heartbeat

local localPlayer = players.LocalPlayer
local label = Instance.new("TextLabel")
label.RichText = true

local getTextContent = function(text)
	label.Text = text
	return label.ContentText
end

local italicize = function(text)
	return("<i>%s</i>"):format(text)
end

local getTextBounds = function(object,text)
	return textService:GetTextSize(getTextContent(text),object.TextSize,object.Font,Vector2.new(object.AbsoluteSize.X,math.huge))
end

return function(environment)
	local useIcons = environment.config.Messages.IncludeIcon
	local font = environment.config.UI.Fonts.TextFont
	local grouping = environment.config.Messages.MessageGrouping
	local merge = grouping and grouping.Enabled
	local timeout = grouping and grouping.GroupTimeout or 120
	local userSplit = environment.config.Messages.UserAndMessageOnSeparateLines
	
	local _gsub_escape_table = {
		["\000"] = "%z", ["("] = "%(", [")"] = "%)", ["."] = "%.",
		["%"] = "%%", ["+"] = "%+", ["-"] = "%-", ["*"] = "%*",
		["?"] = "%?", ["["] = "%[", ["]"] = "%]", ["^"] = "%^",
		["$"] = "%$",
	}
	
	local escapePattern = function(str)
		return str:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", _gsub_escape_table)
	end
	
	function environment:updFont(new)
		font = environment.config.UI.Fonts.TextFont
		for _,obj in pairs(collectionService:GetTagged("TextFont")) do
			if obj and obj:GetFullName() ~= obj.Name then
				obj.Font = font
			end
		end
		for _,obj in pairs(collectionService:GetTagged("ChatbarFont")) do
			if obj and obj:GetFullName() ~= obj.Name then
				obj.Font = font
			end
		end
	end
	
	local editedText = environment.localization:localize("Chat_Edited")
	local editedStamp = ("<font color=\"rgb(200,200,200)\"> (%s)</font>"):format(editedText)
	local deletedStamp = ("<font color=\"rgb(200,200,200)\">(%s)</font>"):format("Unsent a message")
	environment.editedStamp = editedStamp
	
	local systemPrefixColor = environment.config.UI.Colors.SystemPrefixColor
	local meCommandColor = Color3.fromRGB(235, 235, 235)
	
	local scroller = environment.mainUi.scroller
	local templates = script.Parent:WaitForChild("templates")	
	local rich = environment.richText
	
	local util = script.Parent:WaitForChild("util")
	local regular = require(templates:WaitForChild("regular"))
	local functions = require(util:WaitForChild("functions"))(environment)
	local prompt = require(util:WaitForChild("prompt"))(environment,functions)
	
	environment.attachCustomEmojis = functions.attachCustomEmojis
	environment.addToCache.regular = regular.addToCache
	
	function environment:processEmojis(object,data,txt)
		if(data.customEmojis) then
			local spacing = functions.lineDetector:getSpacingFor(object,object.TextSize)
			data.spacing = spacing
			data.emojis = data.emojis or {}
			local idx = 0
			for _,emoji in pairs(data.customEmojis) do
				local emojiTag,emojiImage = emoji[1],emoji[2]
				txt = txt:gsub(escapePattern(emojiTag),spacing)
			end
		end
		return txt
	end
	
	local padding = 2
	local mentionString = ("@%s"):format(localPlayer.Name)
	environment.mouseMoved = environment.mouseMoved or {}
	
	local ts = function()
		return environment.config.UI.BaseTextSize
	end
	
	local getLast = function(toIgnore,relevantChannel)
		local last;
		for _,msg in pairs(environment.messages) do
			if(msg.data.id ~= toIgnore and msg.data.id < toIgnore) then
				if(msg.data.channelFrom == relevantChannel) then
					last = msg
				end
			end
		end
		return last
	end
	
	return function(data)
		local afterName = ": "
		if data.name == "" and data.displayName == "" then
			afterName = ""
		end
		local t = 0
		
		local lastMessage = getLast(data.id,data.channelFrom)
		local mergeMessage = false
				
		if lastMessage and lastMessage.data.name == data.name and merge then
			if lastMessage.data.class == data.class and data.channelFrom == lastMessage.data.channelFrom then
				local timeDiff = data.timeSent - lastMessage.data.timeSent
				if timeDiff <= timeout then
					if(lastMessage.data.id - data.id < 0) then
						mergeMessage = true
					end
				end
			end
		end
		
		local editCount = data.edits or 0
		local object = regular.new(environment)
		local id = data.player ~= nil and data.player.UserId or 0
		local canReceiveInput,lastPosition,iconOption,lastInBounds,lastSize,lastInput,lastPrompt = false,nil,nil,nil,nil,nil,nil
		
		environment:checkScrollerPos()
		
		local isMentioned = data.message:find(mentionString) and data.mentioningEnabled
		local isMeCommand = data.isMeCommand
		local canEdit = (data.senderId == localPlayer.UserId) and data.editingEnabled
		local canReply = (localPlayer:GetAttribute("Permission") >= data.requiredToReply)
		local originalText = data.message
		
		if data.imagesDisabled ~= true then
			if(useIcons and (not isMeCommand)) then
				local offset = (isMentioned and UDim2.new(0,8,0,0) or UDim2.new(0,0,0,0))
				if(data.viewportData) then
					task.spawn(function() -- spawned bc it yields and not cool >:(
						local viewport = environment.utility.viewport.new(data.viewportData,16)
						viewport.Parent = object
						viewport.Position = offset
						iconOption = viewport
					end)
				else
					object.Icon.Image = data.imageId ~= "" and data.imageId or functions:getUserThumbnail(id)
					object.Icon.Visible = true
					object.Icon.Position = offset
					iconOption = object.Icon
				end
				object.Raw.Size = UDim2.new(1,(isMentioned and -28 or -20),0,16)
				object.Edit.Size = UDim2.new(1,(isMentioned and -28 or -20),0,16)
			elseif(isMentioned) then
				object.Raw.Size = UDim2.new(1,-8,0,16)
				object.Edit.Size = UDim2.new(1,-8,0,16)
			end
		end
		
		if(isMentioned) then
			object.Mentioned.Visible = true
		end
		
		local hasDisplayName = data.displayName ~= data.name
		
		local tags = ""
		if(not isMeCommand) then
			tags = functions.getTags(data)
		else
			data.message = data.message:sub(5,#data.message)
		end
		
		local color = (data.teamColor or (hasDisplayName and data.displayNameColor or data.nameColor))
		local userPrefix = rich:colorize(data.displayName .. (isMeCommand and " " or afterName),isMeCommand and meCommandColor or color)
		local markdownEnabled = data.markdownEnabled
		local messageContent = (markdownEnabled and environment.richText:markdown(data.message)) or environment.richText:escape(data.message)		
		local originalContent = messageContent
		
		if(editCount >= 1) then
			messageContent = messageContent .. editedStamp
		end
		
		if(isMentioned) then
			messageContent = messageContent:gsub(mentionString,environment.richText:colorize(mentionString,Color3.fromRGB(255, 170, 0)))
		end
		
		if data.deleted then
			messageContent = deletedStamp
		end
		
		local getPrefix = function(update)
			if mergeMessage then
				return ""
			end
			
			if update then
				return functions.getTags(data) .. userPrefix .. (userSplit and "\n" or "")
			else
				return tags .. userPrefix ..  (userSplit and "\n" or "")
			end
		end
		
		if mergeMessage and iconOption then
			iconOption:Destroy()
			iconOption = nil
		end
		
		local prefix = getPrefix()
		
		local getText = function()
			if data.customEmojis and #data.customEmojis > 0 then
				return environment:processEmojis(object.Raw,data,messageContent)
			else
				return messageContent
			end
		end
		
		object.Raw.Text = prefix .. getText()
		object.Raw.TextColor3 = data.chatColor
		object.Raw.User.Text = prefix
		object.Parent = scroller
		object.LayoutOrder = data.id
		
		local i = 0
		local added = false
		local imgCont;
		
		local createContainer = function()
			added = true
			local container = Instance.new("Frame")
			container.Name = "ImageContainer"
			container.Size = UDim2.fromOffset(0,ts())
			container.Position = UDim2.fromOffset(0,0)
			container.Parent = object.Raw
			container.BackgroundTransparency = 1
			container.AutomaticSize = Enum.AutomaticSize.X
			local layout = Instance.new("UIListLayout")
			layout.Padding = UDim.new(0,5)
			layout.FillDirection = Enum.FillDirection.Horizontal
			layout.Parent = container
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			imgCont = container
		end
		
		if not mergeMessage then
			for dx,tag in pairs(data.tags) do
				if tag.image and (not isMeCommand) then
					if not added then
						createContainer()
					end
					i += 1
					local image = Instance.new("ImageLabel")
					image.Size = UDim2.fromOffset(ts(),ts())
					image.Image = tag.image
					image.Parent = imgCont
					image.BackgroundTransparency = 1
					image.Name = tostring(i)
					image.LayoutOrder = dx
					image.ImageColor3 = tag.color or Color3.fromRGB(255,255,255)
				elseif not tag.image then
					if not isMeCommand then
						if not added and functions:hasImages(data.tags) then
							createContainer()
						end
						local psuedoTagSpacer = Instance.new("Frame")
						psuedoTagSpacer.Parent = imgCont
						psuedoTagSpacer.Name = tag.text
						psuedoTagSpacer.BackgroundTransparency = 1
						local size = textService:GetTextSize("["..tag.text.."]",ts(),font,Vector2.new(math.huge,ts()))
						psuedoTagSpacer.Size = UDim2.fromOffset(size.X-5,ts())
						psuedoTagSpacer.LayoutOrder = dx
					end
				end
			end
		end
		
		if(isMeCommand) then
			object.Raw.Text = italicize(object.Raw.Text)
		end
		
		if(isMeCommand) then
			object.Raw.TextColor3 = meCommandColor
		end
		
		local edit = object.Edit
		local collector = functions.createCollector(object,function() --> RBXScriptConnection collector
			prompt:removeData(object)
		end)
		
		local editCallback = function() end
		
		if(canEdit) then
			local hiding = false
			collector:add(object.Raw.DescendantAdded:Connect(function(child)
				if hiding and child:GetAttribute("IsEmoji") then
					child.Visible = false
				end
			end))
			
			editCallback = function()
				local prefix = getTextContent(prefix)
				local raw = object.Raw
				edit.Text = getTextContent(prefix .. originalContent)
				edit.TextTransparency = 1
				
				collector:add(object.Raw.Changed:Connect(function()
					edit.Size = UDim2.new(1,0,0,raw.AbsoluteSize.Y)
				end))
				
				collector:add(edit.Focused:Connect(function()
					hiding = true
					for _,obj in pairs(object.Raw:GetDescendants()) do
						if(obj:GetAttribute("IsEmoji") or obj:GetAttribute("IsMessagePart")) then
							obj.Visible = false
						end
					end
					if(iconOption) then
						iconOption.Visible = false
					end
					edit.TextTransparency = 0
					object.Raw:SetAttribute("CurrentlyEditing",true)
					if not data.customEmojis or #data.customEmojis < 1 then
						object.Raw.TextTransparency = 1
					end
				end))
				
				collector:add(edit.FocusLost:Connect(function(enterPressed)
					pcall(function()
						if(iconOption) then
							iconOption.Visible = true
						end
						if(enterPressed) then
							local newText = edit.Text:sub(#prefix+1,#edit.Text)
							environment:onEdit(newText)
							environment.network:fire("editMessage",data.id,data.channelFrom,newText)
						end
						edit.TextTransparency = 1
						hiding = false
						for _,obj in pairs(object.Raw:GetDescendants()) do
							if(obj:GetAttribute("IsEmoji") or obj:GetAttribute("IsMessagePart")) then
								obj.Visible = true
							end
						end
						object.Raw:SetAttribute("CurrentlyEditing",false)
						if not data.customEmojis or #data.customEmojis < 1 then
							object.Raw.TextTransparency = 0
						end
					end)
				end))
				
				collector:add(edit.Changed:Connect(function()
					if(edit.CursorPosition <= #prefix) then
						edit.CursorPosition = #prefix + 1
					end
					if(#edit.Text < #prefix) then
						edit.Text = prefix
					end
				end))
				
				collector:add(object.Raw:GetAttributeChangedSignal("CurrentlyEditing"):Connect(function()
					local currentlyEditing = object.Raw:GetAttribute("CurrentlyEditing")	
					for _,child in pairs(object.Raw:GetChildren()) do
						if(child.Name == "WrappedLine") then
							for _,obj in pairs(child:GetChildren()) do
								if obj:IsA("TextLabel") then
									child.TextTransparency = currentlyEditing and 1 or 0
								end
							end
						end
					end
				end))
				
				environment.utility:clampTextLimit(edit,environment.config.Messages.MaximumLength)
			end
		else
			edit:Destroy()
		end
		
		local user = object.Raw.User
		local mentionedBar = object:WaitForChild("Mentioned"):WaitForChild("Bar")
		local lastTextSize = 0
		
		local handleDifference = function()
			if data.customEmojis and #data.customEmojis > 0 then
				local txt = getText()
				object.Raw.Text = prefix .. txt
				functions:attachCustomEmojis(object.Raw,originalText,data.customEmojis,data.spacing,nil,editedStamp)
			end
		end
		
		local standardCheck = function()
			heartbeat:Wait()
			if(object:GetFullName() ~= object.Name) then
				if(object.AbsoluteSize ~= lastSize) then
					lastSize = object.AbsoluteSize
					local currentPadding = (object.Raw.TextBounds.Y > object.Raw.TextSize and padding or 0)
					mentionedBar.Size = UDim2.new(0,5,0,object.Raw.AbsoluteSize.Y + (currentPadding * 2)) --UDim2.new(0,5,0,object.Raw.TextBounds.Y + (currentPadding * 2))
					handleDifference()
				end
				if(object.Raw.TextSize ~= lastTextSize) then
					lastTextSize = object.Raw.TextSize
					if imgCont then
						imgCont.Size = UDim2.fromOffset(0,ts())
						for _,img in pairs(imgCont:GetChildren()) do
							if img:IsA("ImageLabel") then
								img.Size = UDim2.fromOffset(ts(),ts())
							elseif img:IsA("Frame") then
								local size = textService:GetTextSize("["..img.Name.."]",ts(),font,Vector2.new(math.huge,ts()))
								img.Size = UDim2.fromOffset(size.X,ts())
							end
						end
					end
					if not isMeCommand then
						prefix = getPrefix(true)
						object.Raw.Text = prefix .. getText()				
					end
					handleDifference()
				end
			else
				lastPosition = nil
				local current = environment.messages[data.id]
				if(current) then
					current = current["data"]["edits"]
					if(current == editCount) then -- wasnt edited when the obj was deleted
						if((tick()-environment.lastRefresh) >= 0.1) then
							environment.messages[data.id] = nil
						end
						data = nil
					end
				end
			end
		end
		
		collector:add(object.Changed:Connect(standardCheck))
		standardCheck()
		
		local loaded = false
		local load = function()
			loaded = true
			if(object:GetFullName() == object.Name) then
				return
			end
			environment.mouseMoved[object.Raw] = function(position)
				lastPosition = position
				local isInBounds = false
				if(position.X <= (object.AbsolutePosition.X + object.AbsoluteSize.X)) then
					if(position.X >= (object.AbsolutePosition.X)) then
						if(position.Y >= (object.AbsolutePosition.Y)) then
							if(position.Y <= (object.AbsolutePosition.Y + object.AbsoluteSize.Y)) then
								isInBounds = true
							end
						end
					end
				end
				canReceiveInput = isInBounds
			end
			
			environment.mouseMoved[object] = function(position)
				local inBounds = false
				if(position.X <= (user.AbsolutePosition.X + user.AbsoluteSize.X)) then
					if(position.X >= (user.AbsolutePosition.X)) then
						if(position.X >= (user.AbsolutePosition.X + getTextBounds(user,tags).X)) then
							if(position.Y >= (user.AbsolutePosition.Y)) then
								if(position.Y <= (user.AbsolutePosition.Y + user.AbsoluteSize.Y)) then
									inBounds = true
								end
							end
						end
					end
				end
				if(lastInBounds ~= inBounds) then
					lastInBounds = inBounds
					if(hasDisplayName) then
						if(inBounds) then
							userPrefix = rich:colorize(data.name .. afterName,(data.teamColor or data.nameColor))
						else
							userPrefix = rich:colorize(data.displayName .. afterName,(data.teamColor or data.displayNameColor))
						end
					end
					prefix = getPrefix()
					--object.Raw.Text = isMeCommand and italicize(text) or text
					handleDifference()
					
					if(canEdit and (not edit:IsFocused())) then
						object.Edit.Visible = (not inBounds)
					end
				end
			end
			
			local bools = {canEdit,canReply}
			local enabled = bools[1] or bools[2]
			
			if(enabled and not data.deleted) then
				prompt:set(object,canEdit,canReply)
				collector:add(userInput.InputBegan:Connect(function(input)
					if(lastPrompt) then
						task.delay(0.05,function()
							if(lastPrompt) then
								lastPrompt:Destroy()
								lastPrompt = nil
							end
						end)
					end
					if(input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton2) then
						heartbeat:Wait()
						if(canReceiveInput) then
							local key = tick()
							lastInput = key
							task.delay((userInput.TouchEnabled and 0.5 or 0),function()
								if(lastInput == key and (canReceiveInput)) then
									lastPrompt = prompt:open(object,data,collector,edit)
								end
							end)
						end
					end
				end))
			end
			
			collector:add(object.Raw.User.MouseButton1Click:Connect(function()
				functions:initWhisper(players:GetPlayerByUserId(data.senderId))
			end))
			
			task.spawn(editCallback)
		end
		
		collector:add(object.MouseEnter:Connect(function()
			if(not loaded) then
				load()
			end
		end))
		
		-- sobbing, the stupid custom emojis WILL NOT WORK (initially) without this
		
		if data.customEmojis and #data.customEmojis > 0 then
			local og,sig = tick(),nil
			local iterations = 0
			sig = runService.RenderStepped:Connect(function()
				if(iterations < 5) then
					iterations += 1
					handleDifference()
				else
					sig:Disconnect()
				end
			end)
		end
		
		return object
	end
end