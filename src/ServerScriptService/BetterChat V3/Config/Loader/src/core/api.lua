-- Author: @Jumpathy
-- Name: api.lua
-- Description: Better chat server API

return function(constructors,wrap,config)
	local topic = "betterchat_bl_update"
	local datastoreName = "betterchat_blacklisted_words2"
	local blacklistHardcoded = config.Messages.BlacklistedWords or {}
	local blacklistCanUseDatastores = config.Messages.BlacklistCanUseDatastores == true

	local api = {}
	local message = constructors.message
	local textChatService = game:GetService("TextChatService")
	local datastoreService = game:GetService("DataStoreService")
	local messagingService = game:GetService("MessagingService")
	local blacklistedWords = datastoreService:GetDataStore(datastoreName)
	local chattedEvent = constructors.signal.new()

	local blacklistEnabled = config.Messages.BlacklistEnabled == true
	local blacklist = {}
	local getBlacklisted;

	if blacklistEnabled then
		if blacklistCanUseDatastores then
			local getBlacklist = function()
				local success,response = pcall(function()
					return blacklistedWords:GetAsync("list")
				end)
				if success then
					return response or {}
				else
					warn("[failed to fetch blacklist]",response)
				end
			end

			task.spawn(function()
				local new = getBlacklist()
				if new then
					blacklist = new
				else
					repeat
						warn("[retrying fetching blacklist]")
						new = getBlacklist()
						task.wait(3)
					until new ~= nil
					blacklist = new
				end
			end)

			task.spawn(function()
				local success,response = pcall(function()
					messagingService:SubscribeAsync(topic,function(data)
						blacklist = data.Data
					end)
				end)
				if not success then
					warn("[failed to subscribe]:",response)
				end
			end)
		end

		getBlacklisted = function()
			local list = {}
			for _,obj in pairs(blacklistHardcoded) do
				table.insert(list,obj)
			end
			for _,obj in pairs(blacklist) do
				table.insert(list,obj)
			end
			return list
		end
	end

	api.channel = constructors.channel
	api.speaker = constructors.speaker
	api.network = constructors.network
	api.network:newEvent("systemMessage")

	function api:systemMessage(text)
		api.network:fireClients("systemMessage","all",text)
	end

	function api:resolveMessageContentForPlayer(object,player)
		local data = object.data
		if not data.isPlayer then
			return true,object.message
		else
			if data.filteredSuccessfully then
				local canTalk = constructors.channel.canCommunicate(player.UserId,data.senderId)
				if canTalk then
					return true,object.filtered:GetChatForUserAsync(player.UserId)
				else
					return false,"These users cannot interact"
				end
			else
				return false,"Message was not filtered"
			end
		end
	end

	function api:getMessageById(id)
		if id then
			local object = message:getById(id)
			if object then
				return true,object
			else
				return false
			end
		else
			return false
		end
	end

	if blacklistEnabled then
		if blacklistCanUseDatastores then
			function api:blacklistWord(word,state)
				local currentBlacklist;
				local success,response = pcall(function()
					blacklistedWords:UpdateAsync("list",function(old)
						if not old then
							old = {}
						end
						local idx = table.find(old,word)
						if not state then
							if idx then
								table.remove(old,idx)
							end
						else
							if not idx then
								table.insert(old,word)
							end
						end
						currentBlacklist = old
						return old
					end)
				end)
				if success then
					blacklist = currentBlacklist
					task.spawn(function()
						messagingService:PublishAsync(topic,blacklist)
					end)
				else
					warn("[failed to write]:",response)
				end
			end
		end

		function api:getBlacklist()
			return getBlacklisted()
		end
	end

	local escapePattern = function(pattern)
		local magic_characters = "%%%^%$%(%)%.%[%]%*%+%-%?"
		return (pattern:gsub("[" .. magic_characters .. "]", "%%%1"))
	end

	constructors.channel:onChannel(function(channel)
		channel.events.chatted:Connect(function(message)
			chattedEvent:Fire(message)
		end)
		channel:registerMessageProcess("word_blacklist",function(obj,filtered)
			if not obj.filtered then
				obj.unblacklisted = obj.message
				for _,word in pairs(getBlacklisted()) do
					obj.message = obj.message:gsub(escapePattern(word),string.rep("#",#word))
				end
			end
		end)
	end)

	api.chatted = chattedEvent
	api.messageDeleted = message.messageDeleted

	return wrap(api)
end