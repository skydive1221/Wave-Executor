-- Author: @Jumpathy
-- Name: system.lua
-- Description: System messages :D

return function(environment,queue)
	local scroller = environment.mainUi.scroller
	local templates = script.Parent:WaitForChild("templates")
	local regular = require(templates:WaitForChild("regular"))
	local rich = environment.richText
	
	return function(speaker,message,order)
		environment:checkScrollerPos()
		local object = regular.new(environment)
		local message = rich:mark(rich:escape(message))
		object.Raw.Text = speaker ~= "" and ("%s %s"):format(rich:colorize(speaker .. ":",Color3.fromRGB(200,200,200)),message) or message
		object.Parent = scroller
		object.LayoutOrder = order and order or (queue[1] and queue[1].LayoutOrder or 0)
		return object
	end
end