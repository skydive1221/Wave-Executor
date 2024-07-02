-- Author: @Jumpathy
-- Name: toggle.lua
-- Description: Toggle ui controller

local toggle = {}
local tweenService = game:GetService("TweenService")
local length,style = 0.16,Enum.EasingStyle.Linear
local tweenInfo = TweenInfo.new(length,style)
local offset = 3

function toggle.new(object,default,callback,environment)
	local container = object:WaitForChild("Toggle")
	local zone = container:WaitForChild("Zone")
	local switch = container:WaitForChild("Rounded")
	local state = default

	local handle = function(doCall)
		tweenService:Create(container,tweenInfo,{["BackgroundColor3"] = (state and Color3.fromRGB(72,175,240) or Color3.fromRGB(171,171,171))}):Play()
		environment.tweenPosition(switch,UDim2.new((state and 1 or 0),(state and -offset or (switch.AbsoluteSize.X + offset)),0.5,0),Enum.EasingDirection.InOut,style,length,true)
		if(doCall) then
			callback(state)
		end
	end

	zone.MouseButton1Click:Connect(function()
		state = not state
		handle(true)
	end)

	handle()
	return {
		set = function(self,new)
			self.value = new
			state = new
			handle(true)
		end
	}
end

return toggle