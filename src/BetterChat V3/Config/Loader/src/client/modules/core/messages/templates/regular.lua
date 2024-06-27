-- Author: @Jumpathy
-- Name: regular.lua
-- Description: Regular message constructor

local create = function()
	local message = Instance.new("Frame")
	message.Name = "Message"
	message.AutomaticSize = Enum.AutomaticSize.Y
	message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	message.BackgroundTransparency = 1
	message.Size = UDim2.new(1, 0, 0, 16)

	local raw = Instance.new("TextLabel")
	raw.Name = "Raw"
	raw.Font = Enum.Font.GothamMedium
	raw.RichText = true
	raw.Text = ""
	raw.TextColor3 = Color3.fromRGB(255, 255, 255)
	raw.TextSize = 15
	raw.TextStrokeTransparency = 0.9
	raw.TextWrapped = true
	raw.TextXAlignment = Enum.TextXAlignment.Left
	raw.AnchorPoint = Vector2.new(1, 0)
	raw.AutomaticSize = Enum.AutomaticSize.Y
	raw.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	raw.BackgroundTransparency = 1
	raw.Position = UDim2.fromScale(1, 0)
	raw.Size = UDim2.new(1, 0, 0, 16)
	raw.ZIndex = 2

	local user = Instance.new("TextButton")
	user.Name = "User"
	user.Font = Enum.Font.GothamMedium
	user.RichText = true
	user.TextColor3 = Color3.fromRGB(0, 0, 0)
	user.TextSize = 15
	user.TextTransparency = 1
	user.TextWrapped = true
	user.AutomaticSize = Enum.AutomaticSize.XY
	user.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	user.BackgroundTransparency = 1
	user.Size = UDim2.fromOffset(0, 16)
	user.Parent = raw

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.Parent = raw

	raw.Parent = message

	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon.BackgroundTransparency = 1
	icon.BorderSizePixel = 0
	icon.Size = UDim2.fromOffset(15, 15)
	icon.Visible = false
	icon.ZIndex = 2
	icon.Parent = message

	local mentioned = Instance.new("Frame")
	mentioned.Name = "Mentioned"
	mentioned.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	mentioned.BackgroundTransparency = 0.75
	mentioned.BorderSizePixel = 0
	mentioned.Size = UDim2.fromScale(1, 1)
	mentioned.Visible = false

	local ignore = Instance.new("UICorner")
	ignore.Name = "Ignore"
	ignore.CornerRadius = UDim.new(0, 4)
	ignore.Parent = mentioned

	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	bar.BorderSizePixel = 0
	bar.Size = UDim2.fromOffset(5, 16)

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.CornerRadius = UDim.new(0, 4)
	uICorner.Parent = bar

	bar.Parent = mentioned

	mentioned.Parent = message

	local edit = Instance.new("TextBox")
	edit.Name = "Edit"
	edit.ClearTextOnFocus = false
	edit.Font = Enum.Font.GothamMedium
	edit.Text = ""
	edit.TextColor3 = Color3.fromRGB(255, 255, 255)
	edit.TextSize = 15
	edit.TextStrokeTransparency = 0.9
	edit.TextWrapped = true
	edit.TextXAlignment = Enum.TextXAlignment.Left
	edit.Active = false
	edit.AnchorPoint = Vector2.new(1, 0)
	edit.AutomaticSize = Enum.AutomaticSize.Y
	edit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	edit.BackgroundTransparency = 1
	edit.Position = UDim2.fromScale(1, 0)
	edit.Selectable = false
	edit.Size = UDim2.new(1, 0, 0, 16)
	edit.Visible = false
	edit.Parent = message
	
	return message
end

return {new = function()
	return create()
end}