-- Author: @Jumpathy
-- Name: unmute.lua
-- Description: Ability to unmute users

local players = game:GetService("Players")

local command = {}
command.name = "unmute"
command.aliases = {"unm"}
command.security = "internal"

command.call = function(text,env)
	local user = text:sub(string.find(text," ") + 1,#text)
	if(user:sub(#user,#user) == " ") then
		user = user:sub(1,#user-1)
	end
	local player = players:FindFirstChild(user)
	if(player) then
		env:unmute(player)
	end
end

return command