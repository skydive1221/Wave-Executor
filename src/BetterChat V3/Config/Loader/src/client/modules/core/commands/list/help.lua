-- Author: @Jumpathy
-- Name: help.lua
-- Description: /help command

local starterGui = game:GetService("StarterGui")
local keys = {
	"GameChat_ChatCommandsTeller_Desc",
	"GameChat_ChatCommandsTeller_MeCommand",
	"GameChat_ChatCommandsTeller_MuteCommand",
	"GameChat_ChatCommandsTeller_SwitchChannelCommand",
	"GameChat_ChatCommandsTeller_TeamCommand",
	"GameChat_ChatCommandsTeller_UnMuteCommand",
	"GameChat_ChatCommandsTeller_WhisperCommand"
}

local command = {}
command.name = "help"
command.aliases = {}
command.security = "internal"
command.call = function(text,environment)
	local msg = ""
	for _,key in pairs(keys) do
		msg = msg .. environment.localization:localize(key) .. "\n"
	end
	environment:sendSystemMessage(msg:sub(1,#msg-1))
end

return command