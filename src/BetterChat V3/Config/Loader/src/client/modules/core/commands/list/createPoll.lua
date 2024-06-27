-- Author: @Jumpathy
-- Name: createPoll.lua
-- Description: Poll command

local players = game:GetService("Players")

local command = {}
command.name = "poll"
command.aliases = {}
command.security = "internal"

command.call = function(text,env)
	if (env.network:invoke("canUse")) then 
		env:createPoll()
	end
end

return command