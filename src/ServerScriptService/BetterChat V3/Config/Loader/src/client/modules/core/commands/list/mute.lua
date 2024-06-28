-- Author: @Jumpathy
-- Name: mute.lua
-- Description: Ability to mute users

local players = game:GetService("Players")

local command = {}
command.name = "mute"
command.aliases = {"m"}
command.security = "internal"

command.call = function(text,env)
	local user = text:sub(string.find(text," ")+1,#text)
	if(user:sub(#user,#user) == " ") then
		user = user:sub(1,#user-1)
	end
	local player = players:FindFirstChild(user)
	if(player) then
		env:mute(player)
	end
end

return command