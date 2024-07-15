-- Author: @Jumpathy
-- Name: filter.lua
-- Description: Chat filtering

return function(config,richText,msg)
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
	
	local wrap = function(filterObj,recombineFunc)
		local obj = {}
		
		function obj:GetChatForUserAsync(...)
			return recombineFunc(richText:escape(filterObj:GetChatForUserAsync(...)))
		end
		
		return obj
	end
	
	function filter.new(message,player,isBroadcast,isMarkdown)
		local stripped,recombine,emojis
		if isMarkdown then
			local marked = richText:markdown(richText:escape(message))
			stripped,recombine,emojis = richText:processForFilter(marked,player)
			if recombine then
				message = stripped
			end
		end
		if(not isBroadcast) then
			if(runService:IsStudio()) then
				task.wait(0.1) --> simulate latency
			end
			if(player ~= nil) then
				local success,result = pcall(function()
					local handle = msg.preprocess(richText:unescape(message))
					return textService:FilterStringAsync(handle,player.UserId)
				end)
				if(success) then
					if recombine then
						return true,wrap(result,recombine),emojis
					else
						return true,result,emojis
					end
				elseif(not success) then
					handleFilterError(result)
					return false,psuedoFrom(string.rep(failedCharacter,#message))
				end
			elseif(not player) then
				return true,psuedoFrom(message),emojis
			end
		else
			local success,response = pcall(function()
				return chatService:FilterStringForBroadcast(message,player)
			end)
			if(success) then
				return true,response,emojis
			else
				handleFilterError(response)
				return false,string.rep(failedCharacter,#message)
			end
		end
	end

	return filter
end