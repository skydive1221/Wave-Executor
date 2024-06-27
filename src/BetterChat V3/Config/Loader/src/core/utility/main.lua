-- Author: @Jumpathy
-- Name: utility.lua
-- Description: Utility functions
-- Credit: @Xsitsu (base code for some functions)

local deps = script.Parent:WaitForChild("dependencies")

return function(config)
	local extract = require(deps:WaitForChild("extract"))
	local httpService = game:GetService("HttpService")
	
	local maxMessageLength = config.Messages.MaximumLength
	local maxBytes = 6
	local utility = {}

	local nameColors = config.User.NameColors
	local getNameValue = function(name)
		local value = 0
		local nameLength = string.len(name)
		for i = 1,nameLength do
			local charValue = string.byte(name:sub(i,i))
			local reverseIndex = nameLength - i + 1
			if(nameLength % 2 == 1) then
				reverseIndex -= 1
			end
			if(reverseIndex % 4 >= 2) then
				charValue = -charValue
			end
			value += charValue
		end
		return value
	end

	function utility:getNameColor(name)
		return nameColors[((getNameValue(name)) % #nameColors) + 1]
	end

	function utility:getSendability(message)
		if((not(string.len(message) > maxMessageLength * maxBytes))) then
			if((not(utf8.len(message) == nil))) then
				if(not(utf8.len(utf8.nfcnormalize(message)) > maxMessageLength)) then
					return(true)
				end
			end
		end
		return(false)
	end

	function utility:fixWhitespace(message)
		local disallowedWhitespace = config.Messages.DisallowedWhitespace
		for _,character in pairs(disallowedWhitespace) do
			if(character == "\t") then
				message = message:gsub(character,string.char(32))
			else
				message = message:gsub(character,"")
			end
		end
		message = message:gsub("\n","")
		message = message:gsub("[ ]+"," ")
		if(message:sub(1,1) == " ") then
			local endAt = 0
			for i = 1,#message do
				endAt = i
				if(message:sub(i,i) ~= " ") then
					break
				end
			end
			message = message:sub(endAt,#message)
		end
		return message
	end
	
	function utility:constructViewportDescription(character)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if(humanoid) then
			return extract(humanoid:GetAppliedDescription())
		end
	end
	
	function utility:newGuid()
		return httpService:GenerateGUID(false):gsub("-","")
	end
	
	function utility:verifyChatInstalled(player)
		local source = deps:WaitForChild("chatInstaller"):Clone()
		local house = Instance.new("ScreenGui")
		house.Name = "betterChatInstaller"
		house.ResetOnSpawn = false
		source.Parent = house
		house.Parent = player.PlayerGui
	end
	
	return utility
end