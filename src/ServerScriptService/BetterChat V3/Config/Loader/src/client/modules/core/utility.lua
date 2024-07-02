-- Author: @Jumpathy
-- Name: utility.lua
-- Description: Utilitarian functions (dont know if that's even a word LMAO)

local utility = {}
local tweenService = game:GetService("TweenService")
local players = game:GetService("Players")
local style = Enum.EasingStyle.Linear

function utility:tween(...)
	local args = {...}
	if(type(args[1]) ~= "table") then
		local object,length,properties,direction,overStyle = unpack(args)
		local tween = tweenService:Create(object,TweenInfo.new(length,overStyle or style,direction or Enum.EasingDirection.Out),properties)
		tween:Play()
		return tween
	else
		local tweens = {}
		for _,t in pairs(args) do
			local object,length,properties,direction,overStyle = unpack(t)
			local tween = tweenService:Create(object,TweenInfo.new(length,overStyle or style,direction or Enum.EasingDirection.Out),properties)
			tween:Play()
			tweens[object] = tween
		end
		return tweens
	end
end

function utility.descendantOfClassAdded(holder,class,callback)
	local check = function(object)
		if(object:IsA(class)) then
			callback(object)
		end
	end
	holder.DescendantAdded:Connect(check)
	for _,descendant in pairs(holder:GetDescendants()) do
		task.spawn(check,descendant)
	end
end

function utility:clampTextLimit(box,limit)
	local conn
	local last = ""
	conn = box.Changed:Connect(function()
		if(box:GetFullName() ~= box.Name) then
			if(#box.Text > limit) then
				box.Text = last
				return
			end
			last = box.Text
		else
			conn:Disconnect()
		end
	end)
end

function utility:linkObjectSignals(object,signals)
	local conn;
	conn = object.Changed:Connect(function()
		if(object:GetFullName() == object.Name) then
			for _,sig in pairs(signals) do
				sig:Disconnect()
			end
			conn:Disconnect()
			signals = nil
		end
	end)
end

utility.childAdded = function(parent,onChild)
	parent.ChildAdded:Connect(onChild)
	for _,child in pairs(parent:GetChildren()) do
		task.spawn(onChild,child)
	end
end

utility.viewport = require(script.Parent:WaitForChild("constructors"):WaitForChild("buildViewport"))

return utility