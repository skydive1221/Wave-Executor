-- Author: @Jumpathy
-- Name: rateLimit.lua
-- Description: Rate limiting for sending chat messages
-- Credit: @Xsitsu (base code)

return function(config)
	local rateLimit = {
		cooldowns = {}
	}

	local numberMessagesAllowed = config.Messages.Cooldown.NumberMessageAllowed
	local expireTimePeriod = config.Messages.Cooldown.ExpireTimePeriod
	
	function rateLimit:unlink(userId)
		rateLimit.cooldowns[userId] = nil
	end
	
	function rateLimit:createCooldown(userId)
		rateLimit.cooldowns[userId] = {}
		local flood_detection = rateLimit.cooldowns[userId]
		local return_functions = {}

		local purge_expired = function()
			local currentTick = tick()
			while(#flood_detection > 0 and flood_detection[1] < currentTick) do
				table.remove(flood_detection,1)
			end
		end

		function return_functions:log()
			purge_expired()
			if(#flood_detection < numberMessagesAllowed) then
				table.insert(flood_detection,tick() + expireTimePeriod)
			end
		end

		function return_functions:canSend()
			purge_expired()
			if(#flood_detection < numberMessagesAllowed) then
				return true
			else
				return false,math.ceil(flood_detection[1] - tick())
			end
		end
		
		function return_functions:getCooldown()
			return math.floor(({return_functions:canSend()})[2])
		end

		return return_functions
	end

	return rateLimit
end