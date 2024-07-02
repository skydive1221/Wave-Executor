-- Author: @Jumpathy
-- Name: reply.lua
-- Description: Reply constructor
local collectionService = game:GetService("CollectionService")

local bottom = function(environment)
	local bottom = Instance.new("Frame")
	bottom.Name = "Bottom"
	bottom.AutomaticSize = Enum.AutomaticSize.Y
	bottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bottom.BackgroundTransparency = 1
	bottom.ClipsDescendants = true
	bottom.LayoutOrder = 1
	bottom.Size = UDim2.fromScale(1, 0)

	local replyArea = Instance.new("Frame")
	replyArea.Name = "ReplyArea"
	replyArea.AutomaticSize = Enum.AutomaticSize.Y
	replyArea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	replyArea.BackgroundTransparency = 1
	replyArea.Position = UDim2.fromOffset(30, 0)
	replyArea.Size = UDim2.new(1, -25, 0, 15)

	local reply = Instance.new("TextLabel")
	reply.Name = "Reply"
	reply.Font = environment.config.UI.Fonts.TextFont
	reply.RichText = true
	reply.Text = ""
	reply.TextColor3 = Color3.fromRGB(255, 255, 255)
	reply.TextSize = 13
	reply.TextStrokeTransparency = 0.9
	reply.TextWrapped = true
	reply.TextXAlignment = Enum.TextXAlignment.Left
	reply.TextYAlignment = Enum.TextYAlignment.Bottom
	reply.AnchorPoint = Vector2.new(1, 0)
	reply.AutomaticSize = Enum.AutomaticSize.Y
	reply.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	reply.BackgroundTransparency = 1
	reply.Position = UDim2.fromScale(1, 0)
	reply.Size = UDim2.new(1, 0, 0, 16)
	reply.ZIndex = 2
	collectionService:AddTag(reply,"TextFont")
	
	local user = Instance.new("TextButton")
	user.Name = "User"
	user.Font = environment.config.UI.Fonts.TextFont
	user.RichText = true
	user.TextColor3 = Color3.fromRGB(0, 0, 0)
	user.TextSize = 15
	user.TextTransparency = 1
	user.TextWrapped = true
	user.AutomaticSize = Enum.AutomaticSize.XY
	user.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	user.BackgroundTransparency = 1
	user.Size = UDim2.fromOffset(0, 16)
	user.Parent = reply
	collectionService:AddTag(user,"TextFont")

	local mentioned = Instance.new("Frame")
	mentioned.Name = "Mentioned"
	mentioned.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	mentioned.BackgroundTransparency = 0.75
	mentioned.BorderSizePixel = 0
	mentioned.Position = UDim2.fromOffset(-8, 0)
	mentioned.Size = UDim2.new(1, 10, 1, 0)

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.Parent = mentioned

	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.AutomaticSize = Enum.AutomaticSize.Y
	bar.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	bar.BorderSizePixel = 0
	bar.Size = UDim2.fromOffset(5, 26)

	local uICorner1 = Instance.new("UICorner")
	uICorner1.Name = "UICorner"
	uICorner1.Parent = bar

	bar.Parent = mentioned

	mentioned.Parent = reply

	reply.Parent = replyArea

	local edit = Instance.new("TextBox")
	edit.Name = "Edit"
	edit.ClearTextOnFocus = false
	edit.Font = environment.config.UI.Fonts.TextFont
	edit.Text = ""
	edit.TextColor3 = Color3.fromRGB(255, 255, 255)
	edit.TextSize = 13
	edit.TextStrokeTransparency = 0.9
	edit.TextTransparency = 1
	edit.TextWrapped = true
	edit.TextXAlignment = Enum.TextXAlignment.Left
	edit.TextYAlignment = Enum.TextYAlignment.Bottom
	edit.Active = false
	edit.AnchorPoint = Vector2.new(1, 0)
	edit.AutomaticSize = Enum.AutomaticSize.Y
	edit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	edit.BackgroundTransparency = 1
	edit.Position = UDim2.fromScale(1, 0)
	edit.Selectable = false
	edit.Size = UDim2.new(1, 0, 0, 16)
	edit.ZIndex = 2
	edit.Parent = replyArea
	collectionService:AddTag(edit,"TextFont")

	replyArea.Parent = bottom

	local bottom1 = Instance.new("Frame")
	bottom1.Name = "Bottom"
	bottom1.AnchorPoint = Vector2.new(0, 1)
	bottom1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bottom1.BackgroundTransparency = 1
	bottom1.ClipsDescendants = true
	bottom1.LayoutOrder = 3
	bottom1.Position = UDim2.new(0, 0, 1, -5)
	bottom1.Size = UDim2.fromOffset(23, 10)
	bottom1.ZIndex = 4

	local bottom2 = Instance.new("ImageLabel")
	bottom2.Name = "Bottom"
	bottom2.Image = "rbxassetid://8594890205"
	bottom2.AnchorPoint = Vector2.new(0, 1)
	bottom2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bottom2.BackgroundTransparency = 1
	bottom2.LayoutOrder = 3
	bottom2.Position = UDim2.fromScale(0, 1)
	bottom2.Size = UDim2.fromOffset(23, 23)
	bottom2.ZIndex = 4
	bottom2.Parent = bottom1

	bottom1.Parent = bottom

	local middle = Instance.new("Frame")
	middle.Name = "Middle"
	middle.AnchorPoint = Vector2.new(0, 1)
	middle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	middle.BackgroundTransparency = 1
	middle.LayoutOrder = 3
	middle.Position = UDim2.new(0, 0, 1, -5)
	middle.Size = UDim2.fromOffset(23, 10)
	middle.ZIndex = 4

	local middle1 = Instance.new("ImageLabel")
	middle1.Name = "Middle"
	middle1.Image = "rbxassetid://8594897232"
	middle1.SliceCenter = Rect.new(28, 0, 300, 300)
	middle1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	middle1.BackgroundTransparency = 1
	middle1.LayoutOrder = 2
	middle1.Position = UDim2.fromScale(0, -100)
	middle1.Size = UDim2.new(0, 23, 100, 0)
	middle1.ZIndex = 3
	middle1.Parent = middle

	middle.Parent = bottom
	return bottom
end

local middle = function(environment)
	local middle = Instance.new("Frame")
	middle.Name = "Middle"
	middle.AutomaticSize = Enum.AutomaticSize.Y
	middle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	middle.BackgroundTransparency = 1
	middle.Size = UDim2.fromScale(1, 0)

	local middle1 = Instance.new("ImageLabel")
	middle1.Name = "Middle"
	middle1.Image = "rbxassetid://8594897232"
	middle1.SliceCenter = Rect.new(28, 0, 300, 300)
	middle1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	middle1.BackgroundTransparency = 1
	middle1.LayoutOrder = 2
	middle1.Size = UDim2.new(0, 23, 1, 0)
	middle1.ZIndex = 3
	middle1.Parent = middle

	local replyArea = Instance.new("Frame")
	replyArea.Name = "ReplyArea"
	replyArea.AutomaticSize = Enum.AutomaticSize.Y
	replyArea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	replyArea.BackgroundTransparency = 1
	replyArea.Position = UDim2.fromOffset(30, 0)
	replyArea.Size = UDim2.new(1, -25, 0, 15)

	local reply = Instance.new("TextLabel")
	reply.Name = "Reply"
	reply.Font = environment.config.UI.Fonts.TextFont
	reply.RichText = true
	reply.Text = ""
	reply.TextColor3 = Color3.fromRGB(255, 255, 255)
	reply.TextSize = 13
	reply.TextStrokeTransparency = 0.9
	reply.TextWrapped = true
	reply.TextXAlignment = Enum.TextXAlignment.Left
	reply.AnchorPoint = Vector2.new(1, 0)
	reply.AutomaticSize = Enum.AutomaticSize.Y
	reply.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	reply.BackgroundTransparency = 1
	reply.Position = UDim2.fromScale(1, 0)
	reply.Size = UDim2.new(1, 0, 0, 16)
	reply.ZIndex = 2
	collectionService:AddTag(reply,"TextFont")
	
	local user = Instance.new("TextButton")
	user.Name = "User"
	user.Font = environment.config.UI.Fonts.TextFont
	user.RichText = true
	user.TextColor3 = Color3.fromRGB(0, 0, 0)
	user.TextSize = 15
	user.TextTransparency = 1
	user.TextWrapped = true
	user.AutomaticSize = Enum.AutomaticSize.XY
	user.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	user.BackgroundTransparency = 1
	user.Size = UDim2.fromOffset(0, 16)
	user.Parent = reply
	collectionService:AddTag(user,"TextFont")

	local mentioned = Instance.new("Frame")
	mentioned.Name = "Mentioned"
	mentioned.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	mentioned.BackgroundTransparency = 0.75
	mentioned.BorderSizePixel = 0
	mentioned.Position = UDim2.fromOffset(-8, 0)
	mentioned.Size = UDim2.new(1, 10, 1, 0)
	mentioned.Visible = false

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.Parent = mentioned

	local bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.AutomaticSize = Enum.AutomaticSize.Y
	bar.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
	bar.BorderSizePixel = 0
	bar.Size = UDim2.fromOffset(5, 26)

	local uICorner1 = Instance.new("UICorner")
	uICorner1.Name = "UICorner"
	uICorner1.Parent = bar

	bar.Parent = mentioned

	mentioned.Parent = reply

	reply.Parent = replyArea

	local edit = Instance.new("TextBox")
	edit.Name = "Edit"
	edit.ClearTextOnFocus = false
	edit.Font = environment.config.UI.Fonts.TextFont
	edit.Text = ""
	edit.TextColor3 = Color3.fromRGB(255, 255, 255)
	edit.TextSize = 13
	edit.TextStrokeTransparency = 0.9
	edit.TextTransparency = 1
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
	edit.ZIndex = 2
	edit.Parent = replyArea
	
	collectionService:AddTag(edit,"TextFont")

	replyArea.Parent = middle
	return middle
end

local new = function(environment)
	local replyMessage = Instance.new("Frame")
	replyMessage.Name = "ReplyMessage"
	replyMessage.AutomaticSize = Enum.AutomaticSize.Y
	replyMessage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	replyMessage.BackgroundTransparency = 1
	replyMessage.Size = UDim2.new(1, 0, 0, 16)

	local original = Instance.new("TextLabel")
	original.Name = "Original"
	original.Font = environment.config.UI.Fonts.TextFont
	original.RichText = true
	original.Text = "Bob: Hello world"
	original.TextColor3 = Color3.fromRGB(255, 255, 255)
	original.TextSize = 12
	original.TextStrokeTransparency = 0.9
	original.TextWrapped = true
	original.TextXAlignment = Enum.TextXAlignment.Left
	original.AnchorPoint = Vector2.new(1, 0)
	original.AutomaticSize = Enum.AutomaticSize.Y
	original.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	original.BackgroundTransparency = 1
	original.Position = UDim2.fromScale(1, 0)
	original.Size = UDim2.new(1, 0, 0, 16)
	original.ZIndex = 2
	collectionService:AddTag(original,"TextFont")

	local user = Instance.new("TextButton")
	user.Name = "User"
	user.Font = environment.config.UI.Fonts.TextFont
	user.RichText = true
	user.TextColor3 = Color3.fromRGB(0, 0, 0)
	user.TextSize = 12
	user.TextTransparency = 1
	user.TextWrapped = true
	user.AutomaticSize = Enum.AutomaticSize.XY
	user.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	user.BackgroundTransparency = 1
	user.Size = UDim2.fromOffset(0, 16)
	user.Parent = original
	collectionService:AddTag(user,"TextFont")

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.Parent = original

	original.Parent = replyMessage

	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon.BackgroundTransparency = 1
	icon.BorderSizePixel = 0
	icon.Size = UDim2.fromOffset(16, 16)
	icon.Visible = false
	icon.Parent = replyMessage

	local edit = Instance.new("TextBox")
	edit.Name = "Edit"
	edit.ClearTextOnFocus = false
	edit.Font = environment.config.UI.Fonts.TextFont
	edit.Text = ""
	edit.TextColor3 = Color3.fromRGB(255, 255, 255)
	edit.TextSize = 15
	edit.TextStrokeTransparency = 0.9
	edit.TextWrapped = true
	edit.TextXAlignment = Enum.TextXAlignment.Left
	edit.AnchorPoint = Vector2.new(1, 0)
	edit.AutomaticSize = Enum.AutomaticSize.Y
	edit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	edit.BackgroundTransparency = 1
	edit.Position = UDim2.fromScale(1, 0)
	edit.Selectable = false
	edit.Size = UDim2.new(1, 0, 0, 16)
	edit.Visible = false
	edit.Parent = replyMessage
	collectionService:AddTag(edit,"TextFont")

	local replyChain = Instance.new("Frame")
	replyChain.Name = "ReplyChain"
	replyChain.AutomaticSize = Enum.AutomaticSize.Y
	replyChain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	replyChain.BackgroundTransparency = 1
	replyChain.Position = UDim2.fromOffset(0, 20)
	replyChain.Size = UDim2.fromScale(1, 0)

	local uIListLayout = Instance.new("UIListLayout")
	uIListLayout.Name = "UIListLayout"
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.Parent = replyChain

	replyChain.Parent = replyMessage
	return replyMessage
end

return {new = function(environment)
	return new(environment)
end,Bottom = function(environment)
	return bottom(environment)
end,Middle = function(environment)
	return middle(environment)
end,}