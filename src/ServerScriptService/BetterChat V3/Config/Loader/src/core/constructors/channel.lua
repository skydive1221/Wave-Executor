-- Author: @Jumpathy
-- Name: channel.lua
-- Description: Channel objects manager

local chatService = game:GetService("Chat")
local textChatService = game:GetService("TextChatService")
local players = game:GetService("Players")

return function(network,config,signal)
	local channelAdded = signal.new()
	
	local channelModule = {}
	channelModule.internal = {}
	channelModule.internal.channels = {}

	local channelsList = channelModule.internal.channels
	local messagesLimit = config.Messages.ChannelMessageLimit
	local speaker
	local messages

	local shallowCopy = function(original)
		local copy = {}
		for key,value in pairs(original) do
			copy[key] = value
		end
		return copy
	end

	-- check out the sick networking I had a stroke trying to write :skull:
	-- and then roblox decided to be like 'lets release our custom networking system for chats!1'
	
	local canCommunicate = function(senderId,userId)
		local canCommunicate = false
		if(senderId ~= nil) then
			local success,chat = pcall(function()
				return textChatService:CanUsersChatAsync(senderId,userId)
			end)
			if(success) then
				canCommunicate = chat
			end
		end
		return canCommunicate
	end
	
	channelModule.canCommunicate = canCommunicate
	
	local getFilteredMessage = function(object,speaker)
		local messageOwner = object.sender
		local filterObject = object.filtered
		if(((not object.data.isPlayer) or canCommunicate(messageOwner.UserId,speaker.player.UserId))) then
			local messageContent = filterObject:GetChatForUserAsync(not object.data.isPlayer and "" or speaker.player.UserId)
			local copiedData = shallowCopy(object.data)
			copiedData.message = messageContent
			return copiedData
		end
	end

	local replicateMessage = function(channel,object,list)
		local messageOwner = object.sender
		for _,speaker in pairs(list or channel.speakers) do
			task.spawn(function()
				if(speaker.player ~= nil) then 
					if(((not object.data.isPlayer) or canCommunicate(messageOwner.UserId,speaker.player.UserId))) then
						local toSend = getFilteredMessage(object,speaker)
						if(toSend.replyingTo ~= nil) then
							toSend.replyingTo = getFilteredMessage(toSend.replyingTo,speaker)
							if(not toSend.replyingTo) then -- failed to communicate
								return
							end
						end
						if speaker.player == messageOwner then
							toSend.unfiltered = object.unblacklisted
						end
						network:fireClients("receiveMessage",{speaker.player},{messages = {toSend},is_singular = true})
					end
				end
			end)
		end
	end

	local replicateRawMessage = function(channel,object,list)
		for _,speaker in pairs(list or channel.speakers) do
			task.spawn(function()
				if(speaker.player ~= nil) then
					network:fireClients("receiveMessage",{speaker.player},{messages = {object},is_singular = true})
				end
			end)
		end
	end

	local replicateEditedMessage = function(channel,object,list)
		local messageOwner = object.sender
		for _,speaker in pairs(list or channel.speakers) do
			task.spawn(function()
				if(speaker.player ~= nil and (object.data.isPlayer)) then 
					if(canCommunicate(messageOwner.UserId,speaker.player.UserId)) then
						local toSend = getFilteredMessage(object,speaker)
						if(toSend.replyingTo ~= nil) then
							toSend.replyingTo = getFilteredMessage(toSend.replyingTo,speaker)
							if(not toSend.replyingTo) then -- failed to communicate
								return
							end
						end
						if messageOwner == speaker.player then
							toSend.unfiltered = object.unblacklisted
						end
						network:fireClients("editMessage",{speaker.player},toSend)
					end
				elseif(not object.data.isPlayer and (speaker.player ~= nil)) then
					local toSend = getFilteredMessage(object,speaker)
					if(toSend.replyingTo ~= nil) then
						toSend.replyingTo = getFilteredMessage(toSend.replyingTo,speaker)
						if(not toSend.replyingTo) then -- failed to communicate
							return
						end
					end
					network:fireClients("editMessage",{speaker.player},toSend)
				end
			end)
		end
	end

	local replicateUnfilteredMessage = function(channel,object,list)
		local messageOwner = object.sender
		for _,speaker in pairs(list or channel.speakers) do
			task.spawn(function()
				if(speaker.player ~= nil) then 
					if((not object.data.isPlayer) or canCommunicate(messageOwner.UserId,speaker.player.UserId)) then
						local toSend = shallowCopy(object.data)
						toSend.message = string.rep("_",toSend.length)
						if(toSend.replyingTo ~= nil) then
							toSend.replyingTo = getFilteredMessage(toSend.replyingTo,speaker)
							if(not toSend.replyingTo) then -- failed to communicate
								return
							end
						end
						network:fireClients("receiveMessageCreation",{speaker.player},{messages = {toSend},is_singular = true})
					end
				end
			end)
		end
	end
	
	local fetchChannelHistoryForSpeaker = function(channel,s)
		local speakerModule = speaker
		local speaker = s
		-- Flow: Loop through channel history -> ensure message sender is still in game -> 
		-- see if it's a reply and see if the original message owner is still in-game -> add to history
		local receive = {messages = {}}
		for _,object in pairs(channel.history) do
			if(speaker.player ~= nil) then 
				local canSeeMessage = false
				if(object.data.isPlayer) then
					if(object.senderId ~= nil) then
						if(players:GetPlayerByUserId(object.senderId)) then
							canSeeMessage = canCommunicate(object.senderId,speaker.player.UserId)
						end
					end
				else
					canSeeMessage = true
				end
				if(canSeeMessage) then
					local toSend = getFilteredMessage(object,speaker)
					local checkThreadReplies = function()
						if(toSend.replyingTo ~= nil) then
							if(not players:GetPlayerByUserId(toSend.replyingTo.sender and toSend.replyingTo.sender.UserId or 0)) then
								if(toSend.replyingTo.isPlayer) then
									return -- message doesnt exist
								end
							end
							toSend.replyingTo = getFilteredMessage(toSend.replyingTo,speaker)
							if(not toSend.replyingTo) then -- failed to communicate
								return
							end
						end
					end
					checkThreadReplies()
					if toSend.player == speaker.player then
						toSend.unfiltered = object.unblacklisted
					end
					table.insert(receive.messages,1,toSend)
				end
			else
				table.insert(receive.messages,1,object)
			end
		end
		for idx,message in pairs(receive.messages) do
			if message.historyLogic and message.player then
				local canSee = message.historyLogic(message,message.player,speaker.player)
				if not canSee then
					table.remove(receive.messages,idx)
				elseif canSee then
					if message.replyingTo ~= nil then
						local replySpeaker = speakerModule:getByName("Unknown")
						local viewableMessage = message.replyingTo
						local canSend = message.historyLogic(viewableMessage,viewableMessage.player,speaker.player)
						if(not canSend) then
							message.replyingTo.message = "-----"
						end
					end
				end
			end
		end
		local found = {}
		for idx,message in pairs(receive.messages) do
			if found[message.id] then
				table.remove(receive.messages,idx)
			end
			found[message.id] = true
		end
		return receive
	end

	function channelModule.new(name,autojoin,handlingMessagesOnOwn)
		if(channelsList[name] ~= nil) then
			warn(("[Better Chat]: Channel '%s' already exists."):format(name))
			return false
		end
		local channel = {}
		channel.name = name
		channel.handlingMessagesOnOwn = (handlingMessagesOnOwn == true)
		channel.autoJoin = autojoin
		channel.speakers = {}
		channel.history = {}
		channel.messageProcessing = {}
		channel.messageCount = 0
		channel.events = {
			chatted = signal.new(),
			speakerAdded = signal.new(),
			speakerRemoved = signal.new(),
			messageRequested = signal.new()
		}
		
		function channel:handleMessageRequest(...)
			channel.events.messageRequested:Fire(...)
		end

		function channel:Destroy()
			channelsList[name] = nil
			for _,speaker in pairs(channel.speakers) do
				speaker.channels[name] = nil
				speaker.events.channelUpdated:Fire()
			end
			for _,event in pairs(channel.events) do
				event:DisconnectAll()
			end
			for k,v in pairs(channel) do
				channel[k] = nil
			end
		end

		function channel:registerMessageProcess(name,callback)
			table.insert(channel.messageProcessing,{
				name = name,
				callback = callback
			})
		end
		
		local removeAt = {}

		function channel:unregisterMessageProcess(name)
			for key,processData in pairs(channel.messageProcessing) do
				if(processData.name == name) then
					table.remove(channel.messageProcessing,key)
					break
				end
			end
		end

		function channel:canSpeakerTalk(speaker)
			return(table.find(channel.speakers,speaker) ~= nil)
		end

		function channel:addSpeaker(speaker)
			if(not table.find(channel.speakers,speaker)) then
				table.insert(channel.speakers,speaker)
				speaker.channels[name] = channel
				speaker.events.channelUpdated:Fire()
				channel.events.speakerAdded:Fire(speaker)
			end
		end

		function channel:removeSpeaker(speaker)
			local key = table.find(channel.speakers,speaker)
			if(key) then
				if speaker.player then
					
				end
				table.remove(channel.speakers,key)
				speaker.channels[name] = nil
				speaker.events.channelUpdated:Fire()
				channel.events.speakerRemoved:Fire(speaker.name)
			end
		end

		local callbacks = {
			onFiltered = function(object)
				replicateMessage(channel,object)
			end,
			onCreated = function(object)
				replicateUnfilteredMessage(channel,object)
			end,
			processMessage = function(object,isFiltered)
				for _,process in pairs(channel.messageProcessing) do
					process.callback(object)
				end
			end,
		}
		
		function channel:sendMessageToSpecificUsers(list,speaker,message,historyLogic,hookMessage,replyingTo)
			channel:sendMessage(speaker,message,replyingTo,{
				onFiltered = function(object)
					replicateMessage(channel,object,list)
				end,
				onCreated = function(object)
					hookMessage(object.data)
					replicateUnfilteredMessage(channel,object,list)
				end,
				processMessage = callbacks.processMessage
			},historyLogic)
		end

		function channel:sendMessage(speaker,message,replyTo,cb,historyLogic)
			local object = messages.new(message,speaker,name,replyTo,cb or callbacks,false,historyLogic)
			channel.messageCount += 1
			table.insert(channel.history,1,object)
			if(#channel.history > messagesLimit) then
				table.remove(channel.history,#channel.history)
			end
			channel.events.chatted:Fire(object)
			return object
		end
		
		function channel:editMessage(id,new)
			for _,message in pairs(channel.history) do
				if(message.data.id == id) then
					messages.edit(message,new)
					replicateEditedMessage(channel,message)
					break
				end
			end
		end
		
		function channel:deleteMessage(id)
			for _,message in pairs(channel.history) do
				if(message.data.id == id) then
					messages.delete(message)
					replicateEditedMessage(channel,message)
					break
				end
			end
		end

		function channel:getMessageById(id)
			for _,message in pairs(channel.history) do
				if(message.data.id == id) then
					return message
				end
			end
		end

		function channel:getHistoryForSpeaker(speaker)
			if(channel:canSpeakerTalk(speaker)) then
				return fetchChannelHistoryForSpeaker(channel,speaker)
			end
		end

		channelsList[name] = channel
		for _,speaker in pairs(speaker:getSpeakers()) do
			channelModule:findAutojoinForSpeaker(speaker)
		end
		
		channelAdded:Fire(channel)
		
		return true,channel
	end

	function channelModule:getByName(name)
		return channelsList[name]
	end

	function channelModule:findAutojoinForSpeaker(speaker)
		for _,channel in pairs(channelsList) do
			if(channel.autoJoin) then
				channel:addSpeaker(speaker)
			end
		end
	end

	function channelModule:setup(speakerModule,messageModule)
		speaker = speakerModule
		messages = messageModule
	end
	
	channelModule.channelAdded = channelAdded
	
	function channelModule:onChannel(callback)
		for _,channel in pairs(channelsList) do
			task.spawn(callback,channel)
		end
		channelModule.channelAdded:Connect(callback)
	end

	return channelModule
end