-- Author: @Jumpathy
-- Name: slider.lua
-- Description: Slider gui controller

local slider = {}
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")

function slider.new(main,min,max,default,on)
	local object = main:WaitForChild("Center"):WaitForChild("Actual")
	local box = object:WaitForChild("Amount")
	local bar = object:WaitForChild("Bar")
	local button = bar:WaitForChild("Button")
	local progress = bar:WaitForChild("Progress")
	local holding,lastText = false,nil

	button.InputBegan:Connect(function(input)
		if((input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and (not holding)) then
			local ended
			holding = true
			ended = input.Changed:Connect(function()
				if(input.UserInputState == Enum.UserInputState.End) then
					ended:Disconnect()
					holding = false
				end
			end)
		end
	end)

	local handlePositioning = function(percentage)
		local xMin = ((button.AbsoluteSize.X / 2)/bar.AbsoluteSize.X)
		local xMax = ((bar.AbsoluteSize.X - (button.AbsoluteSize.X / 2)) / bar.AbsoluteSize.X)
		local positionPercentage = math.clamp(percentage,xMin,xMax)
		button.Position = UDim2.fromScale(positionPercentage,0.5)
		progress.Size = UDim2.fromScale(positionPercentage,1)
	end
	
	local handle = function(num)
		on(math.clamp(num,min,max))
	end
	
	local getNumberFromPercentage = function(percentage)
		return math.clamp((min + ((max - min) * percentage)),min,max)
	end
	
	local rescale = function()
		local newNumber = tonumber(box.Text) or 0
		local percentage = (newNumber - min) / (max - min)
		handlePositioning(percentage)
		local rawNumber = getNumberFromPercentage(percentage)
		handle(rawNumber)
		lastText = tostring(rawNumber)
		box.Text = tonumber(rawNumber)
	end

	runService.Heartbeat:Connect(function()
		if(holding) then
			local mouseLocation = userInput:GetMouseLocation()
			local relativePosition = mouseLocation - object.AbsolutePosition
			local percentage = math.clamp(relativePosition.X / bar.AbsoluteSize.X,0,1)
			local rawNumber = getNumberFromPercentage(percentage)
			box.Text = tostring(math.floor(rawNumber))
			handlePositioning(percentage)
			handle(rawNumber)
		end
	end)
	
	box.FocusLost:Connect(rescale)
	box.Changed:Connect(function()
		if(not holding and (box.Text ~= lastText) and (box.Text ~= "")) then
			if(not box:IsFocused()) then
				rescale()
			end
		end
	end)

	box.Text = tostring(default)
	return {
		set = function(self,new)
			box.Text = tostring(math.floor(new))
			rescale()
		end,
	}
end

return slider