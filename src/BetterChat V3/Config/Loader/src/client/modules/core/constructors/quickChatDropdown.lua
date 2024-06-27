-- Author: @Jumpathy
-- Name: quickChatDropdown.lua
-- Description: Quick chat individual option component function

local boxScale = {}
local textService = game:GetService("TextService")
local tweenService = game:GetService("TweenService")

function boxScale.new(box,callback)
	local scale = function()
		local text = (box.Text ~= "" and box.Text or box.PlaceholderText)
		local bounds = textService:GetTextSize(text,box.TextSize,box.Font,Vector2.new(box.AbsoluteSize.X-10,math.huge))
		box.Size = UDim2.new(1,0,0,bounds.Y + 10)
		callback(0)
	end
	box:GetPropertyChangedSignal("Text"):Connect(scale)
	scale()
end

local tween = function(object,properties,length)
	local info = TweenInfo.new(length,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
	tweenService:Create(object,info,properties):Play()
end

local quickChatDropdown = {}

local images = {
	[false] = "rbxassetid://8677555693",
	[true] = "rbxassetid://8677748645";
}

local new = function()
	local dropdown = Instance.new("Frame")
	dropdown.Name = "Dropdown"
	dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dropdown.BackgroundTransparency = 1
	dropdown.BorderSizePixel = 0
	dropdown.Position = UDim2.fromScale(0, 1)
	dropdown.Size = UDim2.new(1, -10, 0, 30)
	dropdown.ZIndex = 8

	local container = Instance.new("Frame")
	container.Name = "Container"
	container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	container.BorderSizePixel = 0
	container.ClipsDescendants = true
	container.Position = UDim2.fromOffset(0, 25)
	container.Size = UDim2.fromScale(1, 0)
	container.ZIndex = 8

	local scroller = Instance.new("Frame")
	scroller.Name = "Scroller"
	scroller.AnchorPoint = Vector2.new(0.5, 0)
	scroller.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scroller.BackgroundTransparency = 1
	scroller.BorderSizePixel = 0
	scroller.Position = UDim2.new(0.5, 0, 0, 5)
	scroller.Size = UDim2.new(1, -10, 1, -5)
	scroller.ZIndex = 8

	local uIListLayout = Instance.new("UIListLayout")
	uIListLayout.Name = "UIListLayout"
	uIListLayout.Padding = UDim.new(0, 5)
	uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.Parent = scroller

	local box = Instance.new("TextBox")
	box.Name = "Box"
	box.ClearTextOnFocus = false
	box.Font = Enum.Font.GothamMedium
	box.PlaceholderText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
	box.Text = ""
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.TextSize = 14
	box.TextWrapped = true
	box.TextXAlignment = Enum.TextXAlignment.Left
	box.TextYAlignment = Enum.TextYAlignment.Top
	box.AnchorPoint = Vector2.new(0, 1)
	box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	box.BorderColor3 = Color3.fromRGB(27, 42, 53)
	box.BorderSizePixel = 0
	box.Size = UDim2.new(1, 0, 0, 56)
	box.ZIndex = 8

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 5)
	uIPadding.PaddingLeft = UDim.new(0, 5)
	uIPadding.PaddingRight = UDim.new(0, 5)
	uIPadding.PaddingTop = UDim.new(0, 5)
	uIPadding.Parent = box

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.Parent = box

	box.Parent = scroller

	local uIPadding1 = Instance.new("UIPadding")
	uIPadding1.Name = "UIPadding"
	uIPadding1.PaddingTop = UDim.new(0, 5)
	uIPadding1.Parent = scroller

	local options = Instance.new("Frame")
	options.Name = "Options"
	options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	options.Size = UDim2.new(1, -10, 0, 30)

	local uIListLayout1 = Instance.new("UIListLayout")
	uIListLayout1.Name = "UIListLayout"
	uIListLayout1.Padding = UDim.new(0, 5)
	uIListLayout1.FillDirection = Enum.FillDirection.Horizontal
	uIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout1.Parent = options

	local save = Instance.new("TextButton")
	save.Name = "Save"
	save.Font = Enum.Font.GothamMedium
	save.Text = "Save"
	save.TextColor3 = Color3.fromRGB(255, 255, 255)
	save.TextSize = 14
	save.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	save.TextXAlignment = Enum.TextXAlignment.Left
	save.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	save.BorderSizePixel = 0
	save.Size = UDim2.new(0.5, 0, 0, 30)
	save.ZIndex = 8

	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.Image = "rbxassetid://6035067857"
	icon.AnchorPoint = Vector2.new(0, 0.5)
	icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon.BackgroundTransparency = 1
	icon.Position = UDim2.new(0, -25, 0.5, 0)
	icon.Size = UDim2.fromOffset(20, 20)
	icon.ZIndex = 9
	icon.Parent = save

	local uICorner1 = Instance.new("UICorner")
	uICorner1.Name = "UICorner"
	uICorner1.Parent = save

	local uIPadding2 = Instance.new("UIPadding")
	uIPadding2.Name = "UIPadding"
	uIPadding2.PaddingLeft = UDim.new(0, 30)
	uIPadding2.Parent = save

	save.Parent = options

	local delete = Instance.new("TextButton")
	delete.Name = "Delete"
	delete.Font = Enum.Font.GothamMedium
	delete.Text = "Delete"
	delete.TextColor3 = Color3.fromRGB(255, 255, 255)
	delete.TextSize = 14
	delete.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	delete.TextXAlignment = Enum.TextXAlignment.Left
	delete.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	delete.BorderSizePixel = 0
	delete.Size = UDim2.new(0.5, 0, 0, 30)
	delete.ZIndex = 8

	local icon1 = Instance.new("ImageLabel")
	icon1.Name = "Icon"
	icon1.Image = "http://www.roblox.com/asset/?id=6022668885"
	icon1.AnchorPoint = Vector2.new(0, 0.5)
	icon1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon1.BackgroundTransparency = 1
	icon1.Position = UDim2.new(0, -25, 0.5, 0)
	icon1.Size = UDim2.fromOffset(20, 20)
	icon1.ZIndex = 9
	icon1.Parent = delete

	local uICorner2 = Instance.new("UICorner")
	uICorner2.Name = "UICorner"
	uICorner2.Parent = delete

	local uIPadding3 = Instance.new("UIPadding")
	uIPadding3.Name = "UIPadding"
	uIPadding3.PaddingLeft = UDim.new(0, 30)
	uIPadding3.Parent = delete

	delete.Parent = options

	options.Parent = scroller

	local command = Instance.new("TextLabel")
	command.Name = "Command"
	command.Font = Enum.Font.GothamMedium
	command.Text = "Send in chat using '/1'"
	command.TextColor3 = Color3.fromRGB(200, 200, 200)
	command.TextSize = 14
	command.TextXAlignment = Enum.TextXAlignment.Left
	command.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	command.BackgroundTransparency = 1
	command.Size = UDim2.new(1, 0, 0, 20)
	command.ZIndex = 8

	local uIPadding4 = Instance.new("UIPadding")
	uIPadding4.Name = "UIPadding"
	uIPadding4.PaddingLeft = UDim.new(0, 5)
	uIPadding4.Parent = command

	command.Parent = scroller

	scroller.Parent = container

	container.Parent = dropdown

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Font = Enum.Font.GothamMedium
	title.Text = "1"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 14
	title.Active = true
	title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	title.BorderColor3 = Color3.fromRGB(27, 42, 53)
	title.BorderSizePixel = 0
	title.Selectable = true
	title.Size = UDim2.new(1, 0, 0, 30)
	title.ZIndex = 8

	local uICorner3 = Instance.new("UICorner")
	uICorner3.Name = "UICorner"
	uICorner3.Parent = title

	local icon2 = Instance.new("ImageButton")
	icon2.Name = "Icon"
	icon2.Image = "rbxassetid://8677555693"
	icon2.Active = false
	icon2.AnchorPoint = Vector2.new(1, 0.5)
	icon2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon2.BackgroundTransparency = 1
	icon2.Position = UDim2.new(1, -5, 0.5, 0)
	icon2.Selectable = false
	icon2.Size = UDim2.fromOffset(30, 30)
	icon2.ZIndex = 10
	icon2.Parent = title

	title.Parent = dropdown

	return dropdown
end

function quickChatDropdown.new(text,title,callback)
	local object = new()
	local container = object:WaitForChild("Container")
	local scroller = container:WaitForChild("Scroller")
	local box = scroller:WaitForChild("Box")
	local layout = scroller:WaitForChild("UIListLayout")
	local state = false
		
	scroller.Command.Text = ("Send in chat using '/%s'"):format(title)
	object.Title.Text = title
	box.Text = text

	local scale = function(length)
		local size = (state and UDim2.new(1,0,0,layout.AbsoluteContentSize.Y + 15) or UDim2.fromScale(1,0))
		tween(container,{
			Size = size
		},length)
		tween(object,{
			Size = UDim2.new(1,-10,0,30 + math.clamp(size.Y.Offset-5,0,math.huge))
		},length)
	end

	boxScale.new(box,scale)

	local button = object:WaitForChild("Title"):WaitForChild("Icon")
	button.MouseButton1Click:Connect(function()
		state = not state
		button.Image = images[state]
		scale(0.2)
	end)

	local options = {
		scroller:WaitForChild("Options"):WaitForChild("Save"),
		scroller:WaitForChild("Options"):WaitForChild("Delete")
	}

	local api = {
		setText = function(self,text)
			box.Text = text
		end,
		getText = function()
			return box.Text
		end,
		getBox = function()
			return box
		end,
		reparent = function(self,parent)
			object.Parent = parent
		end,
	}

	for _,option in pairs(options) do
		option.MouseButton1Click:Connect(function()
			callback(option.Name,api)
		end)
	end

	return api
end

return quickChatDropdown