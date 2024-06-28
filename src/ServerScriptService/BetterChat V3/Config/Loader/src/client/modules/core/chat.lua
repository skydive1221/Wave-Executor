-- Author: @Jumpathy
-- Name: chat.lua
-- Description: Manage chat component modules

local container = script.Parent:WaitForChild("elements")
local load = function(name,...)
	return require(container:WaitForChild(name))(...)
end

local parse = function(array)
	local returnValue = {}
	for _,module in pairs(array) do
		for key,value in pairs(module) do
			returnValue[key] = value
		end
	end
	return returnValue
end

return function(...)
	return parse({
		{chatWindow = load("chatWindow",...)},
		{chatbar = load("chatbar",...)}
	})
end