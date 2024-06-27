-- Author: @Jumpathy
-- Name: poll.lua
-- Description: Server poll manager
-- Note: I literally had to add like 55,000 checks to make sure someone doesn't break it with a wrong request

--[[
	Request reference
	{
		range {min,max,step}
		image <string>
		seeWhoVoted <bool>
		multipleChoice {}
		expiresIn <number>
		title <string>
		pollType <string> MultipleChoice | Number 
	}
]]

local marketplaceService = game:GetService("MarketplaceService")
local maxLength = 30
local keys = {"range","image","seeWhoVoted","multipleChoice","expiresIn","title","pollType"}

local verifyImage = function(text)
	local nums = text:gsub("%D+","")
	local id = tonumber(nums)
	if(id) then
		local success,response = pcall(function()
			return marketplaceService:GetProductInfo(id)
		end)
		if(response and success) then
			return(response.AssetTypeId == 1)
		end
	end
end

local filter = function(text,player)
	local success,response = pcall(function()
		return game:GetService("Chat"):FilterStringForBroadcast(text,player)
	end)
	if(success and response) then
		return response
	else
		warn("Failed to filter poll text",response)
		return string.rep("_",#text)
	end
end

return function(network,config,signal,speakers,constructors,permission)
	local activePolls = {}
	local required = config.Polls.Permission
	
	local ids = 0

	local create = function(data,player,channel) --> called with parsed input
		data.votes = {}
		data.channel = channel.name
		data.creator = player.UserId

		if(data.pollType == "MultipleChoice") then
			local thread =  {
				channel = channel,
				owner = player.UserId,
				votes = {},
				update = function(self)
					network:fireClients("pollUpdate",channel.speakers,data)
				end,
				vote = function(self,player,cast)
					local choices = data.multipleChoice
					if(table.find(choices,cast) and (not self.votes[player.UserId])) then
						self.votes[player.UserId] = cast
						if(data.seeWhoVoted) then
							data.votes[cast] = data.votes[cast] or {}
							table.insert(data.votes[cast],player.UserId)
						else
							data.votes[cast] = data.votes[cast] or 0
							data.votes[cast] += 1
						end
						self:update()
					end
				end,
				hasVoted = function(self,userId)
					return self.votes[userId] ~= nil
				end,
				data = data
			}	

			activePolls[data.id] = thread
			local disconnect = channel:postPoll(data,thread)
			local stop = function()
				disconnect()
				data.ended = true
				thread:update()
			end
			thread.stop = stop
			thread:update()
		else
			data.rangeChoices = {}
			local range = data.range

			for i = 1,range.max,range.step do
				if(i >= range.min) then
					table.insert(data.rangeChoices,i)
				end
			end

			local thread = {
				channel = channel,
				owner = player.UserId,
				votes = {},
				update = function(self)
					network:fireClients("pollUpdate",channel.speakers,data)
				end,
				vote = function(self,player,cast)
					if(table.find(data.rangeChoices,cast) and (not self.votes[player.UserId])) then
						self.votes[player.UserId] = cast
						data.votes[cast] = data.votes[cast] or 0
						data.votes[cast] += 1
						self:update()
					end
				end,
				hasVoted = function(self,userId)
					return self.votes[userId] ~= nil
				end,
				data = data
			}

			activePolls[data.id] = thread
			local disconnect = channel:postPoll(data,thread)
			local stop = function()
				disconnect()
				data.ended = true
				thread:update()
			end
			thread.stop = stop
			thread:update()
		end
	end

	local parse = function(player,data,channel)
		if(data.image) then
			if(not verifyImage(data.image)) then
				data.image = nil
			end
		end
		if(data.title) then
			data.title = filter(tostring(data.title):sub(1,maxLength),player)
		end
		if(data.multipleChoice and data.pollType == "MultipleChoice") then
			for key,choice in pairs(data.multipleChoice) do
				if(typeof(key) == "number") then
					if(key > 10) then
						data.multipleChoice[key] = nil
					else
						if(typeof(choice) ~= "string") then
							data.multipleChoice[key] = "Option"
						else
							data.multipleChoice[key] = filter(choice:sub(1,maxLength),player)
						end
					end
				else
					data.multipleChoice[key] = nil
				end
			end
			if(#data.multipleChoice < 1) then
				data.multipleChoice = {"Choice1","Choice2"}
			elseif(#data.multipleChoice < 2) then
				data.multipleChoice = {
					data.multipleChoice[1],
					"Choice2"
				}
			end
		elseif(data.range and data.pollType == "Number") then
			data.range = {
				min = data.range.min,
				max = data.range.max,
				step = data.range.step
			}
		else
			return
		end
		for key,value in pairs(data) do
			if(not table.find(keys,key)) then
				data[key] = nil
			end
		end
		ids += 1
		local pollId = ids
		data.id = pollId
		return create(data,player,channel)
	end
	network:newFunction("canUse",function(player)
		return permission:canUse(required,player.UserId)
			
			
		
	end)

	network:newFunction("createPoll",function(player,data,channel) --> type checking and security :l
		if(typeof(data) == "table"and permission:canUse(required,player.UserId)) then
			local speaker = speakers[player]
			if(not speaker) then
				return false,"invalid speaker"
			else
				if(not speaker.muted) then
					local chatChannel = constructors.channel:getByName(channel)
					if(chatChannel and chatChannel:canSpeakerTalk(speaker)) then
						if(data.pollType == "MultipleChoice" or data.pollType == "Number") then
							if(data.expiresIn ~= nil) then
								if(typeof(data.expiresIn) ~= "number") then
									data.expiresIn = nil
								end
							end
							if(data.pollType ~= "MultipleChoice") then
								data.multipleChoice = nil
								data.seeWhoVoted = false
								if(not typeof(data.range) == "table") then
									return false,3
								else
									local range = data.range
									if(tonumber(range.min) and tonumber(range.max) and tonumber(range.step)) then
										if(range.min > range.max) then
											range.max = range.min
										end
										if(range.step > range.max) then
											range.step = 1
										end
										range.step = math.clamp(range.step,0.5,20)
										return parse(player,data,chatChannel)
									else
										return false,4
									end
								end
							else
								data.range = nil
								return parse(player,data,chatChannel)
							end
						else
							return false,2
						end
					end
				else
					return false,"muted"
				end
			end
		else
			return false,1
		end
	end)

	local verify = function(player,id)
		local poll = activePolls[id]
		if(poll) then
			local chatChannel = poll.channel
			if(chatChannel and chatChannel:canSpeakerTalk(speakers[player])) then
				return true
			end
		end
	end

	network:newFunction("pollInteract",function(player,request,...)
		local arguments = {...}
		if(typeof(arguments[1]) == "number" and verify(player,arguments[1])) then
			if(request == "get") then
				return activePolls[arguments[1]]["data"]
			elseif(request == "vote") then
				local pollSys = activePolls[arguments[1]]
				pollSys:vote(player,arguments[2])
			elseif(request == "hasVoted") then
				return activePolls[arguments[1]]:hasVoted(player.UserId)
			elseif(request == "endPoll") then
				local pollSys = activePolls[arguments[1]]
				if(player.UserId == pollSys.owner) then
					pollSys:stop()
					
				end
			end
		end
	end)

	network:newEvent("pollUpdate")
end