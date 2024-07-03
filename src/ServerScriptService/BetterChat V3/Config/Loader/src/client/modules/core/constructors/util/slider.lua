-- Author: @Jumpathy
-- Name: slider.lua
-- Description: Color wheel slider controller (gross code)

local userInput = game:GetService("UserInputService");
local runService = game:GetService("RunService");
local guiService = game:GetService("GuiService");
local inset = guiService:GetGuiInset();
local step = 20;

local getGradientFromColor = function(color)
	local sequence = {};
	local count = step;
	local hasHadZero = {R = false,G = false,B = false};
	
	local gv = function(color,idx,iter)
		local depth = 255 / count;
		local col = math.floor(color[idx] * 255);
		local num = math.clamp(col - (depth * iter),0,255);
		if(num < 1) then
			hasHadZero[idx] = true;
		end
		return num;
	end
	
	local i = -1;
	for c = 1,count do
		i += 1;
		table.insert(sequence,(Color3.fromRGB(unpack({
			gv(color,"R",i),
			gv(color,"G",i);
			gv(color,"B",i)
		}))));
		local cancel = true;
		for k,v in pairs(hasHadZero) do
			if(not v) then
				cancel = false;
				break;
			end
		end
		if(cancel) then
			break;
		end
	end
	
	if(#sequence == 1) then
		table.insert(sequence,sequence[1]);
	end
	
	for i = 1,#sequence do
		sequence[i] = ColorSequenceKeypoint.new((i == 1 and 0 or (i/#sequence)),sequence[i]);
	end
	
	return ColorSequence.new(sequence);
end

local getValueAtStep = function(sequence,max,current)
	local timeToEval = current/max;
	if(timeToEval == 0) then 
		return sequence.Keypoints[1].Value;
	elseif(timeToEval == 1) then 
		return sequence.Keypoints[#sequence.Keypoints].Value;
	end
	for i = 1, #sequence.Keypoints - 1 do
		local curentPoint = sequence.Keypoints[i];
		local nextPoint = sequence.Keypoints[i + 1];
		if(timeToEval >= curentPoint.Time and timeToEval < nextPoint.Time) then
			local alpha = (timeToEval - curentPoint.Time) / (nextPoint.Time - curentPoint.Time);
			return Color3.new(
				(nextPoint.Value.R - curentPoint.Value.R) * alpha + curentPoint.Value.R,
				(nextPoint.Value.G - curentPoint.Value.G) * alpha + curentPoint.Value.G,
				(nextPoint.Value.B - curentPoint.Value.B) * alpha + curentPoint.Value.B
			)
		end
	end
end

local validInputs = {
	[Enum.UserInputType.Touch] = true,
	[Enum.UserInputType.MouseButton1] = true
}

for i = 1,8 do 
	validInputs[Enum.UserInputType["Gamepad" .. i]] = true;
end

local constructVerticalSlider = function(object,max,handle)
	local drag = object:WaitForChild("Drag");
	local dragging = false;
	
	local getMousePos = function()
		local base = userInput:GetMouseLocation() - inset;
		return base;
	end
	
	drag.InputBegan:Connect(function(input)
		if(validInputs[input.UserInputType] and (not dragging)) then
			dragging = true;
			local endedSignal;
			endedSignal = input.Changed:Connect(function()
				if(input.UserInputState == Enum.UserInputState.End) then
					dragging = false;
					endedSignal:Disconnect();
				end
			end)
		end
	end)

	runService.RenderStepped:Connect(function()
		if(dragging) then
			local mousePos = getMousePos();
			if(mousePos) then
			local desiredAbsolutePosition = Vector2.new(drag.AbsolutePosition.X,(mousePos.Y));
			local relativePosition = desiredAbsolutePosition - drag.Parent.AbsolutePosition;
			local percentage = math.clamp((relativePosition.Y / object.AbsoluteSize.Y),0,1);
			drag.Position = UDim2.fromScale(0,math.clamp((math.clamp(relativePosition.Y,0,object.AbsoluteSize.Y)/object.AbsoluteSize.Y),drag.AbsoluteSize.Y/(object.AbsoluteSize.Y),1));
				handle(percentage * max);
			end
		end
	end)
end

return function(slider,callback)
	local gradient = slider:WaitForChild("Gradient");
	local last = 0;

	local on = function(number)
		local value = getValueAtStep(gradient.Color,step,number);
		callback(value);
	end

	constructVerticalSlider(slider,step,function(number)
		last = number;
		on(last);
	end);

	gradient.Changed:Connect(function()
		on(last);
	end)

	return setmetatable({},{
		__newindex = function(t,k,v)
			if(k == "Color") then
				gradient.Color = getGradientFromColor(v);
			end
		end
	});
end