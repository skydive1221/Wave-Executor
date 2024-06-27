-- Author: @Jumpathy
-- Name: message.lua
-- Description: Message object wrapper

return function(utility,config,messageEditingEnabled,permission)
	local message = {}
	local filter = require(script.Parent.Parent:WaitForChild("filter"))(config)
	local httpService = game:GetService("HttpService")
	local ids = 0
	local messages = {}
	local combine = function(speaker,existing)
		for _, tag in pairs (speaker.tags) do
			table.insert(existing,1,tag)
		end
		return existing
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
	
	function message.new(text,speaker,channel,replyTo,callbacks,isBroadcast,historyLogic)
		ids += 1
		local messageId = ids
		local canUseMeCommand = (speaker.player and permission:canUse(config.Messages.Extra.MeCommand,speaker.player.UserId))
		local senderId = speaker.player and speaker.player.UserId or speaker.id
		local viewport = getViewportFrom(speaker.player)
		
		local object = {
			data = {
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
				editingEnabled = speaker.player and permission:canUse(messageEditingEnabled,speaker.player.UserId),
				senderId = senderId,
				requiredToReply = (speaker.player and permission:tonumber(config.Messages.Extra.ReplyEnabled)) or 0,
				userPermission = (speaker.player and permission:get(speaker.player.UserId)) or 0,
				markdownEnabled = (speaker.player and permission:canUse(config.Messages.Extra.MarkdownEnabled,speaker.player.UserId)) or 0,
				mentioningEnabled = (speaker.player and permission:canUse(config.Messages.Extra.MentionEnabled,speaker.player.UserId)) or 0,
				isMeCommand = false,
				tags = combine(speaker,(speaker.player and permission:getUserTags(speaker.player)or{})),
				chatColor = get(speaker,"ChatColor",getChatColor)
			},
			filtered = nil,
			sender = speaker.player,
			senderId = senderId,
			message = text
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
		local success,filterObj = filter.new(object.message,speaker.player,isBroadcast)
		object.filtered = filterObj
		object.data.filteredSuccessfully = success
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
		local success,filterObj = filter.new(newText,message.sender)
		message.filtered = filterObj
		message.data.wwww = success
		message.data.edits += 1
	end
	
	function message.delete(message)
		local success,filterObj = filter.new("Unsent a message",nil)
		message.filtered = filterObj
		message.data.filteredSuccessfully = success
		message.data.deleted = true
	end
	
	function message:getById(id)
		return messages[id]
	end
	
	return message
end