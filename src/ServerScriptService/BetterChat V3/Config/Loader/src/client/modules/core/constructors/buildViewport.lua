-- Author: @Jumpathy
-- Name: buildViewport.lua
-- Description: Build headshot viewport frames for roleplay effects n stuff

local utility = require(script.Parent:WaitForChild("util"):WaitForChild("main"))
local storage = game:GetService("ReplicatedStorage"):WaitForChild("betterchat_shared"):WaitForChild("loading")
local buildViewport = {}
local cached = {}

local constructFromGround = function(description,id)
	local event = Instance.new("BindableEvent")
	cached[id] = event
	local dummy,toApply = utility:createDummy(),utility:create("HumanoidDescription",description)
	dummy.Parent = storage
	dummy.Humanoid:ApplyDescription(toApply)
	dummy.Name = utility:guid()
	local changed
	changed = dummy.Changed:Connect(function()
		if(dummy:GetFullName() == dummy.Name) then
			cached[id] = nil
		end
	end)
	cached[id] = dummy
	event:Fire()
	event:Destroy()
	return dummy
end

function buildViewport.new(description,size)
	local id = utility:getDescriptionId(description)
	local constructed
	if(cached[id]) then
		if(cached[id]:IsA("BindableEvent")) then
			cached[id].Event:Wait()
		end
		constructed = cached[id]
	else
		constructFromGround(description,id)
		constructed = cached[id]
	end
	local frame,camera,worldModel = utility:createViewport(size)
	local dummy = constructed:Clone()
	dummy.Parent = worldModel
	camera.CFrame = CFrame.lookAt(
		dummy.Head.Position + (dummy.Head.CFrame.LookVector * (3)),
		dummy.Head.Position
	)
	return frame
end

return buildViewport