-- Author: @Jumpathy
-- Name: processor.lua
-- Description: Command processor

local commands = {}
local onCommandLoaded = function(command)
	local module = require(command)
	commands[module.name] = module
end
script.Parent:WaitForChild("list").ChildAdded:Connect(onCommandLoaded)
for _,child in pairs(script.Parent.list:GetChildren()) do
	task.spawn(onCommandLoaded,child)
end

return function(environment)
	return {
		parse = function(self,text)
			if(text:sub(1,1) == "/") then
				local commandName = text:split(string.char(32))[1]:gsub("/","")
				for name,data in pairs(commands) do
					if(name == commandName or (table.find(data.aliases,commandName))) then
						local args = {}
						if(data.security == "internal") then
							table.insert(args,environment)
						end
						task.spawn(data.call,text,unpack(args))
						return true
					end
				end
			end
		end,
	}
end