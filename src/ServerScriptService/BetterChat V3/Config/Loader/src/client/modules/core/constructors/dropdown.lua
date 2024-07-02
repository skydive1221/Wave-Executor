-- Author: @Jumpathy
-- Name: dropdown.lua
-- Description: UI dropdown controller

local dropdown = {}

local newOption = function(text)
	local option = Instance.new("TextButton")
	local padding = Instance.new("UIPadding")

	option.Name = "Option"
	option.BackgroundColor3 = Color3.fromRGB(30,30,30)
	option.BackgroundTransparency = 1
	option.BorderColor3 = Color3.fromRGB(27,42,53)
	option.BorderSizePixel = 0
	option.Size = UDim2.new(1,-10,0,25)
	option.ZIndex = 15
	option.Font = Enum.Font.GothamMedium
	option.Text = text
	option.TextColor3 = Color3.fromRGB(255,255,255)
	option.TextSize = 14
	option.TextXAlignment = Enum.TextXAlignment.Left

	padding.Parent = option
	padding.PaddingLeft = UDim.new(0,5)
	return option
end

local images = {
	[false] = "rbxassetid://8677555693",
	[true] = "rbxassetid://8677748645"
}

function dropdown.new(gui,options,callback,main,environment)
	main = main or function() end
	local optionContainer = gui:WaitForChild("Dropdown"):WaitForChild("Options")
	local top = gui:WaitForChild("TopContainer")
	local button = gui:WaitForChild("Title"):WaitForChild("Drop")
	local selected = gui:WaitForChild("Title"):WaitForChild("Selected")
	local state,last = false,nil

	local setOpen = function()
		local key = tick()
		last = key
		button.Icon.Image = images[state]
		local set = function()
			top.Flat.Visible = state
			top.Background.ClipsDescendants = state
		end
		if(state) then
			set()
		end
		environment.tweenSize(gui,UDim2.new(1,-10,0,(30 + (state and (25 * #options + (#options >= 2 and ((#options - 1)*3) or 0)) or 0))),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true,function()
			if(last == key and (not state)) then
				set()
			end
		end)
	end

	local toggle = function()
		state = not state
		setOpen()
	end

	button.MouseButton1Click:Connect(toggle)
	for _,option in pairs(options) do
		local button = newOption(option)
		button.Parent = optionContainer
		button.MouseButton1Click:Connect(function()
			selected.Text = option
			toggle()
			callback(option)
		end)
		main(button)
	end

	selected.Text = options[1]
	setOpen()
	return {
		set = function(self,option)
			if(table.find(options,option)) then
				selected.Text = option
				callback(option)
			end
		end,
	}
end

return dropdown