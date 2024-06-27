-- Author: @Jumpathy
-- Name: poll.lua
-- Description: Create ui poll from data

local classes = script.Parent:WaitForChild("templates"):WaitForChild("pollClasses")

local constructors = {
	Number = require(classes:WaitForChild("range")),
	MultipleChoice = require(classes:WaitForChild("multipleChoice"))
}

local cache = {}
local closed =  {}

return function(environment)
	return function(data)
		if(not closed[data.id]) then
			local hasVoted = environment.network:invoke("pollInteract","hasVoted",data.id)
			local scroller = environment.mainUi.scroller
			local object = cache[data.id]
			local callback = function(response)
				environment.network:invoke("pollInteract","vote",data.id,response)
			end
			local close = function()
				closed[data.id] = true
			end
			local stopPoll = function()
				environment.network:invoke("pollInteract","endPoll",data.id)
			end
			if(object) then
				if(object.actual:GetFullName() == object.actual.Name) then
					object = constructors[data.pollType](data,callback,close,stopPoll)
				end
			else
				object = constructors[data.pollType](data,callback,close,stopPoll)
			end
			if(object and data.ended) then
				object.actual:Destroy()
				--closed[data.id] = true
				return
			end
			if(hasVoted) then
				object.onVoted(data)
			end
			cache[data.id] = object
			object.actual.Parent = scroller
			object.actual.LayoutOrder = data.relativeId + 1
		end
	end
end