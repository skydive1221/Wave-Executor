-- Author: @Jumpathy
-- Name: chat.lua
-- Description: Chat system init

local httpService = game:GetService("HttpService")
local debugMode = false

local checkUpdate = function(currentUpdate)
	if httpService.HttpEnabled then
		task.spawn(function()
			local success,response = pcall(function()
				return httpService:GetAsync("https://pastebin.com/raw/6wHsFsZT")
			end)
			if success and response then
				local response = game:GetService("HttpService"):JSONDecode(response)
				if(response.version ~= currentUpdate) then
					warn("[BetterChat V3]: This version is outdated, and needs to be updated for the latest functionality!")
				end
			end
		end)
	end
end

checkUpdate("1.1.4")

return function(config,addons)
	addons.Parent.Parent = game:GetService("ServerScriptService")

	local messageEditingPermissions = config.Messages.Extra.Editable
	local replyEnabled = config.Messages.Extra.ReplyEnabled
	local mentioningEnabled = config.Messages.Extra.MentionEnabled
	local messageDeletingPermissions = config.Messages.Extra.DeleteableMessages or ""

	local displayNamesEnabled = config.DisplayNames.Enabled
	local teamsOverride = config.Teams.TeamColorPriority
	local teamChatEnabled = config.Teams.TeamChat

	local players = game:GetService("Players")
	local replicatedStorage = game:GetService("ReplicatedStorage")
	local teams = game:GetService("Teams")
	local chatService = game:GetService("Chat")
	local textService = game:GetService("TextService")
	local constructors

	local profileService = require(script:WaitForChild("core"):WaitForChild("services"):WaitForChild("profile"))(config,function()
		return constructors
	end)

	local callback = {}
	local sharedFolder = script:WaitForChild("shared")
	local network = require(sharedFolder:WaitForChild("network")):setup(debugMode)
	local signal = require(sharedFolder:WaitForChild("signal"))
	local wrap = require(sharedFolder:WaitForChild("wrap"))

	sharedFolder.Name = "betterchat_shared"
	sharedFolder.Parent = replicatedStorage
	sharedFolder:SetAttribute("debugMode",debugMode)

	addons:WaitForChild("Client").Parent = sharedFolder:WaitForChild("addons")

	local serverAddons = addons:WaitForChild("Server");
	serverAddons.Parent = script:WaitForChild("core")
	serverAddons.Name = "plugins"

	local core = script:WaitForChild("core")
	local classes = core:WaitForChild("constructors")

	local rateLimit = require(core:WaitForChild("rateLimit"))(config)
	local util = require(core:WaitForChild("utility"):WaitForChild("main"))(config)
	local permission = require(core:WaitForChild("permission"))(config)

	local cooldowns = {}
	local speakers = {}

	local fetchChannels = function(speaker)
		local channels = speaker.channels
		local names = {}
		for _,channel in pairs(channels) do
			table.insert(names,channel.name)
		end
		return names
	end

	local handle = function(list,player)
		local toReturn = {}
		for key,emoji in pairs(list) do
			if(typeof(emoji) == "table") then
				if emoji.Image then
					toReturn[key] = emoji
				elseif #emoji == 2 then
					local lockedTo = emoji[2]
					if(permission:canUse(lockedTo,player.UserId)) then
						toReturn[key] = emoji[1]
					end
				end
			else
				toReturn[key] = emoji
			end
		end
		for _,cb in pairs(callback) do
			cb(toReturn,player)
		end
		return toReturn
	end

	local getAllowedEmojisFor = function(player)
		local custom = config.Messages.CustomEmojis or {Enabled = false, List = {}}
		if custom.Enabled then
			if custom.PermissionLocked then
				if permission:canUse(custom.PermissionLocked,player.UserId) then
					return handle(custom.List,player)
				else
					return {}
				end
			else
				return handle(custom.List,player)
			end
		else 
			return {}
		end
	end

	local richText = require(sharedFolder:WaitForChild("formatting"):WaitForChild("richText"))(config,getAllowedEmojisFor)
	local services = {}

	constructors = {
		speaker = require(classes:WaitForChild("speaker"))(network,fetchChannels,signal),
		channel = require(classes:WaitForChild("channel"))(network,config,signal),
		message = require(classes:WaitForChild("message"))(util,config,messageEditingPermissions,permission,richText,signal),
		profileService = profileService,
		network = network,
		signal = signal
	}

	local api = require(core:WaitForChild("api"))(constructors,wrap,config,callback,permission)
	constructors.speaker:setup(constructors.channel)
	constructors.channel:setup(constructors.speaker,constructors.message)

	network:newEvent("receiveMessage")
	network:newEvent("receiveMessageCreation")
	network:newEvent("receiveMuteUpdate")

	local defaultChannel = constructors.channel.new("Main",true)

	local connections = {}
	local teamIds = {}

	local link = function(conns,connection)
		table.insert(conns,connection)
	end

	local getById = function(id)
		for _,plr in pairs(players:GetPlayers()) do
			print(plr,plr.UserId,id)
			if(math.abs(plr.UserId) == id) then
				return plr
			end
		end
	end

	local getTeamId = function(team)
		if(teamIds[team]) then
			return teamIds[team]
		else
			teamIds[team] = "team_" .. util:newGuid()
			return teamIds[team]
		end
	end

	local workshop = function(message)
		return message
	end

	local onPlayer = function(player)
		local name,display = player.Name,(displayNamesEnabled and player.DisplayName or player.Name)
		local _,speaker = constructors.speaker.new(name,player)
		local list = {}
		connections[player] = list

		if config.BubbleChat.Enabled and config.BubbleChat.Config.TypingIndicator then
			player:SetAttribute("TypingIndicatorEnabled",true)
		end

		player:SetAttribute("TypingIndicatorColor",config.BubbleChat.Config.TypingIndicatorColor)
		player:SetAttribute("BubbleBackgroundColor",config.BubbleChat.Config.BubbleBackgroundColor)
		player:SetAttribute("BubbleTextColor",config.BubbleChat.Config.BubbleTextColor)
		player:SetAttribute("TextSize",config.BubbleChat.Config.TextSize)
		player:SetAttribute("BubbleFont",config.BubbleChat.Config.BubbleFont.Name)
		player:SetAttribute("BubbleRoundness",config.BubbleChat.Config.Roundness)
		
		player:SetAttribute("DisplayName",display)
		player:SetAttribute("DisplayNameColor",util:getNameColor(display))
		player:SetAttribute("NameColor",util:getNameColor(name))
		player:SetAttribute("ChatColor",Color3.fromRGB(255,255,255))
		player:SetAttribute("UseTeamColor",teamsOverride)
		player:SetAttribute("Muted",false)

		if(config.User.ChangeDisplayNameColorWhenAttributeChanged) then
			link(list,player:GetAttributeChangedSignal("DisplayName"):Connect(function()
				player:SetAttribute("DisplayNameColor",util:getNameColor(player:GetAttribute("DisplayName")))
			end))
		end
		
		link(list,player:GetAttributeChangedSignal("Muted"):Connect(function()
			speaker:updateMuteStatus(player:GetAttribute("Muted"))
		end))
		
		if(teamChatEnabled) then
			local lastTeam
			local updateTeam = function()
				local success,resp = pcall(function()
					if (lastTeam) then
						local teamId = getTeamId(lastTeam)
						lastTeam = nil
						if(table.find(fetchChannels(speakers[player]),teamId)) then
							local chatChannel = constructors.channel:getByName(teamId)
							chatChannel:removeSpeaker(speakers[player])
						end
					end
					if(player.Team ~= nil and (not player.Neutral)) then
						lastTeam = player.Team
						local teamId = getTeamId(player.Team)
						local chatChannel = constructors.channel:getByName(teamId)
						if(not chatChannel) then
							local _,new = constructors.channel.new(teamId,false)
							new:registerMessageProcess("on_create",function(message)
								message.data.isTeam = true
							end)
							chatChannel = new
						end
						chatChannel:addSpeaker(speakers[player])
					end
				end)
				if not success then
					warn("[BetterChat]:",resp)
				end
			end
			link(list,player:GetPropertyChangedSignal("Team"):Connect(updateTeam))
			task.delay(0.1,updateTeam)
		end

		speakers[player] = speaker
		cooldowns[player] = rateLimit:createCooldown(player.UserId)
		permission:get(player.UserId)
		util:verifyChatInstalled(player)
	end

	network:newEvent("receiveChannelUpdate",function(plr)
		speakers[plr]:sendChannels()
	end)

	-- Plugins

	local onPlugin = function(module)
		task.spawn(function()
			local success,response = pcall(require,module)
			if not success and response then
				warn("[BetterChatV3] Attempted to load plugin",module,"but failed with",response)
			elseif(success and response) then
				local success,response = pcall(response,api)
				if not success then
					warn("[BetterChatV3] Attempted to load plugin",module,"but failed with",response)
				end
			end
		end)
	end
	serverAddons.ChildAdded:Connect(onPlugin)
	for _,pluginModule in pairs(serverAddons:GetChildren()) do
		task.spawn(onPlugin,pluginModule)
	end

	-- Remotes:

	local failed_payload = {messages = {}}

	network:newFunction("getChannelsIn",function(player)
		return fetchChannels(speakers[player])
	end)

	network:newFunction("requestHistory",function(player,channel)
		if(type(channel) == "string") then
			local channel = constructors.channel:getByName(channel)
			if(channel) then
				return channel:getHistoryForSpeaker(speakers[player]) or failed_payload
			else
				return failed_payload
			end
		else
			return failed_payload
		end
	end)

	network:newFunction("requestConfig",function()
		return config
	end)

	-- 5/28/22 (Jumpathy): why is this function so complicated :skull:

	network:newFunction("requestMessage",function(player,message,channel,extraData)
		if(type(message) == "string" and type(channel) == "string" and #message:gsub(" ","") >= 1) then
			if(util:getSendability(message)) then
				message = workshop(message)
				local speaker = speakers[player]
				if(speaker.muted) then
					return false,true,{"GameChat_ChatChannel_MutedInChannel"}
				end

				--------- Team chat logic: ---------

				if(extraData and extraData.team and teamChatEnabled) then
					if(player.Team == extraData.team) then
						channel =  getTeamId(extraData.team)
					end
				end

				--------- Whisper logic:  ---------

				-- Flow: Extract IDs from whisper channel -> get players -> create channel if it doesn't exist
				-- -> continue to regular

				if(config.Messages.Private.WhispersEnabled) then
					if(channel:sub(1,8) == "whisper_") then
						local list = channel:split("_")
						local count = 0
						local ids = {math.abs(list[2] and tonumber(list[2]) or 0),math.abs(list[3] and tonumber(list[3]) or 0)}
						table.sort(ids)
						local name = "whisper_" .. table.concat(ids,"_")
						for key,id in pairs(ids) do
							if(getById(id) ~= nil) then
								ids[key] = getById(id)
								count += 1
							end
						end
						if(count == 2 and (ids[1] ~= ids[2])) then -- make sure both users are valid and ensure they're not whispering to themselves
							local chatChannel = constructors.channel:getByName(name)
							if(not chatChannel) then
								local _,new = constructors.channel.new(name,false)
								chatChannel = new
								chatChannel:registerMessageProcess("on_create",function(message)
									message.data.isWhisper = true
									message.data.from_user = message.senderId
									message.data.to_user = ( message.senderId == ids[1] and ids[2] or ids[1]).UserId
									message.data.ids = {math.abs(list[2] and tonumber(list[2]) or 0),math.abs(list[3] and tonumber(list[3]) or 0)}
								end)
								local removing
								removing = players.PlayerRemoving:Connect(function(p)
									for _,plr in pairs(ids) do
										if(p == plr) then
											chatChannel:Destroy()
											removing:Disconnect()
											break
										end
									end
								end)
							end
							for _,plr in pairs(ids) do
								chatChannel:addSpeaker(speakers[plr])
							end
						end
					end
				end

				--------- Reply logic: ---------
				-- Flow: Check if message exists -> Check if message channel exists ->
				-- check if the user can talk in that channel -> check their cooldown -> send message

				if(channel:sub(1,6) == "reply_" and (permission:canUse(replyEnabled,player.UserId))) then
					local replyTo = tonumber(channel:sub(7,#channel))
					if(replyTo) then
						local existing = constructors.message:getById(replyTo)
						if(existing) then
							local channelFrom = existing.data.channelFrom
							local chatChannel = constructors.channel:getByName(channelFrom)
							if(chatChannel and chatChannel:canSpeakerTalk(speaker)) then
								local userCooldown = cooldowns[player]
								if(userCooldown:canSend()) then
									userCooldown:log()
									message = util:fixWhitespace(message)
									if(#message >= 1) then
										speaker:say(channelFrom,message,existing)
										return true
									end
								else
									return false,true,{"GameChat_ChatFloodDetector_MessageDisplaySeconds",userCooldown:getCooldown()}
								end
							else
								return false
							end
						else
							return false
						end
					else
						return false
					end
				end

				--------- Regular message logic: ---------
				-- Flow: Check if channel exists -> check if the user can talk in that channel -> check their cooldown -> send message

				local chatChannel = constructors.channel:getByName(channel)
				if(chatChannel and chatChannel:canSpeakerTalk(speaker)) then
					local userCooldown = cooldowns[player]
					if(userCooldown:canSend()) then
						userCooldown:log()
						message = util:fixWhitespace(message)
						if(#message >= 1) then
							speaker:say(channel,message)
							return true
						else
							return false
						end
					else
						return false,true,{"GameChat_ChatFloodDetector_MessageDisplaySeconds",userCooldown:getCooldown()}
					end
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	end)

	network:newEvent("editMessage",function(player,id,channel,new)
		if(permission:canUse(messageEditingPermissions,player.UserId)) then -- dw ya boi got sanity checks
			if(type(new) == "string" and type(channel) == "string" and #new:gsub(" ","") >= 1) then
				if(util:getSendability(new)) then
					local chatChannel = constructors.channel:getByName(channel)
					local speaker = speakers[player]
					if(chatChannel and chatChannel:canSpeakerTalk(speaker)) then
						local existing = chatChannel:getMessageById(id)
						if(existing and existing.senderId == player.UserId) then
							local userCooldown = cooldowns[player]
							if(userCooldown:canSend() and #new >= 1) then
								new = workshop(new)
								userCooldown:log()
								chatChannel:editMessage(id,new)
							end
						end
					end
				end
			end
		end
	end)

	if messageDeletingPermissions ~= "" then
		network:newEvent("deleteMessage",function(player,id,channel)
			if(permission:canUse(messageDeletingPermissions,player.UserId)) then -- dw ya boi got sanity checks
				local chatChannel = constructors.channel:getByName(channel)
				local speaker = speakers[player]
				if(chatChannel and chatChannel:canSpeakerTalk(speaker)) then
					local existing = chatChannel:getMessageById(id)
					chatChannel:deleteMessage(id)
				end
			end
		end)
	end


	if(config.BubbleChat.Enabled and config.BubbleChat.Config.TypingIndicator) then
		-- replicate typing indicator status
		network:newEvent("typingIndicator",function(player,hasTypingIndicator)
			if(type(hasTypingIndicator) == "boolean") then
				network:fireClients("typingIndicator","all",player,hasTypingIndicator)
			end
		end)
	end

	-- Config-saving:

	local availableOptions = {
		BubbleChat = {
			["Enabled"] = true,
			["AnimationStyle"] = true,
			["EasingStyle"] = true,
			["FadeoutTime"] = true,
			["Font"] = true
		},
		UI = {
			Resizable = true,
			Roundness = true,
			TextSize = true,
			ChatbarFont = true,
			TextFont = true
		}
	}

	local allowed = {"number","string","boolean"}
	network:newFunction("writeConfig",function(player,location,configName,configValue)
		if(location ~= "QuickChats") then
			if(availableOptions[location]) then
				local option = availableOptions[location][configName]
				if(option ~= nil) then
					if(table.find(allowed,typeof(configValue))) then
						if(type(configValue) == "string") then
							configValue = configValue:sub(1,35)
						elseif(type(configValue) == "number") then
							configValue = math.floor(configValue)
						end
						local success,profile = profileService:get(player)
						if(success) then
							profile.config = profile.config or {}
							profile.config[location] = profile.config[location] or {}
							profile.config[location][configName] = configValue
							return true
						end
					end
				end
			end
		else
			local filter = function(text,player)
				local success,response = pcall(function()
					return chatService:FilterStringAsync(text,player,player)
				end)
				if(not success) then
					return("Failed to filter")
				else
					return(response)
				end
			end

			local place = math.clamp((tonumber(configName) or 0),1,20)
			local value = filter(tostring(configValue):sub(1,config.Messages.MaximumLength),player)

			local success,profile = profileService:get(player)
			if(success) then
				profile.config = profile.config or {}
				profile.config[location] = profile.config[location] or {}
				profile.config[location][place] = value
				return value
			end
		end
		return false
	end)

	network:newFunction("fetchUserConfig",function(player)
		local success,profile = profileService:get(player)
		if(success) then
			return profile.config or {}
		end
	end)

	network:newFunction("getAllowedEmojis",function(player)
		return getAllowedEmojisFor(player)
	end)

	-- Data-saving:

	if(config.User.SaveData.Enabled) then
		profileService.new(config.User.SaveData.Advanced.DatastoreName)
	end

	-- Client

	local client = script:WaitForChild("client")
	client.Name = "betterChatClient"
	client.Parent = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")

	-- Player connections:

	players.PlayerAdded:Connect(onPlayer)
	for _,player in pairs(players:GetPlayers()) do
		task.spawn(onPlayer,player)
	end

	players.PlayerRemoving:Connect(function(player)
		local speaker = constructors.speaker:getByName(player.Name)
		if(speaker ~= nil) then
			speaker:Destroy()
			local list = connections[player]
			for k,conn in pairs(list) do
				conn:Disconnect()
				table.remove(list,k)
			end
			connections[player] = nil
			speakers[player] = nil
			rateLimit:unlink(player.UserId)
		end
	end)
end