-- Author: @Jumpathy
-- Name: filter.lua
-- Description: Chat filtering

return function(config)
	-- WARNING: Don't edit this unless you know what you're doing! A compromised chat filter can lead to your game being deleted.
	
	local filter = {}
	local chatService = game:GetService("Chat")
	local textService = game:GetService("TextService")
	local runService = game:GetService("RunService")
	local failedCharacter = config.Messages.FilterProcessingCharacter

	local handleFilterError = function(result)
		warn("[Better chat]: Internal error whilst filtering chat",result)
	end

	local psuedoFrom = function(message)
		return {
			GetChatForUserAsync = function()
				return message
			end
		}
	end

	function filter.new(message,player,isBroadcast)
		if(not isBroadcast) then
			if(runService:IsStudio()) then
				task.wait(0.1) --> simulate latency
			end
			if(player ~= nil) then
				local success,result = pcall(function()
					return textService:FilterStringAsync(message,player.UserId)
				end)
				if(success) then
					return true,result
				elseif(not success) then
					handleFilterError(result)
					return false,psuedoFrom(string.rep(failedCharacter,#message))
				end
			elseif(not player) then
				return true,psuedoFrom(message)
			end
		else
			local success,response = pcall(function()
				return chatService:FilterStringForBroadcast(message,player)
			end)
			if(success) then
				return true,response
			else
				handleFilterError(response)
				return false,string.rep(failedCharacter,#message)
			end
		end
	end

	return filter
end