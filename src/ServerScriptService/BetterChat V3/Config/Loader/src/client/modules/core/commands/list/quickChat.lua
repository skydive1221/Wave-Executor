-- Author: @Jumpathy
-- Name: quickChat.lua
-- Description: Quick chat commands

local starterGui = game:GetService("StarterGui")
local command = {}
command.name = "1"
command.security = "internal"
command.aliases = {}

for i = 1,19 do
	table.insert(command.aliases,tostring(i + 1))
end

command.call = function(text,environment)
	if(environment.config.Messages.QuickChat) then
		local number = tonumber(text:sub(2,3))
		local slot = environment:getQuickChatSlot(number)
		if(slot ~= "") then
			environment:sendMessageInternally(slot)
		end
	end
end

return command