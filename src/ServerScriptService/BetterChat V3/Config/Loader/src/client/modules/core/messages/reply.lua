-- Author: @Jumpathy
-- Name: reply.lua
-- Description: Message reply template
-- Note: This literally destroyed my brain cells to create lmao you better like it

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local heartbeat = runService.Heartbeat
local localPlayer = players.LocalPlayer

local label = Instance.new("TextLabel")
label.RichText = true

local getTextContent = function(text)
	label.Text = text
	return label.ContentText
end

return function(environment)
	local scroller = environment.mainUi.scroller
	local templates = script.Parent:WaitForChild("templates")
	local replyMessage = require(templates:WaitForChild("reply"))
	local rich = environment.richText
	local editedStamp = ("<font color=\"rgb(200,200,200)\"> (%s)</font>"):format(environment.localization:localize("Chat_Edited"))
	local deletedStamp = ("<font color=\"rgb(200,200,200)\">(%s)</font>"):format("Unsent a message")
	local userSplit = environment.config.Messages.UserAndMessageOnSeparateLines
	
	local grouping = environment.config.Messages.MessageGrouping
	local merge = grouping and grouping.Enabled
	local timeout = grouping and grouping.GroupTimeout or 120
	
	local getText = function(data,wasEdited,key,internal,object)
		local isBlank = data.name == "" and data.displayName == ""
		local atEnd = isBlank and "" or ": "
		
		local editStamp = (wasEdited and editedStamp or "")
		local hasDisplayName = data.displayName ~= data.name
		local userPrefix = rich:colorize(data.displayName .. atEnd,(data.teamColor or (hasDisplayName and data.displayNameColor or data.nameColor)))
		local messageContent = (data.markdownEnabled and environment.richText:markdown(data.message)) or environment.richText:escape(data.message)
		local splitLine = userSplit and "\n" or ""
		if merge and internal then
			local previous = internal[math.clamp(key - 1,1,math.huge)]
			if previous ~= data then
				if previous.name == data.name then
					local timeDiff = data.timeSent - previous.timeSent
					if timeDiff <= timeout then
						userPrefix = ""
						splitLine = ""
					end
				end
			end
		end
		messageContent = environment:processEmojis(object,data,messageContent)
		if(data.customEmojis) then
			if(object.Name == "Reply") then
				object.Size = UDim2.new(1,0,0,object.TextSize)
				object.User.Size = UDim2.new(1,0,0,object.TextSize)
			end
			environment:attachCustomEmojis(object,messageContent,data.customEmojis,data.spacing,nil,editedStamp)
		end
		return userPrefix .. splitLine .. messageContent .. editStamp,userPrefix,messageContent ..editStamp
	end
	
	local label = Instance.new("TextLabel")
	label.RichText = true
	local getContent = function(text)
		label.Text = text
		return label.ContentText
	end

	local internal = {}
	local threadApis = {}
	local threadConnections = {}
	local lastChain

	local push = function(object,newReply)
		if(not object:FindFirstChild("ReplyChain")) then
			return false
		end
		local replyChain = object.ReplyChain
		local id = object:GetAttribute("ID")
		internal[id] = internal[id] or {}
		if(newReply) then
			table.insert(internal[id],newReply)
		end
		local isAtBottom = environment:atBottom()
		for _,child in pairs(replyChain:GetChildren()) do
			if(child:IsA("Frame")) then
				child:Destroy()
			end
		end
		local endIdx = #internal[id]
		for key,reply in pairs(internal[id]) do
			local template = replyMessage[key < endIdx and "Middle" or "Bottom"](environment)
			template.Parent = replyChain.Parent
			
			local content,userPrefix,raw = getText(reply,(reply.edits and reply.edits >= 1 and true or false),key,internal[id],template.ReplyArea.Reply)
			local isMentioned = raw:find(("@"..localPlayer.Name))
			local isOwner = (reply.senderId == localPlayer.UserId)
			local canEdit = isOwner and reply.editingEnabled
			local editBox = template.ReplyArea.Edit
			local connected
			template.ReplyArea.Reply.Text = content
			template.ReplyArea.Reply.TextColor3 = reply.chatColor
			getText(reply,(reply.edits and reply.edits >= 1 and true or false),key,internal[id],template.ReplyArea.Reply)
			
			local signals = {}
			local connect = function(sig)
				table.insert(signals,sig)
				if(not connected) then
					connected = template.Changed:Connect(function()
						if(template:GetFullName() == template.Name) then
							connected:Disconnect()
							for _,signal in pairs(signals) do 
								signal:Disconnect()
							end
							signals = {}
						end
					end)
				end
			end
			
			connect(template:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				getText(reply,(reply.edits and reply.edits >= 1 and true or false),key,internal[id],template.ReplyArea.Reply)
			end))
			
			if(editBox and canEdit) then
				local prefix = getContent(userPrefix)
				editBox.Text = prefix .. getTextContent(reply.message)
				editBox.TextTransparency = 1
				local hiding = false
				
				connect(template.ReplyArea.Reply.DescendantAdded:Connect(function(child)
					if(child:GetAttribute("IsEmoji") and hiding) then
						child.Visible = false
					end
				end))
				
				connect(editBox.Focused:Connect(function()
					hiding = true
					for _,obj in pairs(template.ReplyArea.Reply:GetDescendants()) do
						if(obj:GetAttribute("IsEmoji") or obj:GetAttribute("IsMessagePart")) then
							obj.Visible = false
						end
					end
					editBox.TextTransparency = 0
					template.ReplyArea.Reply:SetAttribute("CurrentlyEditing",true)
					if not reply.customEmojis then
						template.ReplyArea.Reply.TextTransparency = 1
					end
				end))

				connect(editBox.FocusLost:Connect(function(enterPressed)
					pcall(function()
						if(enterPressed) then
							local newText = editBox.Text:sub(#prefix+1,#editBox.Text)
							environment:onEdit(newText)
							environment.network:fire("editMessage",reply.id,reply.channelFrom,newText)
						end
						hiding = false
						for _,obj in pairs(template.ReplyArea.Reply:GetDescendants()) do
							if(obj:GetAttribute("IsEmoji") or obj:GetAttribute("IsMessagePart")) then
								obj.Visible = true
							end
						end
						editBox.TextTransparency = 1
						template.ReplyArea.Reply:SetAttribute("CurrentlyEditing",false)
						if not reply.customEmojis then
							template.ReplyArea.Reply.TextTransparency = 0
						end
					end)
				end))

				connect(editBox.Changed:Connect(function()
					if(editBox.CursorPosition <= #prefix) then
						editBox.CursorPosition = #prefix + 1
					end
					if(#editBox.Text < #prefix) then
						editBox.Text = prefix
					end
				end))
				
				connect(template.ReplyArea.Reply:GetAttributeChangedSignal("CurrentlyEditing"):Connect(function()
					local currentlyEditing = template.ReplyArea.Reply:GetAttribute("CurrentlyEditing")	
					for _,child in pairs(template.ReplyArea.Reply:GetChildren()) do
						if(child.Name == "WrappedLine") then
							for _,obj in pairs(child:GetChildren()) do
								if obj:IsA("TextLabel") then
									obj.TextTransparency = currentlyEditing and 1 or 0
								end
							end
						end
					end
				end))
				
				environment.utility:clampTextLimit(editBox,environment.config.Messages.MaximumLength)
			else
				editBox:Destroy()
			end
			if(isMentioned) then
				template.ReplyArea.Reply.Mentioned.Visible = true
				local changed
				changed = template.Changed:Connect(function()
					template.ReplyArea.Reply.Mentioned.Bar.Size = UDim2.fromOffset(5,0)
					heartbeat:Wait()
					if(template:GetFullName() ~= template.Name) then
						template.ReplyArea.Reply.Mentioned.Bar.Size = UDim2.fromOffset(5,template.ReplyArea.Reply.Mentioned.AbsoluteSize.Y)
					else
						changed:Disconnect()
					end
				end)
			else
				template.ReplyArea.Reply.Mentioned:Destroy()
			end
			template.Parent = replyChain
		end
		if(isAtBottom) then
			environment:checkScrollerPos(true,0.1)
		end
		return true
	end

	environment.threads = {}
	function environment:checkThread(id)
		return environment.threads[id] and threadApis[id]
	end
	
	--[[
		Flow:
		1. If a message is being replied to, check if there's an existing thread on that message
		1A. If there's not an existing thread, create one and continue
		1B. If there is, continue
		2. Push reply into message stack/thread
		
		Alternate:
		> Rebuild the thread if a message is edited
	--]]
	
	local main
	main = function(dta,queue)
		if(environment.threads[dta.replyingTo.id] == queue[1]) then
			push(queue[1],dta)
			return environment.threads[dta.replyingTo.id],threadApis[dta.replyingTo.id]
		elseif(environment.threads[dta.replyingTo.id] ~= nil) then
			internal[dta.replyingTo.id] = {}
			threadApis = {}
		end
		
		environment:checkScrollerPos()
		local object = replyMessage.new(environment)
		object.Parent = scroller

		local id = dta.replyingTo.id
		local originalMessage = dta.replyingTo
		local _,userPrefix,textContent = getText(originalMessage,nil,nil,nil,object.Original)
		local user = object.Original.User
		local lastInBounds = false
		
		object.Original.Text = userPrefix .. textContent
		object.LayoutOrder = dta.id
		object:SetAttribute("ID",id)
		object.Original.User.Text = userPrefix
		object.Original.TextColor3 = originalMessage.chatColor
		getText(originalMessage,nil,nil,nil,object.Original)
		
		local hasDisplayName = originalMessage.displayName ~= originalMessage.name
		local update = function()
			local isBlank = originalMessage.name == "" and originalMessage.displayName == ""
			local atEnd = isBlank and "" or ": "
			
			if(hasDisplayName) then
				if(lastInBounds) then
					userPrefix = rich:colorize(originalMessage.name .. atEnd,(originalMessage.teamColor or originalMessage.nameColor))
				else
					userPrefix = rich:colorize(originalMessage.displayName .. atEnd,(originalMessage.teamColor or originalMessage.displayNameColor))
				end
			end
			object.Original.Text = userPrefix .. textContent
		end
		
		environment.mouseMoved[object] = function(position)
			local inBounds = false
			if(position.X <= (user.AbsolutePosition.X + user.AbsoluteSize.X)) then
				if(position.X >= (user.AbsolutePosition.X)) then
					if(position.Y >= (user.AbsolutePosition.Y)) then
						if(position.Y <= (user.AbsolutePosition.Y + user.AbsoluteSize.Y)) then
							inBounds = true
						end
					end
				end
			end
			if(lastInBounds ~= inBounds) then
				lastInBounds = inBounds
				update()
			end
		end
		
		environment.threads[dta.replyingTo.id] = object
		push(object,dta)
		local changed,repaired = nil,false
		changed = object.Changed:Connect(function()
			if(object:GetFullName() == object.Name) then
				changed:Disconnect()
				internal[dta.replyingTo.id] = nil
				for _,conn in pairs(threadConnections[dta.replyingTo.id] or {}) do
					conn:Disconnect()
				end
				task.delay(3,function()
					if(not repaired) then
						lastChain = nil
					end
				end)
			end
		end)
		
		local repair = function(chain)
			repaired = true
			pcall(function()
				environment.threads[dta.replyingTo.id]:Destroy()
			end)
			if(chain) then
				internal[dta.replyingTo.id] = chain
			end
			environment.threads[dta.replyingTo.id] = nil
			local obj = main(dta,queue)
			table.insert(queue,1,obj)
		end
		
		local threadApi = {
			replace = function(data,queue)
				local replyChain = internal[id]
				if(not replyChain) then
					repair(lastChain)
					return
				else
					lastChain = replyChain
				end
				for key,child in pairs(replyChain) do
					if(child.id == data.id) then
						replyChain[key] = data
					end
				end
				local success = push(object,nil)
				if(not success) then
					repair(lastChain)
				end
			end,
			editBaseMessage = function(self,new)
				local _,_,newText = getText(new,nil,nil,nil,object.Original)
				textContent = newText .. editedStamp
				if new.deleted == true then
					textContent = deletedStamp
				end
				update()
			end,
		}
		threadApis[dta.replyingTo.id] = threadApi
		return object,threadApi
	end

	return main
end