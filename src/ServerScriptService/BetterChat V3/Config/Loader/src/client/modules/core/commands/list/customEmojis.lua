-- Author: @Jumpathy
-- Name: customEmojis.lua
-- Description: Custom emojis command

local command = {}
command.name = "emojis"
command.aliases = {"customemojis","list"}
command.security = "internal"
command.call = function(text,environment)
	local config = environment.config
	if config.Messages.CustomEmojis and config.Messages.CustomEmojis.Enabled then
		local msg = "Available custom emojis:\n"
		for emojiName,_ in pairs(environment.network:invoke("getAllowedEmojis")) do
			msg = msg .. `:{emojiName}:\n`
		end
		environment:sendSystemMessage(msg:sub(1,#msg-1))
	end
end

return command