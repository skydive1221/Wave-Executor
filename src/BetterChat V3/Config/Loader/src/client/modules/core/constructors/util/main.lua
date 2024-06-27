-- Author: @Jumpathy
-- Name: utility.lua
-- Description: Utility functions for building viewport headshots

local zlib = require(script.Parent:WaitForChild("zlib"))
local httpService = game:GetService("HttpService")
local utility = {}

function utility:createViewport(size)
	local viewport = Instance.new("ViewportFrame")
	viewport.Size = UDim2.fromOffset(size,size)
	viewport.BackgroundTransparency = 1
	viewport.BorderSizePixel = 0
	viewport.BackgroundColor3 = Color3.fromRGB(80,80,80)
	local world = Instance.new("WorldModel")
	world.Parent = viewport
	local camera = Instance.new("Camera")
	camera.Parent = world
	camera.FieldOfView = 50
	viewport.CurrentCamera = camera
	return viewport,camera,world
end

function utility:create(class,properties)
	local created = Instance.new(class)
	for property,value in pairs(properties) do
		created[property] = value
	end
	return created
end

function utility:compress(text)
	return zlib.Zlib.Compress(text,{
		strategy = "dynamic",
		level = 9
	})
end

function utility:getDescriptionId(description)
	local toAlphabetize = {}
	for property,value in pairs(description) do
		table.insert(toAlphabetize,property)
	end
	table.sort(toAlphabetize)
	local id = {}
	for _,name in pairs(toAlphabetize) do
		table.insert(id,name..":"..tostring(description[name]))
	end
	return utility:compress(table.concat(id,","))
end

function utility:guid()
	return httpService:GenerateGUID():sub(2,37):gsub("-","")
end

function utility:createDummy()
	local dummy = Instance.new("Model")
	dummy.Name = "Dummy"
	dummy.WorldPivot = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)

	local head = Instance.new("Part")
	head.Name = "Head"
	head.BrickColor = BrickColor.new(0.898, 0.894, 0.875)
	head.CFrame = CFrame.new(0, 2, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	head.Color = Color3.fromRGB(229, 228, 223)
	head.Orientation = Vector3.new(0, 180, 0)
	head.Position = Vector3.new(0, 2, 0)
	head.Rotation = Vector3.new(-180, 0, -180)
	head.Size = Vector3.new(2, 1, 1)
	head.TopSurface = Enum.SurfaceType.Smooth

	local mesh = Instance.new("SpecialMesh")
	mesh.Name = "Mesh"
	mesh.Scale = Vector3.new(1.2, 1.2, 1.2)
	mesh.Parent = head

	local face = Instance.new("Decal")
	face.Name = "Face"
	face.Parent = head

	head.Parent = dummy

	local torso = Instance.new("Part")
	torso.Name = "Torso"
	torso.BrickColor = BrickColor.new(0.898, 0.894, 0.875)
	torso.CFrame = CFrame.new(0, 0.5, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	torso.Color = Color3.fromRGB(229, 228, 223)
	torso.LeftSurface = Enum.SurfaceType.Weld
	torso.Orientation = Vector3.new(0, 180, 0)
	torso.Position = Vector3.new(0, 0.5, 0)
	torso.RightSurface = Enum.SurfaceType.Weld
	torso.Rotation = Vector3.new(-180, 0, -180)
	torso.Size = Vector3.new(2, 2, 1)

	local right_Shoulder = Instance.new("Motor6D")
	right_Shoulder.Name = "Right Shoulder"
	right_Shoulder.DesiredAngle = -0.038
	right_Shoulder.MaxVelocity = 0.15
	right_Shoulder.C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	right_Shoulder.C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	right_Shoulder.Parent = torso

	local left_Shoulder = Instance.new("Motor6D")
	left_Shoulder.Name = "Left Shoulder"
	left_Shoulder.DesiredAngle = -0.038
	left_Shoulder.MaxVelocity = 0.15
	left_Shoulder.C0 = CFrame.new(-1, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	left_Shoulder.C1 = CFrame.new(0.5, 0.5, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	left_Shoulder.Parent = torso

	local right_Hip = Instance.new("Motor6D")
	right_Hip.Name = "Right Hip"
	right_Hip.DesiredAngle = 0.038
	right_Hip.MaxVelocity = 0.1
	right_Hip.C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	right_Hip.C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
	right_Hip.Parent = torso

	local left_Hip = Instance.new("Motor6D")
	left_Hip.Name = "Left Hip"
	left_Hip.DesiredAngle = 0.038
	left_Hip.MaxVelocity = 0.1
	left_Hip.C0 = CFrame.new(-1, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	left_Hip.C1 = CFrame.new(-0.5, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
	left_Hip.Parent = torso

	local neck = Instance.new("Motor6D")
	neck.Name = "Neck"
	neck.C1 = CFrame.new(0, 1.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	neck.Parent = torso

	torso.Parent = dummy

	local left_Arm = Instance.new("Part")
	left_Arm.Name = "Left Arm"
	left_Arm.BottomSurface = Enum.SurfaceType.Smooth
	left_Arm.BrickColor = BrickColor.new(0.898, 0.894, 0.875)
	left_Arm.CFrame = CFrame.new(1.5, 0.5, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	left_Arm.CanCollide = false
	left_Arm.Color = Color3.fromRGB(229, 228, 223)
	left_Arm.Orientation = Vector3.new(0, 180, 0)
	left_Arm.Position = Vector3.new(1.5, 0.5, 0)
	left_Arm.Rotation = Vector3.new(-180, 0, -180)
	left_Arm.Size = Vector3.new(1, 2, 1)
	left_Arm.Parent = dummy

	local right_Arm = Instance.new("Part")
	right_Arm.Name = "Right Arm"
	right_Arm.BottomSurface = Enum.SurfaceType.Smooth
	right_Arm.BrickColor = BrickColor.new(0.898, 0.894, 0.875)
	right_Arm.CFrame = CFrame.new(-1.5, 0.5, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	right_Arm.CanCollide = false
	right_Arm.Color = Color3.fromRGB(229, 228, 223)
	right_Arm.Orientation = Vector3.new(0, 180, 0)
	right_Arm.Position = Vector3.new(-1.5, 0.5, 0)
	right_Arm.Rotation = Vector3.new(-180, 0, -180)
	right_Arm.Size = Vector3.new(1, 2, 1)
	right_Arm.Parent = dummy

	local left_Leg = Instance.new("Part")
	left_Leg.Name = "Left Leg"
	left_Leg.BottomSurface = Enum.SurfaceType.Smooth
	left_Leg.BrickColor = BrickColor.new(0.898, 0.894, 0.875)
	left_Leg.CFrame = CFrame.new(0.5, -1.5, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	left_Leg.CanCollide = false
	left_Leg.Color = Color3.fromRGB(229, 228, 223)
	left_Leg.Orientation = Vector3.new(0, 180, 0)
	left_Leg.Position = Vector3.new(0.5, -1.5, 0)
	left_Leg.Rotation = Vector3.new(-180, 0, -180)
	left_Leg.Size = Vector3.new(1, 2, 1)
	left_Leg.Parent = dummy

	local right_Leg = Instance.new("Part")
	right_Leg.Name = "Right Leg"
	right_Leg.BottomSurface = Enum.SurfaceType.Smooth
	right_Leg.BrickColor = BrickColor.new(0.898, 0.894, 0.875)
	right_Leg.CFrame = CFrame.new(-0.5, -1.5, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
	right_Leg.CanCollide = false
	right_Leg.Color = Color3.fromRGB(229, 228, 223)
	right_Leg.Orientation = Vector3.new(0, 180, 0)
	right_Leg.Position = Vector3.new(-0.5, -1.5, 0)
	right_Leg.Rotation = Vector3.new(-180, 0, -180)
	right_Leg.Size = Vector3.new(1, 2, 1)
	right_Leg.Parent = dummy

	local humanoid = Instance.new("Humanoid")
	humanoid.Name = "Humanoid"
	humanoid.NameOcclusion = Enum.NameOcclusion.NoOcclusion
	humanoid.Parent = dummy

	return dummy
end

return utility