-- Author: @Jumpathy
-- Name: message.lua
-- Description: Message object wrapper

return function(utility,config,messageEditingEnabled,permission,richText,signal)
	local message = {}
	local filter = require(script.Parent.Parent:WaitForChild("filter"))(config,richText,message)
	local httpService = game:GetService("HttpService")
	local ids = 0
	local messages = {}
	
	local combine = function(speaker,existing)
		for _, tag in pairs (speaker.tags) do
			table.insert(existing,1,tag)
		end
		return existing
	end

	local deepCopy;
	deepCopy = function(original)
		local copy
		if type(original) == "table" then
			copy = {}
			for key, value in next, original, nil do
				copy[deepCopy(key)] = deepCopy(value)
			end
		else
			copy = original
		end
		return copy
	end

	local get = function(speaker,property,callback)
		if(speaker.player) then
			if(property ~= "TeamColor") then
				return speaker.player:GetAttribute(property)
			elseif(speaker.player:GetAttribute("UseTeamColor")) then
				return(speaker.player.Team ~= nil and speaker.player.TeamColor.Color)
			end
		else
			return callback(speaker,property)
		end
	end

	local getExtraData = function(speaker,propertyName)
		if(propertyName == "DisplayName") then
			return speaker.name
		end
	end

	local getChatColor = function(speaker,propertyName)
		return speaker.chatColor or Color3.fromRGB(255,255,255)
	end

	local getNameColor = function(speaker,propertyName)
		return utility:getNameColor(speaker.name)
	end

	local returnTrue = function()
		return true
	end

	local returnNil = function()
		return nil
	end

	local getViewportFrom = function(player)
		if(player and config.Messages.UseViewportForIcon and player.Character and config.Messages.IncludeIcon) then
			return utility:constructViewportDescription(player.Character)
		end
	end

	local no = function() end
	local blank = {onCreated = no, processMessage = no, onFiltered = no}
	local deleteablePerm = config.Messages.Extra.DeleteableMessages

	function message.new(text,speaker,channel,replyTo,callbacks,isBroadcast,historyLogic)
		ids += 1
		local messageId = ids
		local canUseMeCommand = (speaker.player and permission:canUse(config.Messages.Extra.MeCommand,speaker.player.UserId))
		local senderId = speaker.player and speaker.player.UserId or speaker.id
		local viewport = getViewportFrom(speaker.player)
		local markdownEnabled = (speaker.player and permission:canUse(config.Messages.Extra.MarkdownEnabled,speaker.player.UserId)) or 0

		local object = {
			data = { --> jesus :sobbing:
				timeSent = workspace:GetServerTimeNow(),
				historyLogic = historyLogic,
				isPlayer = (speaker.player ~= nil),
				guid = httpService:GenerateGUID(false),
				replyingTo = replyTo,
				length = string.len(text),
				displayName = get(speaker,"DisplayName",getExtraData),
				displayNameColor = get(speaker,"DisplayNameColor",getNameColor),
				nameColor = get(speaker,"NameColor",getNameColor),
				name = speaker.name,
				teamPriority = get(speaker,"UseTeamColor",returnTrue),
				teamColor = get(speaker,"TeamColor",returnNil),
				filteredSuccessfully = false,
				class = replyTo and "reply" or "regular",
				player = speaker.player,
				viewportData = viewport,
				id = messageId,
				channelFrom = channel,
				senderId = senderId,
				isMeCommand = false,
				isBroadcast = isBroadcast,
				editingEnabled = speaker.player and permission:canUse(messageEditingEnabled,speaker.player.UserId),
				requiredToReply = (speaker.player and permission:tonumber(config.Messages.Extra.ReplyEnabled)) or 0,
				userPermission = (speaker.player and permission:get(speaker.player.UserId)) or 0,
				markdownEnabled = markdownEnabled,
				mentioningEnabled = (speaker.player and permission:canUse(config.Messages.Extra.MentionEnabled,speaker.player.UserId)) or 0,
				deletingEnabled = deleteablePerm and (speaker.player and permission:canUse(deleteablePerm,speaker.player.UserId)) or false,
				tags = combine(speaker,(speaker.player and permission:getUserTags(speaker.player)or{})),
				chatColor = get(speaker,"ChatColor",getChatColor),
			},
			filtered = nil,
			sender = speaker.player,
			senderId = senderId,
			message = text,
			unblacklisted = text
		}
		if(not viewport and (config.Messages.IncludeIcon and not object.data.player)) then
			object.data.imageId = speaker.icon
		end
		if(canUseMeCommand) then
			object.data.isMeCommand = text:sub(1,3) == "/me"
		end
		callbacks = callbacks or blank
		messages[messageId] = object
		callbacks.processMessage(object,false)
		callbacks.onCreated(object)
		local success,filterObj,emojis = filter.new(object.message,speaker.player,isBroadcast,markdownEnabled)
		object.filtered = filterObj
		object.data.filteredSuccessfully = success
		if emojis then
			object.data.customEmojis = emojis
		end
		callbacks.onFiltered(object)
		callbacks.processMessage(object,true)
		return messages[messageId]
	end

	function message.edit(message,newText)
		if(not message.data.edits) then
			message.data.edits = 0
			message.originalFilter = message
		end
		if(message.data.isMeCommand) then
			newText = "/me " .. newText
		end
		local success,filterObj,emojis = filter.new(newText,message.sender,message.data.isBroadcast,message.data.markdownEnabled)
		if emojis then
			message.data.customEmojis = emojis
		end
		message.filtered = filterObj
		message.data.filteredSuccessfully = success
		message.data.edits += 1
	end

	function message.delete(obj)
		message.messageDeleted:Fire(deepCopy(obj))
		local success,filterObj = filter.new("Unsent a message",nil)
		obj.filtered = filterObj
		obj.data.filteredSuccessfully = success
		obj.data.deleted = true
	end

	function message:getById(id)
		return messages[id]
	end
	
	message.messageDeleted = signal.new()

	return message
end