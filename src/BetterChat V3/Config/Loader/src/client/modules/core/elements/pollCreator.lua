-- Author: @Jumpathy
-- Name: poll.lua
-- Description: Poll creator and manager (cringe code)

local create = function()
	local PollCreate = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local UICorner_2 = Instance.new("UICorner")
	local ImageLabel = Instance.new("ImageLabel")
	local Holder = Instance.new("Frame")
	local Scroller = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ChoiceType = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local MultipleChoice = Instance.new("Frame")
	local Toggle = Instance.new("ImageButton")
	local UICorner_4 = Instance.new("UICorner")
	local Label = Instance.new("TextLabel")
	local Icon = Instance.new("ImageLabel")
	local Number = Instance.new("Frame")
	local Toggle_2 = Instance.new("ImageButton")
	local UICorner_5 = Instance.new("UICorner")
	local Label_2 = Instance.new("TextLabel")
	local Icon_2 = Instance.new("ImageLabel")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local Title_2 = Instance.new("Frame")
	local UICorner_6 = Instance.new("UICorner")
	local Box = Instance.new("TextBox")
	local UICorner_7 = Instance.new("UICorner")
	local UIPadding = Instance.new("UIPadding")
	local Title_3 = Instance.new("TextLabel")
	local Icon_3 = Instance.new("ImageLabel")
	local Warning = Instance.new("ImageLabel")
	local Expires = Instance.new("Frame")
	local UICorner_8 = Instance.new("UICorner")
	local Box_2 = Instance.new("TextBox")
	local UICorner_9 = Instance.new("UICorner")
	local UIPadding_2 = Instance.new("UIPadding")
	local Title_4 = Instance.new("TextLabel")
	local Icon_4 = Instance.new("ImageLabel")
	local NumberOptions = Instance.new("Frame")
	local UICorner_10 = Instance.new("UICorner")
	local Title_5 = Instance.new("TextLabel")
	local Icon_5 = Instance.new("ImageLabel")
	local Warning_2 = Instance.new("ImageLabel")
	local Options = Instance.new("Frame")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local UIPadding_3 = Instance.new("UIPadding")
	local Min = Instance.new("TextLabel")
	local Box_3 = Instance.new("TextBox")
	local UICorner_11 = Instance.new("UICorner")
	local UIPadding_4 = Instance.new("UIPadding")
	local Max = Instance.new("TextLabel")
	local Box_4 = Instance.new("TextBox")
	local UICorner_12 = Instance.new("UICorner")
	local UIPadding_5 = Instance.new("UIPadding")
	local Step = Instance.new("TextLabel")
	local Box_5 = Instance.new("TextBox")
	local UICorner_13 = Instance.new("UICorner")
	local UIPadding_6 = Instance.new("UIPadding")
	local MultipleOptions = Instance.new("Frame")
	local UICorner_14 = Instance.new("UICorner")
	local Title_6 = Instance.new("TextLabel")
	local Icon_6 = Instance.new("ImageLabel")
	local Warning_3 = Instance.new("ImageLabel")
	local Options_2 = Instance.new("Frame")
	local UIListLayout_4 = Instance.new("UIListLayout")
	local UIPadding_7 = Instance.new("UIPadding")
	local Scroller_2 = Instance.new("ScrollingFrame")
	local UIListLayout_5 = Instance.new("UIListLayout")
	local Option = Instance.new("Frame")
	local Box_6 = Instance.new("TextBox")
	local UICorner_15 = Instance.new("UICorner")
	local UIPadding_8 = Instance.new("UIPadding")
	local UICorner_16 = Instance.new("UICorner")
	local Remove = Instance.new("ImageButton")
	local UICorner_17 = Instance.new("UICorner")
	local Add = Instance.new("ImageButton")
	local SeeWhoVoted = Instance.new("Frame")
	local UICorner_18 = Instance.new("UICorner")
	local MultipleChoice_2 = Instance.new("Frame")
	local Toggle_3 = Instance.new("ImageButton")
	local UICorner_19 = Instance.new("UICorner")
	local Label_3 = Instance.new("TextLabel")
	local Icon_7 = Instance.new("ImageLabel")
	local UIListLayout_6 = Instance.new("UIListLayout")
	local Post = Instance.new("TextButton")
	local UICorner_20 = Instance.new("UICorner")
	local ImageLabel_2 = Instance.new("ImageLabel")
	local UIPadding_9 = Instance.new("UIPadding")
	local Image = Instance.new("Frame")
	local UICorner_21 = Instance.new("UICorner")
	local Box_7 = Instance.new("TextBox")
	local UICorner_22 = Instance.new("UICorner")
	local UIPadding_10 = Instance.new("UIPadding")
	local Title_7 = Instance.new("TextLabel")
	local Icon_8 = Instance.new("ImageLabel")
	local ImageLabel_3 = Instance.new("ImageLabel")
	local UICorner_23 = Instance.new("UICorner")
	local UICorner_24 = Instance.new("UICorner")

	--Properties:

	PollCreate.Name = "PollCreate"
	PollCreate.AnchorPoint = Vector2.new(0.5, 0.5)
	PollCreate.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	PollCreate.BackgroundTransparency = 0.500
	PollCreate.BorderSizePixel = 0
	PollCreate.Position = UDim2.new(0.5, 0, 0.5, 0)
	PollCreate.Size = UDim2.new(0, 300, 0, 200)

	UICorner.Parent = PollCreate

	Title.Name = "Title"
	Title.Parent = PollCreate
	Title.AnchorPoint = Vector2.new(0.5, 0)
	Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Title.BackgroundTransparency = 0.500
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.5, 0, 0, 5)
	Title.Size = UDim2.new(1, -10, 0, 35)
	Title.Font = Enum.Font.GothamBold
	Title.Text = "Create Poll"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 16.000

	UICorner_2.Parent = Title

	ImageLabel.Parent = Title
	ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.Position = UDim2.new(0, 5, 0.5, 0)
	ImageLabel.Size = UDim2.new(0, 30, 0, 30)
	ImageLabel.Image = "http://www.roblox.com/asset/?id=6034267991"

	Holder.Name = "Holder"
	Holder.Parent = PollCreate
	Holder.AnchorPoint = Vector2.new(0.5, 0)
	Holder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Holder.BackgroundTransparency = 0.600
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(0.5, 0, 0, 45)
	Holder.Size = UDim2.new(1, -10, 1, -50)

	Scroller.Name = "Scroller"
	Scroller.Parent = Holder
	Scroller.Active = true
	Scroller.AnchorPoint = Vector2.new(0.5, 0.5)
	Scroller.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Scroller.BackgroundTransparency = 1.000
	Scroller.BorderSizePixel = 0
	Scroller.Position = UDim2.new(0.5, 0, 0.5, 0)
	Scroller.Size = UDim2.new(1, -10, 1, -10)
	Scroller.BottomImage = "rbxassetid://8082116996"
	Scroller.CanvasPosition = Vector2.new(0, 400)
	Scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
	Scroller.MidImage = "rbxassetid://7488333553"
	Scroller.ScrollBarThickness = 5
	Scroller.TopImage = "rbxassetid://8082122989"

	UIListLayout.Parent = Scroller
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	ChoiceType.Name = "ChoiceType"
	ChoiceType.Parent = Scroller
	ChoiceType.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	ChoiceType.BackgroundTransparency = 0.500
	ChoiceType.BorderColor3 = Color3.fromRGB(27, 42, 53)
	ChoiceType.Size = UDim2.new(1, -10, 0, 75)

	UICorner_3.Parent = ChoiceType

	MultipleChoice.Name = "MultipleChoice"
	MultipleChoice.Parent = ChoiceType
	MultipleChoice.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MultipleChoice.BackgroundTransparency = 1.000
	MultipleChoice.BorderColor3 = Color3.fromRGB(27, 42, 53)
	MultipleChoice.Size = UDim2.new(1, 0, 0, 35)

	Toggle.Name = "Toggle"
	Toggle.Parent = MultipleChoice
	Toggle.AnchorPoint = Vector2.new(0, 0.5)
	Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.BackgroundTransparency = 1.000
	Toggle.Position = UDim2.new(0, 5, 0.5, 0)
	Toggle.Size = UDim2.new(0, 25, 0, 25)
	Toggle.Image = "http://www.roblox.com/asset/?id=6031068433"

	UICorner_4.Parent = MultipleChoice

	Label.Name = "Label"
	Label.Parent = MultipleChoice
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.BackgroundTransparency = 1.000
	Label.Position = UDim2.new(0, 40, 0, 0)
	Label.Size = UDim2.new(0, 200, 1, 0)
	Label.Font = Enum.Font.GothamMedium
	Label.Text = "Multiple-choice"
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.TextSize = 14.000
	Label.TextWrapped = true
	Label.TextXAlignment = Enum.TextXAlignment.Left

	Icon.Name = "Icon"
	Icon.Parent = MultipleChoice
	Icon.AnchorPoint = Vector2.new(1, 0.5)
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1.000
	Icon.Position = UDim2.new(1, -10, 0.5, 0)
	Icon.Size = UDim2.new(0, 25, 0, 25)
	Icon.Image = "http://www.roblox.com/asset/?id=6034837797"

	Number.Name = "Number"
	Number.Parent = ChoiceType
	Number.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Number.BackgroundTransparency = 1.000
	Number.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Number.Size = UDim2.new(1, 0, 0, 35)

	Toggle_2.Name = "Toggle"
	Toggle_2.Parent = Number
	Toggle_2.AnchorPoint = Vector2.new(0, 0.5)
	Toggle_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Toggle_2.BackgroundTransparency = 1.000
	Toggle_2.Position = UDim2.new(0, 5, 0.5, 0)
	Toggle_2.Size = UDim2.new(0, 25, 0, 25)
	Toggle_2.Image = "http://www.roblox.com/asset/?id=6031068433"

	UICorner_5.Parent = Number

	Label_2.Name = "Label"
	Label_2.Parent = Number
	Label_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label_2.BackgroundTransparency = 1.000
	Label_2.Position = UDim2.new(0, 40, 0, 0)
	Label_2.Size = UDim2.new(0, 200, 1, 0)
	Label_2.Font = Enum.Font.GothamMedium
	Label_2.Text = "Number rating"
	Label_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label_2.TextSize = 14.000
	Label_2.TextWrapped = true
	Label_2.TextXAlignment = Enum.TextXAlignment.Left

	Icon_2.Name = "Icon"
	Icon_2.Parent = Number
	Icon_2.AnchorPoint = Vector2.new(1, 0.5)
	Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_2.BackgroundTransparency = 1.000
	Icon_2.Position = UDim2.new(1, -10, 0.5, 0)
	Icon_2.Size = UDim2.new(0, 25, 0, 25)
	Icon_2.Image = "http://www.roblox.com/asset/?id=6034941707"

	UIListLayout_2.Parent = ChoiceType
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

	Title_2.Name = "Title"
	Title_2.Parent = Scroller
	Title_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Title_2.BackgroundTransparency = 0.500
	Title_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Title_2.LayoutOrder = 1
	Title_2.Size = UDim2.new(1, -10, 0, 65)

	UICorner_6.Parent = Title_2

	Box.Name = "Box"
	Box.Parent = Title_2
	Box.AnchorPoint = Vector2.new(0.5, 1)
	Box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Box.BorderSizePixel = 0
	Box.Position = UDim2.new(0.5, 0, 1, -5)
	Box.Size = UDim2.new(1, -10, 0, 25)
	Box.Font = Enum.Font.GothamMedium
	Box.PlaceholderText = "Lorem ipsum"
	Box.Text = ""
	Box.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box.TextSize = 14.000
	Box.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Box.TextXAlignment = Enum.TextXAlignment.Left
	Box.TextTruncate = Enum.TextTruncate.AtEnd
	
	UICorner_7.Parent = Box

	UIPadding.Parent = Box
	UIPadding.PaddingBottom = UDim.new(0, 5)
	UIPadding.PaddingLeft = UDim.new(0, 8)
	UIPadding.PaddingRight = UDim.new(0, 5)
	UIPadding.PaddingTop = UDim.new(0, 5)

	Title_3.Name = "Title"
	Title_3.Parent = Title_2
	Title_3.AnchorPoint = Vector2.new(0.5, 0)
	Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_3.BackgroundTransparency = 1.000
	Title_3.BorderSizePixel = 0
	Title_3.Position = UDim2.new(0.5, 0, 0, 5)
	Title_3.Size = UDim2.new(1, -10, 0, 25)
	Title_3.Font = Enum.Font.GothamBold
	Title_3.Text = "Title <font face=\"GothamMedium\" color=\"rgb(200,200,200)\">(required)</font>"
	Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_3.TextSize = 14.000
	Title_3.RichText = true

	Icon_3.Name = "Icon"
	Icon_3.Parent = Title_3
	Icon_3.AnchorPoint = Vector2.new(0, 0.5)
	Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_3.BackgroundTransparency = 1.000
	Icon_3.Position = UDim2.new(0, 5, 0.5, 0)
	Icon_3.Size = UDim2.new(0, 20, 0, 20)
	Icon_3.Image = "http://www.roblox.com/asset/?id=6034934042"

	Warning.Name = "Warning"
	Warning.Parent = Title_3
	Warning.AnchorPoint = Vector2.new(1, 0.5)
	Warning.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Warning.BackgroundTransparency = 1.000
	Warning.Position = UDim2.new(1, -5, 0.5, 0)
	Warning.Size = UDim2.new(0, 20, 0, 20)
	Warning.Image = "http://www.roblox.com/asset/?id=6031071053"
	Warning.ImageColor3 = Color3.fromRGB(255, 200, 0)

	Expires.Name = "Expires"
	Expires.Visible = false
	Expires.Parent = Scroller
	Expires.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Expires.BackgroundTransparency = 0.500
	Expires.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Expires.LayoutOrder = 2
	Expires.Size = UDim2.new(1, -10, 0, 65)

	UICorner_8.Parent = Expires

	Box_2.Name = "Box"
	Box_2.Parent = Expires
	Box_2.AnchorPoint = Vector2.new(0.5, 1)
	Box_2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Box_2.BorderSizePixel = 0
	Box_2.Position = UDim2.new(0.5, 0, 1, -5)
	Box_2.Size = UDim2.new(1, -10, 0, 25)
	Box_2.Font = Enum.Font.GothamMedium
	Box_2.PlaceholderText = "99999"
	Box_2.Text = ""
	Box_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box_2.TextSize = 14.000
	Box_2.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Box_2.TextXAlignment = Enum.TextXAlignment.Left

	UICorner_9.Parent = Box_2

	UIPadding_2.Parent = Box_2
	UIPadding_2.PaddingBottom = UDim.new(0, 5)
	UIPadding_2.PaddingLeft = UDim.new(0, 8)
	UIPadding_2.PaddingRight = UDim.new(0, 5)
	UIPadding_2.PaddingTop = UDim.new(0, 5)

	Title_4.Name = "Title"
	Title_4.Parent = Expires
	Title_4.AnchorPoint = Vector2.new(0.5, 0)
	Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_4.BackgroundTransparency = 1.000
	Title_4.BorderSizePixel = 0
	Title_4.Position = UDim2.new(0.5, 0, 0, 5)
	Title_4.Size = UDim2.new(1, -10, 0, 25)
	Title_4.Font = Enum.Font.GothamBold
	Title_4.Text = "Expires <font face=\"GothamMedium\" color=\"rgb(200,200,200)\">(optional)</font>"
	Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_4.TextSize = 14.000
	Title_4.RichText = true

	Icon_4.Name = "Icon"
	Icon_4.Parent = Title_4
	Icon_4.AnchorPoint = Vector2.new(0, 0.5)
	Icon_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_4.BackgroundTransparency = 1.000
	Icon_4.Position = UDim2.new(0, 5, 0.5, 0)
	Icon_4.Size = UDim2.new(0, 20, 0, 20)
	Icon_4.Image = "http://www.roblox.com/asset/?id=6022668894"

	NumberOptions.Name = "NumberOptions"
	NumberOptions.Parent = Scroller
	NumberOptions.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	NumberOptions.BackgroundTransparency = 0.500
	NumberOptions.BorderColor3 = Color3.fromRGB(27, 42, 53)
	NumberOptions.LayoutOrder = 3
	NumberOptions.Size = UDim2.new(1, -10, 0, 65)

	UICorner_10.Parent = NumberOptions

	Title_5.Name = "Title"
	Title_5.Parent = NumberOptions
	Title_5.AnchorPoint = Vector2.new(0.5, 0)
	Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_5.BackgroundTransparency = 1.000
	Title_5.BorderSizePixel = 0
	Title_5.Position = UDim2.new(0.5, 0, 0, 5)
	Title_5.Size = UDim2.new(1, -10, 0, 25)
	Title_5.Font = Enum.Font.GothamBold
	Title_5.Text = "Range <font face=\"GothamMedium\" color=\"rgb(200,200,200)\">(required)</font>"
	Title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_5.TextSize = 14.000
	Title_5.RichText = true
	
	Icon_5.Name = "Icon"
	Icon_5.Parent = Title_5
	Icon_5.AnchorPoint = Vector2.new(0, 0.5)
	Icon_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_5.BackgroundTransparency = 1.000
	Icon_5.Position = UDim2.new(0, 5, 0.5, 0)
	Icon_5.Size = UDim2.new(0, 20, 0, 20)
	Icon_5.Image = "http://www.roblox.com/asset/?id=6034941707"

	Warning_2.Name = "Warning"
	Warning_2.Parent = Title_5
	Warning_2.AnchorPoint = Vector2.new(1, 0.5)
	Warning_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Warning_2.BackgroundTransparency = 1.000
	Warning_2.Position = UDim2.new(1, -5, 0.5, 0)
	Warning_2.Size = UDim2.new(0, 20, 0, 20)
	Warning_2.Image = "http://www.roblox.com/asset/?id=6031071053"
	Warning_2.ImageColor3 = Color3.fromRGB(255, 200, 0)

	Options.Name = "Options"
	Options.Parent = NumberOptions
	Options.AnchorPoint = Vector2.new(0.5, 1)
	Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Options.BackgroundTransparency = 1.000
	Options.BorderSizePixel = 0
	Options.Position = UDim2.new(0.5, 0, 1, -5)
	Options.Size = UDim2.new(1, -10, 0, 25)

	UIListLayout_3.Parent = Options
	UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_3.Padding = UDim.new(0, 10)

	UIPadding_3.Parent = Options
	UIPadding_3.PaddingLeft = UDim.new(0, 5)
	UIPadding_3.PaddingRight = UDim.new(0, 5)

	Min.Name = "Min"
	Min.Parent = Options
	Min.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Min.BackgroundTransparency = 1.000
	Min.Size = UDim2.new(0, 80, 0, 25)
	Min.Font = Enum.Font.GothamMedium
	Min.Text = "Min"
	Min.TextColor3 = Color3.fromRGB(255, 255, 255)
	Min.TextSize = 14.000
	Min.TextXAlignment = Enum.TextXAlignment.Left

	Box_3.Name = "Box"
	Box_3.Parent = Min
	Box_3.AnchorPoint = Vector2.new(0, 0.5)
	Box_3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Box_3.BorderSizePixel = 0
	Box_3.Position = UDim2.new(0, 35, 0.5, 0)
	Box_3.Size = UDim2.new(0, 40, 0, 25)
	Box_3.Font = Enum.Font.GothamMedium
	Box_3.PlaceholderText = "1"
	Box_3.Text = ""
	Box_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box_3.TextSize = 14.000
	Box_3.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

	UICorner_11.Parent = Box_3

	UIPadding_4.Parent = Box_3
	UIPadding_4.PaddingBottom = UDim.new(0, 5)
	UIPadding_4.PaddingLeft = UDim.new(0, 8)
	UIPadding_4.PaddingRight = UDim.new(0, 5)
	UIPadding_4.PaddingTop = UDim.new(0, 5)

	Max.Name = "Max"
	Max.Parent = Options
	Max.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Max.BackgroundTransparency = 1.000
	Max.LayoutOrder = 1
	Max.Size = UDim2.new(0, 80, 0, 25)
	Max.Font = Enum.Font.GothamMedium
	Max.Text = "Max"
	Max.TextColor3 = Color3.fromRGB(255, 255, 255)
	Max.TextSize = 14.000
	Max.TextWrapped = true
	Max.TextXAlignment = Enum.TextXAlignment.Left

	Box_4.Name = "Box"
	Box_4.Parent = Max
	Box_4.AnchorPoint = Vector2.new(0, 0.5)
	Box_4.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Box_4.BorderSizePixel = 0
	Box_4.Position = UDim2.new(0, 35, 0.5, 0)
	Box_4.Size = UDim2.new(0, 40, 0, 25)
	Box_4.Font = Enum.Font.GothamMedium
	Box_4.PlaceholderText = "10"
	Box_4.Text = ""
	Box_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box_4.TextSize = 14.000
	Box_4.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

	UICorner_12.Parent = Box_4

	UIPadding_5.Parent = Box_4
	UIPadding_5.PaddingBottom = UDim.new(0, 5)
	UIPadding_5.PaddingLeft = UDim.new(0, 8)
	UIPadding_5.PaddingRight = UDim.new(0, 5)
	UIPadding_5.PaddingTop = UDim.new(0, 5)

	Step.Name = "Step"
	Step.Parent = Options
	Step.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Step.BackgroundTransparency = 1.000
	Step.LayoutOrder = 2
	Step.Size = UDim2.new(0, 80, 0, 25)
	Step.Font = Enum.Font.GothamMedium
	Step.Text = "Step"
	Step.TextColor3 = Color3.fromRGB(255, 255, 255)
	Step.TextSize = 14.000
	Step.TextXAlignment = Enum.TextXAlignment.Left

	Box_5.Name = "Box"
	Box_5.Parent = Step
	Box_5.AnchorPoint = Vector2.new(0, 0.5)
	Box_5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Box_5.BorderSizePixel = 0
	Box_5.Position = UDim2.new(0, 35, 0.5, 0)
	Box_5.Size = UDim2.new(0, 40, 0, 25)
	Box_5.Font = Enum.Font.GothamMedium
	Box_5.PlaceholderText = "1"
	Box_5.Text = ""
	Box_5.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box_5.TextSize = 14.000
	Box_5.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

	UICorner_13.Parent = Box_5

	UIPadding_6.Parent = Box_5
	UIPadding_6.PaddingBottom = UDim.new(0, 5)
	UIPadding_6.PaddingLeft = UDim.new(0, 8)
	UIPadding_6.PaddingRight = UDim.new(0, 5)
	UIPadding_6.PaddingTop = UDim.new(0, 5)

	MultipleOptions.Name = "MultipleOptions"
	MultipleOptions.Parent = Scroller
	MultipleOptions.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MultipleOptions.BackgroundTransparency = 0.500
	MultipleOptions.BorderColor3 = Color3.fromRGB(27, 42, 53)
	MultipleOptions.ClipsDescendants = true
	MultipleOptions.LayoutOrder = 3
	MultipleOptions.Size = UDim2.new(1, -10, 0, 100)

	UICorner_14.Parent = MultipleOptions

	Title_6.Name = "Title"
	Title_6.Parent = MultipleOptions
	Title_6.AnchorPoint = Vector2.new(0.5, 0)
	Title_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_6.BackgroundTransparency = 1.000
	Title_6.BorderSizePixel = 0
	Title_6.Position = UDim2.new(0.5, 0, 0, 5)
	Title_6.Size = UDim2.new(1, -10, 0, 25)
	Title_6.Font = Enum.Font.GothamBold
	Title_6.Text = "Options <font face=\"GothamMedium\" color=\"rgb(200,200,200)\">(required)</font>"
	Title_6.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_6.TextSize = 14.000
	Title_6.RichText = true
	
	Icon_6.Name = "Icon"
	Icon_6.Parent = Title_6
	Icon_6.AnchorPoint = Vector2.new(0, 0.5)
	Icon_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_6.BackgroundTransparency = 1.000
	Icon_6.Position = UDim2.new(0, 5, 0.5, 0)
	Icon_6.Size = UDim2.new(0, 20, 0, 20)
	Icon_6.Image = "http://www.roblox.com/asset/?id=6026568229"

	Warning_3.Name = "Warning"
	Warning_3.Parent = Title_6
	Warning_3.AnchorPoint = Vector2.new(1, 0.5)
	Warning_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Warning_3.BackgroundTransparency = 1.000
	Warning_3.Position = UDim2.new(1, -10, 0.5, 0)
	Warning_3.Size = UDim2.new(0, 20, 0, 20)
	Warning_3.Image = "http://www.roblox.com/asset/?id=6031071053"
	Warning_3.ImageColor3 = Color3.fromRGB(255, 200, 0)

	Options_2.Name = "Options"
	Options_2.Parent = MultipleOptions
	Options_2.AnchorPoint = Vector2.new(0.5, 1)
	Options_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Options_2.BackgroundTransparency = 1.000
	Options_2.BorderSizePixel = 0
	Options_2.Position = UDim2.new(0.5, 0, 1, -5)
	Options_2.Size = UDim2.new(1, -10, 0, 25)

	UIListLayout_4.Parent = Options_2
	UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_4.Padding = UDim.new(0, 10)

	UIPadding_7.Parent = Options_2
	UIPadding_7.PaddingLeft = UDim.new(0, 5)
	UIPadding_7.PaddingRight = UDim.new(0, 5)

	Scroller_2.Name = "Scroller"
	Scroller_2.Parent = MultipleOptions
	Scroller_2.Active = true
	Scroller_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Scroller_2.BackgroundTransparency = 1.000
	Scroller_2.BorderSizePixel = 0
	Scroller_2.Position = UDim2.new(0, 5, 0, 30)
	Scroller_2.Size = UDim2.new(1, -40, 0, 300)
	Scroller_2.BottomImage = "rbxassetid://8082116996"
	Scroller_2.CanvasSize = UDim2.new(0, 0, 0, 0)
	Scroller_2.MidImage = "rbxassetid://7488333553"
	Scroller_2.ScrollBarThickness = 5
	Scroller_2.TopImage = "rbxassetid://8082122989"

	UIListLayout_5.Parent = Scroller_2
	UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder

	Option.Name = "Option"
	Option.Parent = Scroller_2
	Option.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Option.Size = UDim2.new(1, -10, 0, 30)

	Box_6.Name = "Box"
	Box_6.Parent = Option
	Box_6.AnchorPoint = Vector2.new(0, 0.5)
	Box_6.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Box_6.BorderSizePixel = 0
	Box_6.Position = UDim2.new(0, 5, 0.5, 0)
	Box_6.Size = UDim2.new(1, -45, 0, 25)
	Box_6.Font = Enum.Font.GothamMedium
	Box_6.PlaceholderText = "Lorem ipsum"
	Box_6.Text = ""
	Box_6.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box_6.TextSize = 14.000
	Box_6.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Box_6.TextXAlignment = Enum.TextXAlignment.Left
	Box_6.ClearTextOnFocus = false
	
	UICorner_15.Parent = Box_6

	UIPadding_8.Parent = Box_6
	UIPadding_8.PaddingBottom = UDim.new(0, 5)
	UIPadding_8.PaddingLeft = UDim.new(0, 8)
	UIPadding_8.PaddingRight = UDim.new(0, 5)
	UIPadding_8.PaddingTop = UDim.new(0, 5)

	UICorner_16.Parent = Option

	Remove.Name = "Remove"
	Remove.Parent = Option
	Remove.Active = false
	Remove.AnchorPoint = Vector2.new(1, 0.5)
	Remove.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Remove.Position = UDim2.new(1, -10, 0.5, 0)
	Remove.Selectable = false
	Remove.Size = UDim2.new(0, 25, 0, 25)
	Remove.Image = "http://www.roblox.com/asset/?id=6035067836"

	UICorner_17.Parent = Remove

	Add.Name = "Add"
	Add.Parent = MultipleOptions
	Add.AnchorPoint = Vector2.new(1, 0)
	Add.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Add.BackgroundTransparency = 1.000
	Add.Position = UDim2.new(1, -10, 0, 30)
	Add.Size = UDim2.new(0, 30, 0, 30)
	Add.Image = "http://www.roblox.com/asset/?id=6035047391"

	SeeWhoVoted.Name = "SeeWhoVoted"
	SeeWhoVoted.Parent = Scroller
	SeeWhoVoted.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	SeeWhoVoted.BackgroundTransparency = 0.500
	SeeWhoVoted.BorderColor3 = Color3.fromRGB(27, 42, 53)
	SeeWhoVoted.LayoutOrder = 4
	SeeWhoVoted.Size = UDim2.new(1, -10, 0, 35)

	UICorner_18.Parent = SeeWhoVoted

	MultipleChoice_2.Name = "MultipleChoice"
	MultipleChoice_2.Parent = SeeWhoVoted
	MultipleChoice_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MultipleChoice_2.BackgroundTransparency = 1.000
	MultipleChoice_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
	MultipleChoice_2.Size = UDim2.new(1, 0, 0, 35)

	Toggle_3.Name = "Toggle"
	Toggle_3.Parent = MultipleChoice_2
	Toggle_3.AnchorPoint = Vector2.new(0, 0.5)
	Toggle_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Toggle_3.BackgroundTransparency = 1.000
	Toggle_3.Position = UDim2.new(0, 5, 0.5, 0)
	Toggle_3.Size = UDim2.new(0, 25, 0, 25)
	Toggle_3.Image = "http://www.roblox.com/asset/?id=6031068433"

	UICorner_19.Parent = MultipleChoice_2

	Label_3.Name = "Label"
	Label_3.Parent = MultipleChoice_2
	Label_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label_3.BackgroundTransparency = 1.000
	Label_3.Position = UDim2.new(0, 40, 0, 0)
	Label_3.Size = UDim2.new(0, 200, 1, 0)
	Label_3.Font = Enum.Font.GothamMedium
	Label_3.Text = "See who voted"
	Label_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label_3.TextSize = 14.000
	Label_3.TextWrapped = true
	Label_3.TextXAlignment = Enum.TextXAlignment.Left

	Icon_7.Name = "Icon"
	Icon_7.Parent = MultipleChoice_2
	Icon_7.AnchorPoint = Vector2.new(1, 0.5)
	Icon_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_7.BackgroundTransparency = 1.000
	Icon_7.Position = UDim2.new(1, -10, 0.5, 0)
	Icon_7.Size = UDim2.new(0, 25, 0, 25)
	Icon_7.Image = "http://www.roblox.com/asset/?id=6031763426"

	UIListLayout_6.Parent = SeeWhoVoted
	UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_6.VerticalAlignment = Enum.VerticalAlignment.Center

	Post.Name = "Post"
	Post.Parent = Scroller
	Post.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Post.BorderSizePixel = 0
	Post.LayoutOrder = 5
	Post.Size = UDim2.new(1, -10, 0, 35)
	Post.Font = Enum.Font.GothamMedium
	Post.Text = "Post"
	Post.TextColor3 = Color3.fromRGB(255, 255, 255)
	Post.TextSize = 14.000
	Post.TextXAlignment = Enum.TextXAlignment.Left

	UICorner_20.Parent = Post

	ImageLabel_2.Parent = Post
	ImageLabel_2.AnchorPoint = Vector2.new(0, 0.5)
	ImageLabel_2.BackgroundTransparency = 1.000
	ImageLabel_2.BorderSizePixel = 0
	ImageLabel_2.Position = UDim2.new(0, -35, 0.5, 0)
	ImageLabel_2.Size = UDim2.new(0, 25, 0, 25)
	ImageLabel_2.Image = "http://www.roblox.com/asset/?id=6034973083"

	UIPadding_9.Parent = Post
	UIPadding_9.PaddingLeft = UDim.new(0, 40)

	Image.Name = "Image"
	Image.Parent = Scroller
	Image.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Image.BackgroundTransparency = 0.500
	Image.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Image.LayoutOrder = 1
	Image.Size = UDim2.new(1, -10, 0, 65)

	UICorner_21.Parent = Image

	Box_7.Name = "Box"
	Box_7.Parent = Image
	Box_7.AnchorPoint = Vector2.new(0, 1)
	Box_7.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Box_7.BorderSizePixel = 0
	Box_7.Position = UDim2.new(0, 5, 1, -5)
	Box_7.Size = UDim2.new(1.0925926, -100, 0, 25)
	Box_7.Font = Enum.Font.GothamMedium
	Box_7.PlaceholderText = "rbxassetid://0"
	Box_7.Text = ""
	Box_7.TextColor3 = Color3.fromRGB(255, 255, 255)
	Box_7.TextSize = 14.000
	Box_7.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
	Box_7.TextXAlignment = Enum.TextXAlignment.Left

	UICorner_22.Parent = Box_7

	UIPadding_10.Parent = Box_7
	UIPadding_10.PaddingBottom = UDim.new(0, 5)
	UIPadding_10.PaddingLeft = UDim.new(0, 8)
	UIPadding_10.PaddingRight = UDim.new(0, 5)
	UIPadding_10.PaddingTop = UDim.new(0, 5)

	Title_7.Name = "Title"
	Title_7.Parent = Image
	Title_7.AnchorPoint = Vector2.new(0.5, 0)
	Title_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_7.BackgroundTransparency = 1.000
	Title_7.BorderSizePixel = 0
	Title_7.Position = UDim2.new(0.5, 0, 0, 5)
	Title_7.Size = UDim2.new(1, -10, 0, 25)
	Title_7.Font = Enum.Font.GothamBold
	Title_7.Text = "Image <font face=\"GothamMedium\" color=\"rgb(200,200,200)\">(optional)</font>"
	Title_7.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_7.TextSize = 14.000
	Title_7.RichText = true
	
	Icon_8.Name = "Icon"
	Icon_8.Parent = Title_7
	Icon_8.AnchorPoint = Vector2.new(0, 0.5)
	Icon_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_8.BackgroundTransparency = 1.000
	Icon_8.Position = UDim2.new(0, 5, 0.5, 0)
	Icon_8.Size = UDim2.new(0, 20, 0, 20)
	Icon_8.Image = "http://www.roblox.com/asset/?id=6034407078"

	ImageLabel_3.Parent = Image
	ImageLabel_3.AnchorPoint = Vector2.new(1, 0.5)
	ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel_3.Position = UDim2.new(1, -10, 0.5, 0)
	ImageLabel_3.Size = UDim2.new(0, 50, 0, 50)
	ImageLabel_3.Image = "rbxassetid://4169806398"
	ImageLabel_3.ScaleType = Enum.ScaleType.Fit

	UICorner_23.Parent = ImageLabel_3

	UICorner_24.Parent = Holder
	return PollCreate
end

local radioButtons = {
	[true] = "rbxassetid://6031068426",
	[false] = "rbxassetid://6031068433"
}

local getChildrenOfClass = function(holder,class) -- function name lowkey sounds racist but thats ok :skull:
	local found = {}
	for _,child in pairs(holder:GetChildren()) do
		if(child:IsA(class)) then
			table.insert(found,child)
		end
	end
	return found
end

local collectors = {}

local collect = function(signal,object)
	if(not collectors[object]) then
		collectors[object] = {}
		local signal;
		signal = object.Changed:Connect(function()
			if(object:GetFullName() == object.Name) then
				signal:Disconnect()
				for _,signal in pairs(collectors[object]) do
					signal:Disconnect()
				end
				collectors[object] = nil
			end
		end)
	end
	table.insert(collectors[object],signal)
end

local createStandardToggle = function(object,callback)
	local state = false
	collect(object.Toggle.MouseButton1Click:Connect(function()
		state = not state
		object.Toggle.Image = radioButtons[state]
		callback(state)
	end),object)
end

local createMultipleToggle = function(object,callback)
	local children = getChildrenOfClass(object,"Frame")
	local manipulate = {}
	for i,container in pairs(children) do
		local pick = function()
			for _,child in pairs(children) do
				child.Toggle.Image = radioButtons[child == container]
			end
			callback(container.Name)
		end
		collect(container.Toggle.MouseButton1Click:Connect(pick),object)
		manipulate[i] = pick
	end
	manipulate[1]()
end

local max = 10

local createMultipleOption = function(object,callback)
	local base = 35
	local count,ids = 0,0
	
	local scroller = object.Scroller
	local layout = scroller.UIListLayout
	scroller.Size = UDim2.new(1,-40,0,0)
	
	local template = scroller.Option:Clone()
	scroller.Option:Destroy()
	
	local new = function()
		count += 1
		ids += 1
		local id = ids
		local option = template:Clone()
		option.Parent = scroller
		collect(option:FindFirstChild("Remove").MouseButton1Click:Connect(function()
			if((count - 1) >= 1) then
				count -= 1
				option:Destroy()
				callback(id,nil)
			end
		end),object)
		collect(option.Box:GetPropertyChangedSignal("Text"):Connect(function()
			callback(id,option.Box.Text)
		end),object)
	end
	
	local updateSize = function()
		local size = layout.AbsoluteContentSize.Y
		scroller.Size = UDim2.new(1,-40,0,size)
		object.Size = UDim2.new(1,-10,0,base + size)
	end
	
	collect(layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize),object)
	updateSize()
	
	collect(object.Add.MouseButton1Click:Connect(function()
		if(count < max) then
			new()
		end
	end),object)
	
	new()
end

local createRange = function(object,callback)
	local range = {["min"] = 1,["max"] = 10,["step"] = 1}
	for _,child in pairs(getChildrenOfClass(object.Options,"TextLabel")) do
		collect(child.Box:GetPropertyChangedSignal("Text"):Connect(function()
			range[child.Name:lower()] = (tonumber(child.Box.Text) or 1)
			callback(range)
		end),child)
	end
	callback(range)
end

local marketplaceService = game:GetService("MarketplaceService")

local verifyImage = function(text)
	local nums = text:gsub("%D+","")
	local id = tonumber(nums)
	if(id) then
		local success,response = pcall(function()
			return marketplaceService:GetProductInfo(id)
		end)
		if(response and success) then
			return(response.AssetTypeId == 1)
		end
	end
end

return function(parent,callback)
	local multipleChoiceMenu = {}
	
	local options = {
		multipleChoice = {}
	}
	
	local gui = create()
	gui.Position = UDim2.fromScale(0.5,-1.5)
	gui.Parent = parent
	gui:TweenPosition(UDim2.fromScale(0.5,0.5),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.25,true)
	
	local holder = gui.Holder
	local scroller = holder.Scroller
	
	local choiceType = scroller.ChoiceType
	createMultipleToggle(choiceType,function(picked)
		local isNumber = picked == "Number"
		scroller.SeeWhoVoted.Visible = (not isNumber)
		scroller.MultipleOptions.Visible = (not isNumber)
		scroller.NumberOptions.Visible = isNumber
		options.pollType = picked
	end)
	
	createStandardToggle(scroller.SeeWhoVoted.MultipleChoice,function(state)
		options.seeWhoVoted = state
	end)
	
	local layout = scroller:FindFirstChildOfClass("UIListLayout")
	local update = function()
		scroller.CanvasSize = UDim2.fromOffset(0,layout.AbsoluteContentSize.Y)
	end
	
	collect(layout.Changed:Connect(update),gui)
	update()
	
	createMultipleOption(scroller.MultipleOptions,function(id,state)
		if(not state) then
			table.remove(multipleChoiceMenu,id)
		end
		multipleChoiceMenu[id] = state
		local key = 0
		options.multipleChoice = {}
		for _,option in pairs(multipleChoiceMenu) do
			if(option ~= "") then
				key += 1
				options.multipleChoice[key] = option
			end
		end
	end)
	
	collect(scroller.Title.Box.Changed:Connect(function()
		options.title = scroller.Title.Box.Text
	end),gui)
	
	local box = scroller.Image.Box
	local current
	collect(box.Changed:Connect(function()
		local key = tick()
		current = key
		box.Parent.ImageLabel.Image = box.Text
		local new = box.Text
		if(verifyImage(new)) then
			if(key == current) then
				options.image = new
			end
		end
	end),gui)
	
	box.Text = ""
	
	collect(scroller.Expires.Box:GetPropertyChangedSignal("Text"):Connect(function()
		local num = tonumber(scroller.Expires.Box.Text)
		options.expiresIn = num
	end),gui)
	
	createRange(scroller.NumberOptions,function(range)
		options.range = range
	end)
	
	collect(scroller.Post.MouseButton1Click:Connect(function()
		gui:Destroy()
		callback(options)
	end),gui)
end