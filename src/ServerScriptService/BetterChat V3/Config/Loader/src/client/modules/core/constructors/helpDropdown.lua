-- Author: @Jumpathy
-- Name: helpDropdown.lua
-- Description: UI dropdown controller or help menu

local dropdown = {}

local images = {
	[false] = "rbxassetid://8677555693",
	[true] = "rbxassetid://8677748645"
}

function dropdown.new(gui,environment)
	local optionContainer = gui:WaitForChild("Dropdown")
	local button = gui:WaitForChild("Cover"):WaitForChild("Drop")
	local state = false
	local layout = optionContainer.UIListLayout
	local currentSize = layout.AbsoluteContentSize
	optionContainer.Visible = true
	
	local setOpen = function()
		currentSize = layout.AbsoluteContentSize
		local key = tick()
		button.Icon.Image = images[state]
		environment.tweenSize(gui,UDim2.new(1,-10,0,((not state) and 30 or (35 + currentSize.Y))),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
		environment.tweenSize(optionContainer,UDim2.new(1,0,0,(state and currentSize.Y) or 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
	end

	local toggle = function()
		state = not state
		setOpen()
	end

	button.MouseButton1Click:Connect(toggle)
	
	layout.Changed:Connect(setOpen)
end

return dropdown