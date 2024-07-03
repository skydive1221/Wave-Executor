-- Author: @Jumpathy
-- Name: chatGui.lua
-- Description: Chat gui

return function()
	chat = Instance.new("ScreenGui")
	chat.Name = "Chat"
	chat.DisplayOrder = 2
	chat.ResetOnSpawn = false

	container = Instance.new("Frame")
	container.Name = "Container"
	container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	container.BackgroundTransparency = 1
	container.Position = UDim2.fromOffset(16, 8)
	container.Size = UDim2.fromOffset(400, 235)
	container.Visible = false

	chatWindow = Instance.new("Frame")
	chatWindow.Name = "ChatWindow"
	chatWindow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	chatWindow.BackgroundTransparency = 1
	chatWindow.BorderSizePixel = 0
	chatWindow.Size = UDim2.new(1, 0, 1, -35)

	main = Instance.new("Frame")
	main.Name = "Main"
	main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	main.BackgroundTransparency = 0.75
	main.BorderSizePixel = 0
	main.ClipsDescendants = true
	main.Size = UDim2.fromScale(1, 1)

	uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.Parent = main

	scroller = Instance.new("ScrollingFrame")
	scroller.Name = "Scroller"
	scroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroller.BottomImage = "rbxassetid://8082116996"
	scroller.CanvasSize = UDim2.new()
	scroller.MidImage = "rbxassetid://7488333553"
	scroller.ScrollBarThickness = 0
	scroller.TopImage = "rbxassetid://8082122989"
	scroller.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scroller.BackgroundTransparency = 1
	scroller.BorderSizePixel = 0
	scroller.Position = UDim2.fromOffset(5, 5)
	scroller.Selectable = false
	scroller.Size = UDim2.new(1, -15, 1, -10)

	messageContainer = Instance.new("Frame")
	messageContainer.Name = "MessageContainer"
	messageContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	messageContainer.BackgroundTransparency = 1
	messageContainer.Size = UDim2.new(1, -10, 0, 0)

	uIListLayout = Instance.new("UIListLayout")
	uIListLayout.Name = "UIListLayout"
	uIListLayout.Padding = UDim.new(0, 2)
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.Parent = messageContainer

	messageContainer.Parent = scroller

	scroller.Parent = main

	main.Parent = chatWindow

	chatWindow.Parent = container

	chatBarContainer = Instance.new("Frame")
	chatBarContainer.Name = "ChatBarContainer"
	chatBarContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	chatBarContainer.BackgroundTransparency = 1
	chatBarContainer.BorderSizePixel = 0
	chatBarContainer.Position = UDim2.fromOffset(0, 205)
	chatBarContainer.Size = UDim2.new(1, 0, 0, 35)

	main1 = Instance.new("Frame")
	main1.Name = "Main"
	main1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	main1.BackgroundTransparency = 1
	main1.BorderSizePixel = 0
	main1.Size = UDim2.new(1, 0, 0, 35)

	container1 = Instance.new("Frame")
	container1.Name = "Container"
	container1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	container1.BackgroundTransparency = 0.75
	container1.BorderSizePixel = 0
	container1.Size = UDim2.fromScale(1, 1)

	uICorner1 = Instance.new("UICorner")
	uICorner1.Name = "UICorner"
	uICorner1.Parent = container1

	box = Instance.new("Frame")
	box.Name = "Box"
	box.Active = true
	box.AnchorPoint = Vector2.new(0, 0.5)
	box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	box.BorderSizePixel = 0
	box.Position = UDim2.new(0, 5, 0.5, 0)
	box.Size = UDim2.new(1, -40, 0, 25)

	uICorner2 = Instance.new("UICorner")
	uICorner2.Name = "UICorner"
	uICorner2.Parent = box

	input = Instance.new("TextBox")
	input.Name = "Input"
	input.ClearTextOnFocus = false
	input.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	input.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
	input.PlaceholderText = "Click here or press '/' to chat."
	input.Text = ""
	input.TextColor3 = Color3.fromRGB(100, 100, 100)
	input.TextSize = 14
	input.TextWrapped = true
	input.TextXAlignment = Enum.TextXAlignment.Left
	input.TextYAlignment = Enum.TextYAlignment.Top
	input.AnchorPoint = Vector2.new(0, 0.5)
	input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	input.BackgroundTransparency = 1
	input.Position = UDim2.new(0, 5, 0.5, 0)
	input.Size = UDim2.new(1, -10, 0, 14)
	input.ZIndex = 2

	bar = Instance.new("TextLabel")
	bar.Name = "Bar"
	bar.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	bar.Text = ""
	bar.TextColor3 = Color3.fromRGB(100, 100, 100)
	bar.TextSize = 14
	bar.TextTransparency = 0.5
	bar.TextWrapped = true
	bar.TextXAlignment = Enum.TextXAlignment.Left
	bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bar.BackgroundTransparency = 1
	bar.BorderSizePixel = 0
	bar.Size = UDim2.fromScale(1, 1)
	bar.Parent = input

	input.Parent = box

	uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 8)
	uIPadding.PaddingTop = UDim.new(0, 8)
	uIPadding.Parent = box

	box.Parent = container1

	resize = Instance.new("TextButton")
	resize.Name = "Resize"
	resize.Text = ""
	resize.Active = false
	resize.AnchorPoint = Vector2.new(1, 0.5)
	resize.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
	resize.BorderSizePixel = 0
	resize.Position = UDim2.new(1, -5, 0, 17)
	resize.Selectable = false
	resize.Size = UDim2.fromOffset(25, 25)
	resize.Visible = false

	icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.Image = "rbxassetid://8571348189"
	icon.Active = true
	icon.AnchorPoint = Vector2.new(0.5, 0.5)
	icon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	icon.BackgroundTransparency = 1
	icon.BorderSizePixel = 0
	icon.Position = UDim2.fromScale(0.5, 0.5)
	icon.Selectable = true
	icon.Size = UDim2.fromScale(0.8, 0.8)

	uIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	uIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
	uIAspectRatioConstraint.Parent = icon

	icon.Parent = resize

	uICorner3 = Instance.new("UICorner")
	uICorner3.Name = "UICorner"
	uICorner3.Parent = resize

	resize.Parent = container1

	container2 = Instance.new("Frame")
	container2.Name = "Container"
	container2.Active = true
	container2.AnchorPoint = Vector2.new(0.5, 0.5)
	container2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	container2.BackgroundTransparency = 1
	container2.Position = UDim2.new(0.5, 0, 0, 17)
	container2.Selectable = true
	container2.Size = UDim2.new(1, -30, 0, 14)

	channel = Instance.new("TextButton")
	channel.Name = "Channel"
	channel.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	channel.Text = ""
	channel.TextColor3 = Color3.fromRGB(255, 255, 255)
	channel.TextSize = 15
	channel.TextWrapped = true
	channel.AnchorPoint = Vector2.new(0, 0.5)
	channel.BackgroundColor3 = Color3.fromRGB(253, 80, 111)
	channel.BorderSizePixel = 0
	channel.Position = UDim2.new(0, -7, 0.5, 0)
	channel.Size = UDim2.fromOffset(0, 20)
	channel.Visible = false

	label = Instance.new("TextLabel")
	label.Name = "Label"
	label.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	label.Text = "test"
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 14
	label.AnchorPoint = Vector2.new(0, 0.5)
	label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.Position = UDim2.new(0, 5, 0.5, 0)
	label.Size = UDim2.fromScale(1, 1)
	label.Parent = channel

	uICorner4 = Instance.new("UICorner")
	uICorner4.Name = "UICorner"
	uICorner4.Parent = channel

	replyIcon = Instance.new("ImageLabel")
	replyIcon.Name = "ReplyIcon"
	replyIcon.Image = "rbxassetid://8595302757"
	replyIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	replyIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	replyIcon.BackgroundTransparency = 1
	replyIcon.Position = UDim2.fromScale(0.5, 0.5)
	replyIcon.Size = UDim2.fromOffset(16, 16)
	replyIcon.Visible = false
	replyIcon.ZIndex = 5
	replyIcon.Parent = channel

	channel.Parent = container2

	container2.Parent = container1

	container1.Parent = main1

	autofill = Instance.new("Frame")
	autofill.Name = "Autofill"
	autofill.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	autofill.BackgroundTransparency = 0.75
	autofill.BorderSizePixel = 0
	autofill.Position = UDim2.new(0, 0, 1, 5)
	autofill.Size = UDim2.fromScale(1, 0)

	corner = Instance.new("UICorner")
	corner.Name = "Corner"
	corner.Parent = autofill

	container3 = Instance.new("Frame")
	container3.Name = "Container"
	container3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	container3.BackgroundTransparency = 1
	container3.Size = UDim2.fromScale(1, 1)

	scroller1 = Instance.new("ScrollingFrame")
	scroller1.Name = "Scroller"
	scroller1.BottomImage = "rbxassetid://8082116996"
	scroller1.CanvasSize = UDim2.new()
	scroller1.MidImage = "rbxassetid://7488333553"
	scroller1.ScrollBarThickness = 0
	scroller1.TopImage = "rbxassetid://8082122989"
	scroller1.Active = true
	scroller1.AnchorPoint = Vector2.new(0.5, 0)
	scroller1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scroller1.BackgroundTransparency = 1
	scroller1.BorderSizePixel = 0
	scroller1.Position = UDim2.new(0.5, 0, 0, 4)
	scroller1.Size = UDim2.new(1, -10, 1, 0)

	layout = Instance.new("UIListLayout")
	layout.Name = "Layout"
	layout.Padding = UDim.new(0, 2)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Parent = scroller1

	scroller1.Parent = container3

	container3.Parent = autofill

	autofill.Parent = main1

	main1.Parent = chatBarContainer

	chatBarContainer.Parent = container

	zone = Instance.new("Frame")
	zone.Name = "Zone"
	zone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	zone.BackgroundTransparency = 1
	zone.Size = UDim2.new(1, 0, 1, 5)
	zone.ZIndex = 3
	zone.Parent = container

	channelbar = Instance.new("Frame")
	channelbar.Name = "Channelbar"
	channelbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	channelbar.BackgroundTransparency = 1
	channelbar.BorderSizePixel = 0
	channelbar.ClipsDescendants = true
	channelbar.Size = UDim2.new(1, 0, 0, 35)
	channelbar.Visible = false

	main2 = Instance.new("Frame")
	main2.Name = "Main"
	main2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	main2.BackgroundTransparency = 1
	main2.BorderSizePixel = 0
	main2.Size = UDim2.fromScale(1, 1)

	container4 = Instance.new("Frame")
	container4.Name = "Container"
	container4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	container4.BackgroundTransparency = 0.75
	container4.BorderSizePixel = 0
	container4.Size = UDim2.fromScale(1, 1)

	uICorner5 = Instance.new("UICorner")
	uICorner5.Name = "UICorner"
	uICorner5.Parent = container4

	scroller2 = Instance.new("ScrollingFrame")
	scroller2.Name = "Scroller"
	scroller2.BottomImage = "rbxassetid://8082116996"
	scroller2.CanvasSize = UDim2.new()
	scroller2.MidImage = "rbxassetid://7488333553"
	scroller2.ScrollBarThickness = 0
	scroller2.TopImage = "rbxassetid://8082122989"
	scroller2.Active = true
	scroller2.AnchorPoint = Vector2.new(1, 0.5)
	scroller2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scroller2.BackgroundTransparency = 1
	scroller2.BorderSizePixel = 0
	scroller2.Position = UDim2.new(1, -5, 0.5, 0)
	scroller2.Size = UDim2.new(1, -10, 1, 0)

	uIListLayout1 = Instance.new("UIListLayout")
	uIListLayout1.Name = "UIListLayout"
	uIListLayout1.Padding = UDim.new(0, 5)
	uIListLayout1.FillDirection = Enum.FillDirection.Horizontal
	uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout1.VerticalAlignment = Enum.VerticalAlignment.Center
	uIListLayout1.Parent = scroller2

	scroller2.Parent = container4

	container4.Parent = main2

	main2.Parent = channelbar

	channelbar.Parent = container

	container.Parent = chat

	settings = Instance.new("Frame")
	settings.Name = "Settings"
	settings.AnchorPoint = Vector2.new(0.5, 0.5)
	settings.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	settings.BackgroundTransparency = 0.5
	settings.BorderSizePixel = 0
	settings.Position = UDim2.fromScale(0.5, -1.5)
	settings.Size = UDim2.fromOffset(325, 300)
	settings.ZIndex = 5

	uICorner6 = Instance.new("UICorner")
	uICorner6.Name = "UICorner"
	uICorner6.Parent = settings

	pages = Instance.new("Frame")
	pages.Name = "Pages"
	pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	pages.BackgroundTransparency = 1
	pages.ClipsDescendants = true
	pages.Size = UDim2.fromScale(1, 1)
	pages.ZIndex = 6

	navigation = Instance.new("Frame")
	navigation.Name = "Navigation"
	navigation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	navigation.BackgroundTransparency = 1
	navigation.Size = UDim2.fromScale(1, 1)
	navigation.ZIndex = 6

	credit = Instance.new("TextLabel")
	credit.Name = "Credit"
	credit.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	credit.Text = "Created by: Jumpathy"
	credit.TextColor3 = Color3.fromRGB(255, 255, 255)
	credit.TextSize = 14
	credit.AnchorPoint = Vector2.new(0, 1)
	credit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	credit.BackgroundTransparency = 1
	credit.BorderColor3 = Color3.fromRGB(0, 0, 0)
	credit.BorderSizePixel = 0
	credit.Position = UDim2.new(0, 0, 1, -5)
	credit.Size = UDim2.new(1, 0, 0, 30)
	credit.ZIndex = 5
	credit.Parent = navigation

	content = Instance.new("Frame")
	content.Name = "Content"
	content.AnchorPoint = Vector2.new(0.5, 1)
	content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	content.BackgroundTransparency = 1
	content.Position = UDim2.new(0.5, 0, 1, -10)
	content.Size = UDim2.new(1, -10, 1, -50)
	content.ZIndex = 6

	uIListLayout2 = Instance.new("UIListLayout")
	uIListLayout2.Name = "UIListLayout"
	uIListLayout2.Padding = UDim.new(0, 5)
	uIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout2.Parent = content

	uI = Instance.new("TextButton")
	uI.Name = "UI"
	uI.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	uI.Text = "UI"
	uI.TextColor3 = Color3.fromRGB(255, 255, 255)
	uI.TextSize = 20
	uI.TextWrapped = true
	uI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	uI.BackgroundTransparency = 0.3
	uI.BorderSizePixel = 0
	uI.Size = UDim2.new(1, 0, 0, 35)
	uI.ZIndex = 6

	uICorner7 = Instance.new("UICorner")
	uICorner7.Name = "UICorner"
	uICorner7.Parent = uI

	icon1 = Instance.new("ImageLabel")
	icon1.Name = "Icon"
	icon1.Image = "http://www.roblox.com/asset/?id=6035030081"
	icon1.AnchorPoint = Vector2.new(0, 0.5)
	icon1.BackgroundTransparency = 1
	icon1.BorderSizePixel = 0
	icon1.Position = UDim2.new(0, 5, 0.5, 0)
	icon1.Size = UDim2.fromOffset(25, 25)
	icon1.ZIndex = 7
	icon1.Parent = uI

	uI.Parent = content

	bubbleChat = Instance.new("TextButton")
	bubbleChat.Name = "BubbleChat"
	bubbleChat.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	bubbleChat.Text = "Bubble Chat"
	bubbleChat.TextColor3 = Color3.fromRGB(255, 255, 255)
	bubbleChat.TextSize = 20
	bubbleChat.TextWrapped = true
	bubbleChat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bubbleChat.BackgroundTransparency = 0.3
	bubbleChat.BorderSizePixel = 0
	bubbleChat.Position = UDim2.fromScale(0.0328, 0.044)
	bubbleChat.Size = UDim2.new(1, 0, 0, 35)
	bubbleChat.ZIndex = 6

	uICorner8 = Instance.new("UICorner")
	uICorner8.Name = "UICorner"
	uICorner8.Parent = bubbleChat

	icon2 = Instance.new("ImageLabel")
	icon2.Name = "Icon"
	icon2.Image = "rbxassetid://8678032944"
	icon2.AnchorPoint = Vector2.new(0, 0.5)
	icon2.BackgroundTransparency = 1
	icon2.BorderSizePixel = 0
	icon2.Position = UDim2.new(0, 5, 0.5, 0)
	icon2.Size = UDim2.fromOffset(25, 25)
	icon2.ZIndex = 7
	icon2.Parent = bubbleChat

	bubbleChat.Parent = content

	quickChat = Instance.new("TextButton")
	quickChat.Name = "QuickChat"
	quickChat.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	quickChat.Text = "Quick Chat"
	quickChat.TextColor3 = Color3.fromRGB(255, 255, 255)
	quickChat.TextSize = 20
	quickChat.TextWrapped = true
	quickChat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	quickChat.BackgroundTransparency = 0.3
	quickChat.BorderSizePixel = 0
	quickChat.LayoutOrder = 2
	quickChat.Size = UDim2.new(1, 0, 0, 35)
	quickChat.ZIndex = 6

	uICorner9 = Instance.new("UICorner")
	uICorner9.Name = "UICorner"
	uICorner9.Parent = quickChat

	icon3 = Instance.new("ImageLabel")
	icon3.Name = "Icon"
	icon3.Image = "rbxassetid://6031243319"
	icon3.AnchorPoint = Vector2.new(0, 0.5)
	icon3.BackgroundTransparency = 1
	icon3.BorderSizePixel = 0
	icon3.Position = UDim2.new(0, 5, 0.5, 0)
	icon3.Size = UDim2.fromOffset(25, 25)
	icon3.ZIndex = 7
	icon3.Parent = quickChat

	quickChat.Parent = content

	help = Instance.new("TextButton")
	help.Name = "Help"
	help.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	help.Text = "Help"
	help.TextColor3 = Color3.fromRGB(255, 255, 255)
	help.TextSize = 20
	help.TextWrapped = true
	help.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	help.BackgroundTransparency = 0.3
	help.BorderSizePixel = 0
	help.LayoutOrder = 3
	help.Size = UDim2.new(1, 0, 0, 35)
	help.ZIndex = 6

	uICorner10 = Instance.new("UICorner")
	uICorner10.Name = "UICorner"
	uICorner10.Parent = help

	icon4 = Instance.new("ImageLabel")
	icon4.Name = "Icon"
	icon4.Image = "http://www.roblox.com/asset/?id=6026568192"
	icon4.AnchorPoint = Vector2.new(0, 0.5)
	icon4.BackgroundTransparency = 1
	icon4.BorderSizePixel = 0
	icon4.Position = UDim2.new(0, 5, 0.5, 0)
	icon4.Size = UDim2.fromOffset(25, 25)
	icon4.ZIndex = 7
	icon4.Parent = help

	help.Parent = content

	content.Parent = navigation

	title = Instance.new("TextLabel")
	title.Name = "Title"
	title.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	title.Text = "BetterChat Settings"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 20
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1
	title.Position = UDim2.fromOffset(0, 5)
	title.Size = UDim2.new(1, 0, 0, 30)
	title.ZIndex = 6

	close = Instance.new("TextButton")
	close.Name = "Close"
	close.Text = ""
	close.AnchorPoint = Vector2.new(1, 0.5)
	close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	close.BackgroundTransparency = 0.3
	close.BorderSizePixel = 0
	close.Position = UDim2.new(1, -5, 0.5, 0)
	close.Size = UDim2.fromOffset(30, 30)
	close.ZIndex = 8

	uICorner11 = Instance.new("UICorner")
	uICorner11.Name = "UICorner"
	uICorner11.Parent = close

	icon5 = Instance.new("ImageLabel")
	icon5.Name = "Icon"
	icon5.Image = "http://www.roblox.com/asset/?id=6031094678"
	icon5.AnchorPoint = Vector2.new(0.5, 0.5)
	icon5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	icon5.BackgroundTransparency = 1
	icon5.BorderSizePixel = 0
	icon5.Position = UDim2.fromScale(0.5, 0.5)
	icon5.Selectable = true
	icon5.Size = UDim2.fromOffset(25, 25)
	icon5.ZIndex = 8
	icon5.Parent = close

	close.Parent = title

	title.Parent = navigation

	navigation.Parent = pages

	uI1 = Instance.new("Frame")
	uI1.Name = "UI"
	uI1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	uI1.BackgroundTransparency = 1
	uI1.Position = UDim2.fromScale(1, 0)
	uI1.Size = UDim2.fromScale(1, 1)
	uI1.ZIndex = 6

	title1 = Instance.new("TextLabel")
	title1.Name = "Title"
	title1.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	title1.Text = "UI Settings"
	title1.TextColor3 = Color3.fromRGB(255, 255, 255)
	title1.TextSize = 20
	title1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title1.BackgroundTransparency = 1
	title1.Position = UDim2.fromOffset(0, 5)
	title1.Size = UDim2.new(1, 0, 0, 30)
	title1.ZIndex = 6

	back = Instance.new("TextButton")
	back.Name = "Back"
	back.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	back.Text = ""
	back.TextColor3 = Color3.fromRGB(0, 0, 0)
	back.TextSize = 14
	back.AnchorPoint = Vector2.new(0, 0.5)
	back.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	back.Position = UDim2.new(0, 5, 0.5, 0)
	back.Size = UDim2.fromOffset(25, 25)
	back.ZIndex = 6

	imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "ImageLabel"
	imageLabel.Image = "rbxassetid://8677511725"
	imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Position = UDim2.fromScale(0.5, 0.5)
	imageLabel.Size = UDim2.fromScale(0.85, 0.85)
	imageLabel.ZIndex = 6
	imageLabel.Parent = back

	uICorner12 = Instance.new("UICorner")
	uICorner12.Name = "UICorner"
	uICorner12.Parent = back

	back.Parent = title1

	title1.Parent = uI1

	scroller3 = Instance.new("ScrollingFrame")
	scroller3.Name = "Scroller"
	scroller3.BottomImage = "rbxassetid://8082116996"
	scroller3.CanvasSize = UDim2.new()
	scroller3.MidImage = "rbxassetid://7488333553"
	scroller3.ScrollBarThickness = 5
	scroller3.TopImage = "rbxassetid://8082122989"
	scroller3.AnchorPoint = Vector2.new(0.5, 1)
	scroller3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scroller3.BackgroundTransparency = 1
	scroller3.BorderSizePixel = 0
	scroller3.Position = UDim2.new(0.5, 0, 1, -10)
	scroller3.Selectable = false
	scroller3.Size = UDim2.new(1, -10, 1, -50)
	scroller3.ZIndex = 6

	uIListLayout3 = Instance.new("UIListLayout")
	uIListLayout3.Name = "UIListLayout"
	uIListLayout3.Padding = UDim.new(0, 5)
	uIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout3.Parent = scroller3

	textSize = Instance.new("Frame")
	textSize.Name = "TextSize"
	textSize.Active = true
	textSize.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textSize.BackgroundTransparency = 0.5
	textSize.BorderSizePixel = 0
	textSize.Position = UDim2.fromScale(0.0328, 0.044)
	textSize.Selectable = true
	textSize.Size = UDim2.new(1, -10, 0, 55)
	textSize.ZIndex = 6

	center = Instance.new("Frame")
	center.Name = "Center"
	center.AnchorPoint = Vector2.new(0, 0.5)
	center.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	center.BackgroundTransparency = 1
	center.Position = UDim2.fromScale(0, 0.5)
	center.Size = UDim2.fromScale(1, 0.75)
	center.ZIndex = 6

	title2 = Instance.new("Frame")
	title2.Name = "Title"
	title2.AnchorPoint = Vector2.new(0.5, 0)
	title2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title2.BackgroundTransparency = 1
	title2.BorderSizePixel = 0
	title2.Position = UDim2.fromScale(0.5, 0)
	title2.Size = UDim2.new(0.95, 0, 0, 20)
	title2.ZIndex = 6

	icon6 = Instance.new("ImageLabel")
	icon6.Name = "Icon"
	icon6.Image = "rbxassetid://8677222862"
	icon6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon6.BackgroundTransparency = 1
	icon6.Size = UDim2.fromOffset(20, 20)
	icon6.ZIndex = 6
	icon6.Parent = title2

	label1 = Instance.new("TextLabel")
	label1.Name = "Label"
	label1.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label1.Text = "Text Size"
	label1.TextColor3 = Color3.fromRGB(255, 255, 255)
	label1.TextSize = 14
	label1.TextXAlignment = Enum.TextXAlignment.Left
	label1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label1.BackgroundTransparency = 1
	label1.Position = UDim2.fromOffset(25, 0)
	label1.Size = UDim2.new(0.5, 0, 0, 18)
	label1.ZIndex = 6
	label1.Parent = title2

	title2.Parent = center

	actual = Instance.new("Frame")
	actual.Name = "Actual"
	actual.AnchorPoint = Vector2.new(0.5, 1)
	actual.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	actual.BackgroundTransparency = 1
	actual.Position = UDim2.new(0.5, 0, 1, 5)
	actual.Size = UDim2.new(0.95, 0, 0, 25)
	actual.ZIndex = 6

	amount = Instance.new("TextBox")
	amount.Name = "Amount"
	amount.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	amount.PlaceholderColor3 = Color3.fromRGB(220, 220, 220)
	amount.PlaceholderText = "%"
	amount.Text = "_"
	amount.TextColor3 = Color3.fromRGB(255, 255, 255)
	amount.TextSize = 14
	amount.AnchorPoint = Vector2.new(1, 0.5)
	amount.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	amount.BackgroundTransparency = 0.5
	amount.BorderSizePixel = 0
	amount.Position = UDim2.fromScale(1, 0.5)
	amount.Size = UDim2.new(0.125, 0, 0, 20)
	amount.ZIndex = 6

	uICorner13 = Instance.new("UICorner")
	uICorner13.Name = "UICorner"
	uICorner13.Parent = amount

	uIPadding1 = Instance.new("UIPadding")
	uIPadding1.Name = "UIPadding"
	uIPadding1.PaddingLeft = UDim.new(0, 5)
	uIPadding1.PaddingRight = UDim.new(0, 5)
	uIPadding1.Parent = amount

	amount.Parent = actual

	bar1 = Instance.new("Frame")
	bar1.Name = "Bar"
	bar1.AnchorPoint = Vector2.new(0, 0.5)
	bar1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bar1.BorderSizePixel = 0
	bar1.Position = UDim2.fromScale(0, 0.5)
	bar1.Size = UDim2.new(0.85, 0, 0, 10)
	bar1.ZIndex = 6

	ignore = Instance.new("UICorner")
	ignore.Name = "Ignore"
	ignore.CornerRadius = UDim.new(1, 0)
	ignore.Parent = bar1

	button = Instance.new("TextButton")
	button.Name = "Button"
	button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	button.Text = ""
	button.TextColor3 = Color3.fromRGB(0, 0, 0)
	button.TextSize = 14
	button.AnchorPoint = Vector2.new(0.5, 0.5)
	button.BackgroundColor3 = Color3.fromRGB(30, 200, 150)
	button.BorderSizePixel = 0
	button.Position = UDim2.new(0, 10, 0.5, 0)
	button.Size = UDim2.fromOffset(20, 20)
	button.ZIndex = 7

	ignore1 = Instance.new("UICorner")
	ignore1.Name = "Ignore"
	ignore1.CornerRadius = UDim.new(1, 0)
	ignore1.Parent = button

	button.Parent = bar1

	progress = Instance.new("Frame")
	progress.Name = "Progress"
	progress.BackgroundColor3 = Color3.fromRGB(25, 170, 127)
	progress.BorderSizePixel = 0
	progress.Size = UDim2.fromScale(0, 1)
	progress.ZIndex = 6

	ignore2 = Instance.new("UICorner")
	ignore2.Name = "Ignore"
	ignore2.CornerRadius = UDim.new(1, 0)
	ignore2.Parent = progress

	progress.Parent = bar1

	bar1.Parent = actual

	actual.Parent = center

	center.Parent = textSize

	uICorner14 = Instance.new("UICorner")
	uICorner14.Name = "UICorner"
	uICorner14.Parent = textSize

	textSize.Parent = scroller3

	roundness = Instance.new("Frame")
	roundness.Name = "Roundness"
	roundness.Active = true
	roundness.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	roundness.BackgroundTransparency = 0.5
	roundness.BorderSizePixel = 0
	roundness.Position = UDim2.fromScale(0.0328, 0.044)
	roundness.Selectable = true
	roundness.Size = UDim2.new(1, -10, 0, 55)
	roundness.ZIndex = 6

	center1 = Instance.new("Frame")
	center1.Name = "Center"
	center1.AnchorPoint = Vector2.new(0, 0.5)
	center1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	center1.BackgroundTransparency = 1
	center1.Position = UDim2.fromScale(0, 0.5)
	center1.Size = UDim2.fromScale(1, 0.75)
	center1.ZIndex = 6

	title3 = Instance.new("Frame")
	title3.Name = "Title"
	title3.AnchorPoint = Vector2.new(0.5, 0)
	title3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title3.BackgroundTransparency = 1
	title3.BorderSizePixel = 0
	title3.Position = UDim2.fromScale(0.5, 0)
	title3.Size = UDim2.new(0.95, 0, 0, 20)
	title3.ZIndex = 6

	icon7 = Instance.new("ImageLabel")
	icon7.Name = "Icon"
	icon7.Image = "rbxassetid://8677280864"
	icon7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon7.BackgroundTransparency = 1
	icon7.Size = UDim2.fromOffset(20, 20)
	icon7.ZIndex = 6
	icon7.Parent = title3

	label2 = Instance.new("TextLabel")
	label2.Name = "Label"
	label2.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label2.Text = "Roundness"
	label2.TextColor3 = Color3.fromRGB(255, 255, 255)
	label2.TextSize = 14
	label2.TextXAlignment = Enum.TextXAlignment.Left
	label2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label2.BackgroundTransparency = 1
	label2.Position = UDim2.fromOffset(25, 0)
	label2.Size = UDim2.new(0.5, 0, 0, 18)
	label2.ZIndex = 6
	label2.Parent = title3

	title3.Parent = center1

	actual1 = Instance.new("Frame")
	actual1.Name = "Actual"
	actual1.AnchorPoint = Vector2.new(0.5, 1)
	actual1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	actual1.BackgroundTransparency = 1
	actual1.Position = UDim2.new(0.5, 0, 1, 5)
	actual1.Size = UDim2.new(0.95, 0, 0, 25)
	actual1.ZIndex = 6

	amount1 = Instance.new("TextBox")
	amount1.Name = "Amount"
	amount1.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	amount1.PlaceholderColor3 = Color3.fromRGB(220, 220, 220)
	amount1.PlaceholderText = "%"
	amount1.Text = "_"
	amount1.TextColor3 = Color3.fromRGB(255, 255, 255)
	amount1.TextSize = 14
	amount1.AnchorPoint = Vector2.new(1, 0.5)
	amount1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	amount1.BackgroundTransparency = 0.5
	amount1.BorderSizePixel = 0
	amount1.Position = UDim2.fromScale(1, 0.5)
	amount1.Size = UDim2.new(0.125, 0, 0, 20)
	amount1.ZIndex = 6

	uICorner15 = Instance.new("UICorner")
	uICorner15.Name = "UICorner"
	uICorner15.Parent = amount1

	uIPadding2 = Instance.new("UIPadding")
	uIPadding2.Name = "UIPadding"
	uIPadding2.PaddingLeft = UDim.new(0, 5)
	uIPadding2.PaddingRight = UDim.new(0, 5)
	uIPadding2.Parent = amount1

	amount1.Parent = actual1

	bar2 = Instance.new("Frame")
	bar2.Name = "Bar"
	bar2.AnchorPoint = Vector2.new(0, 0.5)
	bar2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bar2.BorderSizePixel = 0
	bar2.Position = UDim2.fromScale(0, 0.5)
	bar2.Size = UDim2.new(0.85, 0, 0, 10)
	bar2.ZIndex = 6

	ignore3 = Instance.new("UICorner")
	ignore3.Name = "Ignore"
	ignore3.CornerRadius = UDim.new(1, 0)
	ignore3.Parent = bar2

	button1 = Instance.new("TextButton")
	button1.Name = "Button"
	button1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	button1.Text = ""
	button1.TextColor3 = Color3.fromRGB(0, 0, 0)
	button1.TextSize = 14
	button1.AnchorPoint = Vector2.new(0.5, 0.5)
	button1.BackgroundColor3 = Color3.fromRGB(30, 200, 150)
	button1.BorderSizePixel = 0
	button1.Position = UDim2.new(0, 10, 0.5, 0)
	button1.Size = UDim2.fromOffset(20, 20)
	button1.ZIndex = 7

	ignore4 = Instance.new("UICorner")
	ignore4.Name = "Ignore"
	ignore4.CornerRadius = UDim.new(1, 0)
	ignore4.Parent = button1

	button1.Parent = bar2

	progress1 = Instance.new("Frame")
	progress1.Name = "Progress"
	progress1.BackgroundColor3 = Color3.fromRGB(25, 170, 127)
	progress1.BorderSizePixel = 0
	progress1.Size = UDim2.fromScale(0, 1)
	progress1.ZIndex = 6

	ignore5 = Instance.new("UICorner")
	ignore5.Name = "Ignore"
	ignore5.CornerRadius = UDim.new(1, 0)
	ignore5.Parent = progress1

	progress1.Parent = bar2

	bar2.Parent = actual1

	actual1.Parent = center1

	center1.Parent = roundness

	uICorner16 = Instance.new("UICorner")
	uICorner16.Name = "UICorner"
	uICorner16.Parent = roundness

	roundness.Parent = scroller3

	resizable = Instance.new("Frame")
	resizable.Name = "Resizable"
	resizable.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	resizable.BackgroundTransparency = 0.5
	resizable.Size = UDim2.new(1, -10, 0, 30)
	resizable.ZIndex = 6

	title4 = Instance.new("Frame")
	title4.Name = "Title"
	title4.AnchorPoint = Vector2.new(0.5, 0.5)
	title4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title4.BackgroundTransparency = 1
	title4.BorderSizePixel = 0
	title4.Position = UDim2.fromScale(0.5, 0.5)
	title4.Size = UDim2.new(0.95, 0, 0, 20)
	title4.ZIndex = 6

	icon8 = Instance.new("ImageLabel")
	icon8.Name = "Icon"
	icon8.Image = "rbxassetid://8571348189"
	icon8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon8.BackgroundTransparency = 1
	icon8.Size = UDim2.fromOffset(20, 20)
	icon8.ZIndex = 6
	icon8.Parent = title4

	label3 = Instance.new("TextLabel")
	label3.Name = "Label"
	label3.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label3.Text = "Resizable"
	label3.TextColor3 = Color3.fromRGB(255, 255, 255)
	label3.TextSize = 14
	label3.TextXAlignment = Enum.TextXAlignment.Left
	label3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label3.BackgroundTransparency = 1
	label3.Position = UDim2.fromOffset(25, 0)
	label3.Size = UDim2.new(0.5, 0, 0, 18)
	label3.ZIndex = 6
	label3.Parent = title4

	title4.Parent = resizable

	uICorner17 = Instance.new("UICorner")
	uICorner17.Name = "UICorner"
	uICorner17.Parent = resizable

	toggle = Instance.new("Frame")
	toggle.Name = "Toggle"
	toggle.AnchorPoint = Vector2.new(1, 0.5)
	toggle.BackgroundColor3 = Color3.fromRGB(72, 175, 240)
	toggle.BorderSizePixel = 0
	toggle.Position = UDim2.new(1, -5, 0.5, 0)
	toggle.Size = UDim2.fromOffset(40, 18)
	toggle.ZIndex = 6

	ignore6 = Instance.new("UICorner")
	ignore6.Name = "Ignore"
	ignore6.CornerRadius = UDim.new(1, 0)
	ignore6.Parent = toggle

	zone1 = Instance.new("TextButton")
	zone1.Name = "Zone"
	zone1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	zone1.Text = ""
	zone1.TextColor3 = Color3.fromRGB(0, 0, 0)
	zone1.TextSize = 14
	zone1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	zone1.BackgroundTransparency = 1
	zone1.Size = UDim2.fromScale(1, 1)
	zone1.ZIndex = 8

	ignore7 = Instance.new("UICorner")
	ignore7.Name = "Ignore"
	ignore7.CornerRadius = UDim.new(1, 0)
	ignore7.Parent = zone1

	zone1.Parent = toggle

	rounded = Instance.new("Frame")
	rounded.Name = "Rounded"
	rounded.AnchorPoint = Vector2.new(1, 0.5)
	rounded.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	rounded.Position = UDim2.new(1, -3, 0.5, 0)
	rounded.Size = UDim2.fromOffset(14, 14)
	rounded.ZIndex = 6

	ignore8 = Instance.new("UICorner")
	ignore8.Name = "Ignore"
	ignore8.CornerRadius = UDim.new(1, 0)
	ignore8.Parent = rounded

	rounded.Parent = toggle

	toggle.Parent = resizable

	resizable.Parent = scroller3

	textFont = Instance.new("Frame")
	textFont.Name = "TextFont"
	textFont.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textFont.BackgroundTransparency = 1
	textFont.ClipsDescendants = true
	textFont.LayoutOrder = 1
	textFont.Size = UDim2.new(1, -10, 0, 30)
	textFont.ZIndex = 6

	title5 = Instance.new("Frame")
	title5.Name = "Title"
	title5.AnchorPoint = Vector2.new(0.5, 0.5)
	title5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title5.BackgroundTransparency = 1
	title5.BorderSizePixel = 0
	title5.Position = UDim2.new(0.5, 0, 0, 15)
	title5.Size = UDim2.new(0.95, 0, 0, 20)
	title5.ZIndex = 8

	icon9 = Instance.new("ImageLabel")
	icon9.Name = "Icon"
	icon9.Image = "rbxassetid://8678012976"
	icon9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon9.BackgroundTransparency = 1
	icon9.Size = UDim2.fromOffset(20, 20)
	icon9.ZIndex = 9
	icon9.Parent = title5

	label4 = Instance.new("TextLabel")
	label4.Name = "Label"
	label4.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label4.Text = "Text Font"
	label4.TextColor3 = Color3.fromRGB(255, 255, 255)
	label4.TextSize = 14
	label4.TextXAlignment = Enum.TextXAlignment.Left
	label4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label4.BackgroundTransparency = 1
	label4.Position = UDim2.fromOffset(25, 0)
	label4.Size = UDim2.fromOffset(0, 18)
	label4.ZIndex = 9
	label4.Parent = title5

	drop = Instance.new("TextButton")
	drop.Name = "Drop"
	drop.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	drop.Text = ""
	drop.TextColor3 = Color3.fromRGB(0, 0, 0)
	drop.TextSize = 14
	drop.AnchorPoint = Vector2.new(1, 0)
	drop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	drop.BorderSizePixel = 0
	drop.Position = UDim2.fromScale(1, 0)
	drop.Size = UDim2.fromOffset(30, 20)
	drop.ZIndex = 9

	uICorner18 = Instance.new("UICorner")
	uICorner18.Name = "UICorner"
	uICorner18.Parent = drop

	icon10 = Instance.new("ImageLabel")
	icon10.Name = "Icon"
	icon10.Image = "rbxassetid://8677555693"
	icon10.AnchorPoint = Vector2.new(0.5, 0.5)
	icon10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon10.BackgroundTransparency = 1
	icon10.Position = UDim2.fromScale(0.5, 0.5)
	icon10.Size = UDim2.fromOffset(25, 25)
	icon10.ZIndex = 10
	icon10.Parent = drop

	drop.Parent = title5

	selected = Instance.new("TextLabel")
	selected.Name = "Selected"
	selected.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	selected.Text = "GothamMedium"
	selected.TextColor3 = Color3.fromRGB(200, 200, 200)
	selected.TextSize = 14
	selected.TextXAlignment = Enum.TextXAlignment.Right
	selected.AnchorPoint = Vector2.new(1, 0.5)
	selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	selected.BackgroundTransparency = 1
	selected.Position = UDim2.new(1, -35, 0.5, 0)
	selected.Size = UDim2.fromOffset(0, 18)
	selected.ZIndex = 9
	selected.Parent = title5

	title5.Parent = textFont

	topContainer = Instance.new("Frame")
	topContainer.Name = "TopContainer"
	topContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	topContainer.BackgroundTransparency = 1
	topContainer.LayoutOrder = 2
	topContainer.Size = UDim2.new(1, 0, 0, 25)
	topContainer.ZIndex = 6

	background = Instance.new("Frame")
	background.Name = "Background"
	background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	background.BackgroundTransparency = 1
	background.LayoutOrder = 2
	background.Size = UDim2.new(1, 0, 0, 25)
	background.ZIndex = 6

	main3 = Instance.new("Frame")
	main3.Name = "Main"
	main3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	main3.BackgroundTransparency = 0.5
	main3.LayoutOrder = 2
	main3.Size = UDim2.new(1, 0, 0, 30)
	main3.ZIndex = 6

	uICorner19 = Instance.new("UICorner")
	uICorner19.Name = "UICorner"
	uICorner19.Parent = main3

	main3.Parent = background

	background.Parent = topContainer

	flat = Instance.new("Frame")
	flat.Name = "Flat"
	flat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	flat.BackgroundTransparency = 0.5
	flat.BorderSizePixel = 0
	flat.Position = UDim2.fromOffset(0, 25)
	flat.Size = UDim2.new(1, 0, 0, 5)
	flat.Visible = false
	flat.ZIndex = 6
	flat.Parent = topContainer

	topContainer.Parent = textFont

	dropdown = Instance.new("Frame")
	dropdown.Name = "Dropdown"
	dropdown.AutomaticSize = Enum.AutomaticSize.Y
	dropdown.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	dropdown.BackgroundTransparency = 1
	dropdown.BorderSizePixel = 0
	dropdown.ClipsDescendants = true
	dropdown.Position = UDim2.fromOffset(0, 30)
	dropdown.Size = UDim2.fromScale(1, 0)
	dropdown.ZIndex = 6

	bottomContainer = Instance.new("Frame")
	bottomContainer.Name = "BottomContainer"
	bottomContainer.AnchorPoint = Vector2.new(0, 1)
	bottomContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bottomContainer.BackgroundTransparency = 1
	bottomContainer.BorderSizePixel = 0
	bottomContainer.ClipsDescendants = true
	bottomContainer.Position = UDim2.new(0, 0, 2, -20)
	bottomContainer.Size = UDim2.fromScale(1, 1)
	bottomContainer.ZIndex = 6

	rounded1 = Instance.new("Frame")
	rounded1.Name = "Rounded"
	rounded1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	rounded1.BackgroundTransparency = 0.35
	rounded1.Position = UDim2.fromOffset(0, -30)
	rounded1.Size = UDim2.new(1, 0, 0, 50)
	rounded1.ZIndex = 6

	uICorner20 = Instance.new("UICorner")
	uICorner20.Name = "UICorner"
	uICorner20.Parent = rounded1

	rounded1.Parent = bottomContainer

	bottomContainer.Parent = dropdown

	options = Instance.new("Frame")
	options.Name = "Options"
	options.AutomaticSize = Enum.AutomaticSize.Y
	options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	options.BackgroundTransparency = 1
	options.Size = UDim2.fromScale(1, 0)
	options.ZIndex = 6

	uIListLayout4 = Instance.new("UIListLayout")
	uIListLayout4.Name = "UIListLayout"
	uIListLayout4.Padding = UDim.new(0, 3)
	uIListLayout4.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout4.Parent = options

	options.Parent = dropdown

	uIPadding3 = Instance.new("UIPadding")
	uIPadding3.Name = "UIPadding"
	uIPadding3.PaddingBottom = UDim.new(0, 55)
	uIPadding3.Parent = dropdown

	frame = Instance.new("Frame")
	frame.Name = "Frame"
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BackgroundTransparency = 0.35
	frame.BorderSizePixel = 0
	frame.Size = UDim2.new(1, 0, 1, -20)
	frame.ZIndex = 6
	frame.Parent = dropdown

	dropdown.Parent = textFont

	textFont.Parent = scroller3

	scroller3.Parent = uI1

	uI1.Parent = pages

	bubbleChat1 = Instance.new("Frame")
	bubbleChat1.Name = "BubbleChat"
	bubbleChat1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bubbleChat1.BackgroundTransparency = 1
	bubbleChat1.Position = UDim2.fromScale(1, 0)
	bubbleChat1.Size = UDim2.fromScale(1, 1)
	bubbleChat1.ZIndex = 6

	title6 = Instance.new("TextLabel")
	title6.Name = "Title"
	title6.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	title6.Text = "Bubble Chat"
	title6.TextColor3 = Color3.fromRGB(255, 255, 255)
	title6.TextSize = 20
	title6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title6.BackgroundTransparency = 1
	title6.Position = UDim2.fromOffset(0, 5)
	title6.Size = UDim2.new(1, 0, 0, 30)
	title6.ZIndex = 6

	back1 = Instance.new("TextButton")
	back1.Name = "Back"
	back1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	back1.Text = ""
	back1.TextColor3 = Color3.fromRGB(0, 0, 0)
	back1.TextSize = 14
	back1.AnchorPoint = Vector2.new(0, 0.5)
	back1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	back1.Position = UDim2.new(0, 5, 0.5, 0)
	back1.Size = UDim2.fromOffset(25, 25)
	back1.ZIndex = 6

	imageLabel1 = Instance.new("ImageLabel")
	imageLabel1.Name = "ImageLabel"
	imageLabel1.Image = "rbxassetid://8677511725"
	imageLabel1.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	imageLabel1.BackgroundTransparency = 1
	imageLabel1.Position = UDim2.fromScale(0.5, 0.5)
	imageLabel1.Size = UDim2.fromScale(0.85, 0.85)
	imageLabel1.ZIndex = 6
	imageLabel1.Parent = back1

	uICorner21 = Instance.new("UICorner")
	uICorner21.Name = "UICorner"
	uICorner21.Parent = back1

	back1.Parent = title6

	title6.Parent = bubbleChat1

	scroller4 = Instance.new("ScrollingFrame")
	scroller4.Name = "Scroller"
	scroller4.BottomImage = "rbxassetid://8082116996"
	scroller4.CanvasSize = UDim2.new()
	scroller4.MidImage = "rbxassetid://7488333553"
	scroller4.ScrollBarThickness = 5
	scroller4.TopImage = "rbxassetid://8082122989"
	scroller4.AnchorPoint = Vector2.new(0.5, 1)
	scroller4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scroller4.BackgroundTransparency = 1
	scroller4.BorderSizePixel = 0
	scroller4.Position = UDim2.new(0.5, 0, 1, -10)
	scroller4.Selectable = false
	scroller4.Size = UDim2.new(1, -10, 1, -50)
	scroller4.ZIndex = 6

	uIListLayout5 = Instance.new("UIListLayout")
	uIListLayout5.Name = "UIListLayout"
	uIListLayout5.Padding = UDim.new(0, 5)
	uIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout5.Parent = scroller4

	animationStyle = Instance.new("Frame")
	animationStyle.Name = "AnimationStyle"
	animationStyle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	animationStyle.BackgroundTransparency = 1
	animationStyle.ClipsDescendants = true
	animationStyle.Size = UDim2.new(1, -10, 0, 30)
	animationStyle.ZIndex = 6

	title7 = Instance.new("Frame")
	title7.Name = "Title"
	title7.AnchorPoint = Vector2.new(0.5, 0.5)
	title7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title7.BackgroundTransparency = 1
	title7.BorderSizePixel = 0
	title7.Position = UDim2.new(0.5, 0, 0, 15)
	title7.Size = UDim2.new(0.95, 0, 0, 20)
	title7.ZIndex = 8

	icon11 = Instance.new("ImageLabel")
	icon11.Name = "Icon"
	icon11.Image = "rbxassetid://8677960616"
	icon11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon11.BackgroundTransparency = 1
	icon11.Size = UDim2.fromOffset(20, 20)
	icon11.ZIndex = 9
	icon11.Parent = title7

	label5 = Instance.new("TextLabel")
	label5.Name = "Label"
	label5.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label5.Text = "Animation Style"
	label5.TextColor3 = Color3.fromRGB(255, 255, 255)
	label5.TextSize = 14
	label5.TextXAlignment = Enum.TextXAlignment.Left
	label5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label5.BackgroundTransparency = 1
	label5.Position = UDim2.fromOffset(25, 0)
	label5.Size = UDim2.fromOffset(0, 18)
	label5.ZIndex = 9
	label5.Parent = title7

	drop1 = Instance.new("TextButton")
	drop1.Name = "Drop"
	drop1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	drop1.Text = ""
	drop1.TextColor3 = Color3.fromRGB(0, 0, 0)
	drop1.TextSize = 14
	drop1.AnchorPoint = Vector2.new(1, 0)
	drop1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	drop1.BorderSizePixel = 0
	drop1.Position = UDim2.fromScale(1, 0)
	drop1.Size = UDim2.fromOffset(30, 20)
	drop1.ZIndex = 9

	uICorner22 = Instance.new("UICorner")
	uICorner22.Name = "UICorner"
	uICorner22.Parent = drop1

	icon12 = Instance.new("ImageLabel")
	icon12.Name = "Icon"
	icon12.Image = "rbxassetid://8677555693"
	icon12.AnchorPoint = Vector2.new(0.5, 0.5)
	icon12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon12.BackgroundTransparency = 1
	icon12.Position = UDim2.fromScale(0.5, 0.5)
	icon12.Size = UDim2.fromOffset(25, 25)
	icon12.ZIndex = 10
	icon12.Parent = drop1

	drop1.Parent = title7

	selected1 = Instance.new("TextLabel")
	selected1.Name = "Selected"
	selected1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	selected1.Text = "Linear"
	selected1.TextColor3 = Color3.fromRGB(200, 200, 200)
	selected1.TextSize = 14
	selected1.TextXAlignment = Enum.TextXAlignment.Right
	selected1.AnchorPoint = Vector2.new(1, 0.5)
	selected1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	selected1.BackgroundTransparency = 1
	selected1.Position = UDim2.new(1, -35, 0.5, 0)
	selected1.Size = UDim2.fromOffset(0, 18)
	selected1.ZIndex = 9
	selected1.Parent = title7

	title7.Parent = animationStyle

	topContainer1 = Instance.new("Frame")
	topContainer1.Name = "TopContainer"
	topContainer1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	topContainer1.BackgroundTransparency = 1
	topContainer1.LayoutOrder = 2
	topContainer1.Size = UDim2.new(1, 0, 0, 25)
	topContainer1.ZIndex = 6

	background1 = Instance.new("Frame")
	background1.Name = "Background"
	background1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	background1.BackgroundTransparency = 1
	background1.LayoutOrder = 2
	background1.Size = UDim2.new(1, 0, 0, 25)
	background1.ZIndex = 6

	main4 = Instance.new("Frame")
	main4.Name = "Main"
	main4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	main4.BackgroundTransparency = 0.5
	main4.LayoutOrder = 2
	main4.Size = UDim2.new(1, 0, 0, 30)
	main4.ZIndex = 6

	uICorner23 = Instance.new("UICorner")
	uICorner23.Name = "UICorner"
	uICorner23.Parent = main4

	main4.Parent = background1

	background1.Parent = topContainer1

	flat1 = Instance.new("Frame")
	flat1.Name = "Flat"
	flat1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	flat1.BackgroundTransparency = 0.5
	flat1.BorderSizePixel = 0
	flat1.Position = UDim2.fromOffset(0, 25)
	flat1.Size = UDim2.new(1, 0, 0, 5)
	flat1.Visible = false
	flat1.ZIndex = 6
	flat1.Parent = topContainer1

	topContainer1.Parent = animationStyle

	dropdown1 = Instance.new("Frame")
	dropdown1.Name = "Dropdown"
	dropdown1.AutomaticSize = Enum.AutomaticSize.Y
	dropdown1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	dropdown1.BackgroundTransparency = 1
	dropdown1.BorderSizePixel = 0
	dropdown1.ClipsDescendants = true
	dropdown1.Position = UDim2.fromOffset(0, 30)
	dropdown1.Size = UDim2.fromScale(1, 0)
	dropdown1.ZIndex = 6

	bottomContainer1 = Instance.new("Frame")
	bottomContainer1.Name = "BottomContainer"
	bottomContainer1.AnchorPoint = Vector2.new(0, 1)
	bottomContainer1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bottomContainer1.BackgroundTransparency = 1
	bottomContainer1.BorderSizePixel = 0
	bottomContainer1.ClipsDescendants = true
	bottomContainer1.Position = UDim2.new(0, 0, 2, -20)
	bottomContainer1.Size = UDim2.fromScale(1, 1)
	bottomContainer1.ZIndex = 6

	rounded2 = Instance.new("Frame")
	rounded2.Name = "Rounded"
	rounded2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	rounded2.BackgroundTransparency = 0.35
	rounded2.Position = UDim2.fromOffset(0, -30)
	rounded2.Size = UDim2.new(1, 0, 0, 50)
	rounded2.ZIndex = 6

	uICorner24 = Instance.new("UICorner")
	uICorner24.Name = "UICorner"
	uICorner24.Parent = rounded2

	rounded2.Parent = bottomContainer1

	bottomContainer1.Parent = dropdown1

	options1 = Instance.new("Frame")
	options1.Name = "Options"
	options1.AutomaticSize = Enum.AutomaticSize.Y
	options1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	options1.BackgroundTransparency = 1
	options1.Size = UDim2.fromScale(1, 0)
	options1.ZIndex = 6

	uIListLayout6 = Instance.new("UIListLayout")
	uIListLayout6.Name = "UIListLayout"
	uIListLayout6.Padding = UDim.new(0, 3)
	uIListLayout6.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout6.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout6.Parent = options1

	options1.Parent = dropdown1

	uIPadding4 = Instance.new("UIPadding")
	uIPadding4.Name = "UIPadding"
	uIPadding4.PaddingBottom = UDim.new(0, 55)
	uIPadding4.Parent = dropdown1

	frame1 = Instance.new("Frame")
	frame1.Name = "Frame"
	frame1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame1.BackgroundTransparency = 0.35
	frame1.BorderSizePixel = 0
	frame1.Size = UDim2.new(1, 0, 1, -20)
	frame1.ZIndex = 6
	frame1.Parent = dropdown1

	dropdown1.Parent = animationStyle

	animationStyle.Parent = scroller4

	fadeoutTime = Instance.new("Frame")
	fadeoutTime.Name = "FadeoutTime"
	fadeoutTime.Active = true
	fadeoutTime.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	fadeoutTime.BackgroundTransparency = 0.5
	fadeoutTime.BorderSizePixel = 0
	fadeoutTime.LayoutOrder = 2
	fadeoutTime.Position = UDim2.fromScale(0.0328, 0.044)
	fadeoutTime.Selectable = true
	fadeoutTime.Size = UDim2.new(1, -10, 0, 55)
	fadeoutTime.ZIndex = 6

	center2 = Instance.new("Frame")
	center2.Name = "Center"
	center2.AnchorPoint = Vector2.new(0, 0.5)
	center2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	center2.BackgroundTransparency = 1
	center2.Position = UDim2.fromScale(0, 0.5)
	center2.Size = UDim2.fromScale(1, 0.75)
	center2.ZIndex = 6

	title8 = Instance.new("Frame")
	title8.Name = "Title"
	title8.AnchorPoint = Vector2.new(0.5, 0)
	title8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title8.BackgroundTransparency = 1
	title8.BorderSizePixel = 0
	title8.Position = UDim2.fromScale(0.5, 0)
	title8.Size = UDim2.new(0.95, 0, 0, 20)
	title8.ZIndex = 6

	icon13 = Instance.new("ImageLabel")
	icon13.Name = "Icon"
	icon13.Image = "rbxassetid://8677983647"
	icon13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon13.BackgroundTransparency = 1
	icon13.Size = UDim2.fromOffset(20, 20)
	icon13.ZIndex = 6
	icon13.Parent = title8

	label6 = Instance.new("TextLabel")
	label6.Name = "Label"
	label6.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label6.Text = "Fade Time"
	label6.TextColor3 = Color3.fromRGB(255, 255, 255)
	label6.TextSize = 14
	label6.TextXAlignment = Enum.TextXAlignment.Left
	label6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label6.BackgroundTransparency = 1
	label6.Position = UDim2.fromOffset(25, 0)
	label6.Size = UDim2.new(0.5, 0, 0, 18)
	label6.ZIndex = 6
	label6.Parent = title8

	title8.Parent = center2

	actual2 = Instance.new("Frame")
	actual2.Name = "Actual"
	actual2.AnchorPoint = Vector2.new(0.5, 1)
	actual2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	actual2.BackgroundTransparency = 1
	actual2.Position = UDim2.new(0.5, 0, 1, 5)
	actual2.Size = UDim2.new(0.95, 0, 0, 25)
	actual2.ZIndex = 6

	amount2 = Instance.new("TextBox")
	amount2.Name = "Amount"
	amount2.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	amount2.PlaceholderColor3 = Color3.fromRGB(220, 220, 220)
	amount2.PlaceholderText = "%"
	amount2.Text = "_"
	amount2.TextColor3 = Color3.fromRGB(255, 255, 255)
	amount2.TextSize = 14
	amount2.AnchorPoint = Vector2.new(1, 0.5)
	amount2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	amount2.BackgroundTransparency = 0.5
	amount2.BorderSizePixel = 0
	amount2.Position = UDim2.fromScale(1, 0.5)
	amount2.Size = UDim2.new(0.125, 0, 0, 20)
	amount2.ZIndex = 6

	uICorner25 = Instance.new("UICorner")
	uICorner25.Name = "UICorner"
	uICorner25.Parent = amount2

	uIPadding5 = Instance.new("UIPadding")
	uIPadding5.Name = "UIPadding"
	uIPadding5.PaddingLeft = UDim.new(0, 5)
	uIPadding5.PaddingRight = UDim.new(0, 5)
	uIPadding5.Parent = amount2

	amount2.Parent = actual2

	bar3 = Instance.new("Frame")
	bar3.Name = "Bar"
	bar3.AnchorPoint = Vector2.new(0, 0.5)
	bar3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bar3.BorderSizePixel = 0
	bar3.Position = UDim2.fromScale(0, 0.5)
	bar3.Size = UDim2.new(0.85, 0, 0, 10)
	bar3.ZIndex = 6

	ignore9 = Instance.new("UICorner")
	ignore9.Name = "Ignore"
	ignore9.CornerRadius = UDim.new(1, 0)
	ignore9.Parent = bar3

	button2 = Instance.new("TextButton")
	button2.Name = "Button"
	button2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	button2.Text = ""
	button2.TextColor3 = Color3.fromRGB(0, 0, 0)
	button2.TextSize = 14
	button2.AnchorPoint = Vector2.new(0.5, 0.5)
	button2.BackgroundColor3 = Color3.fromRGB(30, 200, 150)
	button2.BorderSizePixel = 0
	button2.Position = UDim2.new(0, 10, 0.5, 0)
	button2.Size = UDim2.fromOffset(20, 20)
	button2.ZIndex = 7

	ignore10 = Instance.new("UICorner")
	ignore10.Name = "Ignore"
	ignore10.CornerRadius = UDim.new(1, 0)
	ignore10.Parent = button2

	button2.Parent = bar3

	progress2 = Instance.new("Frame")
	progress2.Name = "Progress"
	progress2.BackgroundColor3 = Color3.fromRGB(25, 170, 127)
	progress2.BorderSizePixel = 0
	progress2.Size = UDim2.fromScale(0, 1)
	progress2.ZIndex = 6

	ignore11 = Instance.new("UICorner")
	ignore11.Name = "Ignore"
	ignore11.CornerRadius = UDim.new(1, 0)
	ignore11.Parent = progress2

	progress2.Parent = bar3

	bar3.Parent = actual2

	actual2.Parent = center2

	center2.Parent = fadeoutTime

	uICorner26 = Instance.new("UICorner")
	uICorner26.Name = "UICorner"
	uICorner26.Parent = fadeoutTime

	fadeoutTime.Parent = scroller4

	font = Instance.new("Frame")
	font.Name = "Font"
	font.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	font.BackgroundTransparency = 1
	font.ClipsDescendants = true
	font.LayoutOrder = 1
	font.Size = UDim2.new(1, -10, 0, 30)
	font.ZIndex = 6

	title9 = Instance.new("Frame")
	title9.Name = "Title"
	title9.AnchorPoint = Vector2.new(0.5, 0.5)
	title9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title9.BackgroundTransparency = 1
	title9.BorderSizePixel = 0
	title9.Position = UDim2.new(0.5, 0, 0, 15)
	title9.Size = UDim2.new(0.95, 0, 0, 20)
	title9.ZIndex = 8

	icon14 = Instance.new("ImageLabel")
	icon14.Name = "Icon"
	icon14.Image = "rbxassetid://8678012976"
	icon14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon14.BackgroundTransparency = 1
	icon14.Size = UDim2.fromOffset(20, 20)
	icon14.ZIndex = 9
	icon14.Parent = title9

	label7 = Instance.new("TextLabel")
	label7.Name = "Label"
	label7.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label7.Text = "Font"
	label7.TextColor3 = Color3.fromRGB(255, 255, 255)
	label7.TextSize = 14
	label7.TextXAlignment = Enum.TextXAlignment.Left
	label7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label7.BackgroundTransparency = 1
	label7.Position = UDim2.fromOffset(25, 0)
	label7.Size = UDim2.fromOffset(0, 18)
	label7.ZIndex = 9
	label7.Parent = title9

	drop2 = Instance.new("TextButton")
	drop2.Name = "Drop"
	drop2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	drop2.Text = ""
	drop2.TextColor3 = Color3.fromRGB(0, 0, 0)
	drop2.TextSize = 14
	drop2.AnchorPoint = Vector2.new(1, 0)
	drop2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	drop2.BorderSizePixel = 0
	drop2.Position = UDim2.fromScale(1, 0)
	drop2.Size = UDim2.fromOffset(30, 20)
	drop2.ZIndex = 9

	uICorner27 = Instance.new("UICorner")
	uICorner27.Name = "UICorner"
	uICorner27.Parent = drop2

	icon15 = Instance.new("ImageLabel")
	icon15.Name = "Icon"
	icon15.Image = "rbxassetid://8677555693"
	icon15.AnchorPoint = Vector2.new(0.5, 0.5)
	icon15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon15.BackgroundTransparency = 1
	icon15.Position = UDim2.fromScale(0.5, 0.5)
	icon15.Size = UDim2.fromOffset(25, 25)
	icon15.ZIndex = 10
	icon15.Parent = drop2

	drop2.Parent = title9

	selected2 = Instance.new("TextLabel")
	selected2.Name = "Selected"
	selected2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	selected2.Text = "GothamMedium"
	selected2.TextColor3 = Color3.fromRGB(200, 200, 200)
	selected2.TextSize = 14
	selected2.TextXAlignment = Enum.TextXAlignment.Right
	selected2.AnchorPoint = Vector2.new(1, 0.5)
	selected2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	selected2.BackgroundTransparency = 1
	selected2.Position = UDim2.new(1, -35, 0.5, 0)
	selected2.Size = UDim2.fromOffset(0, 18)
	selected2.ZIndex = 9
	selected2.Parent = title9

	title9.Parent = font

	topContainer2 = Instance.new("Frame")
	topContainer2.Name = "TopContainer"
	topContainer2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	topContainer2.BackgroundTransparency = 1
	topContainer2.LayoutOrder = 2
	topContainer2.Size = UDim2.new(1, 0, 0, 25)
	topContainer2.ZIndex = 6

	background2 = Instance.new("Frame")
	background2.Name = "Background"
	background2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	background2.BackgroundTransparency = 1
	background2.LayoutOrder = 2
	background2.Size = UDim2.new(1, 0, 0, 25)
	background2.ZIndex = 6

	main5 = Instance.new("Frame")
	main5.Name = "Main"
	main5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	main5.BackgroundTransparency = 0.5
	main5.LayoutOrder = 2
	main5.Size = UDim2.new(1, 0, 0, 30)
	main5.ZIndex = 6

	uICorner28 = Instance.new("UICorner")
	uICorner28.Name = "UICorner"
	uICorner28.Parent = main5

	main5.Parent = background2

	background2.Parent = topContainer2

	flat2 = Instance.new("Frame")
	flat2.Name = "Flat"
	flat2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	flat2.BackgroundTransparency = 0.5
	flat2.BorderSizePixel = 0
	flat2.Position = UDim2.fromOffset(0, 25)
	flat2.Size = UDim2.new(1, 0, 0, 5)
	flat2.Visible = false
	flat2.ZIndex = 6
	flat2.Parent = topContainer2

	topContainer2.Parent = font

	dropdown2 = Instance.new("Frame")
	dropdown2.Name = "Dropdown"
	dropdown2.AutomaticSize = Enum.AutomaticSize.Y
	dropdown2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	dropdown2.BackgroundTransparency = 1
	dropdown2.BorderSizePixel = 0
	dropdown2.ClipsDescendants = true
	dropdown2.Position = UDim2.fromOffset(0, 30)
	dropdown2.Size = UDim2.fromScale(1, 0)
	dropdown2.ZIndex = 6

	bottomContainer2 = Instance.new("Frame")
	bottomContainer2.Name = "BottomContainer"
	bottomContainer2.AnchorPoint = Vector2.new(0, 1)
	bottomContainer2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bottomContainer2.BackgroundTransparency = 1
	bottomContainer2.BorderSizePixel = 0
	bottomContainer2.ClipsDescendants = true
	bottomContainer2.Position = UDim2.new(0, 0, 2, -20)
	bottomContainer2.Size = UDim2.fromScale(1, 1)
	bottomContainer2.ZIndex = 6

	rounded3 = Instance.new("Frame")
	rounded3.Name = "Rounded"
	rounded3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	rounded3.BackgroundTransparency = 0.35
	rounded3.Position = UDim2.fromOffset(0, -30)
	rounded3.Size = UDim2.new(1, 0, 0, 50)
	rounded3.ZIndex = 6

	uICorner29 = Instance.new("UICorner")
	uICorner29.Name = "UICorner"
	uICorner29.Parent = rounded3

	rounded3.Parent = bottomContainer2

	bottomContainer2.Parent = dropdown2

	options2 = Instance.new("Frame")
	options2.Name = "Options"
	options2.AutomaticSize = Enum.AutomaticSize.Y
	options2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	options2.BackgroundTransparency = 1
	options2.Size = UDim2.fromScale(1, 0)
	options2.ZIndex = 6

	uIListLayout7 = Instance.new("UIListLayout")
	uIListLayout7.Name = "UIListLayout"
	uIListLayout7.Padding = UDim.new(0, 3)
	uIListLayout7.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout7.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout7.Parent = options2

	options2.Parent = dropdown2

	uIPadding6 = Instance.new("UIPadding")
	uIPadding6.Name = "UIPadding"
	uIPadding6.PaddingBottom = UDim.new(0, 55)
	uIPadding6.Parent = dropdown2

	frame2 = Instance.new("Frame")
	frame2.Name = "Frame"
	frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame2.BackgroundTransparency = 0.35
	frame2.BorderSizePixel = 0
	frame2.Size = UDim2.new(1, 0, 1, -20)
	frame2.ZIndex = 6
	frame2.Parent = dropdown2

	dropdown2.Parent = font

	font.Parent = scroller4

	enabled = Instance.new("Frame")
	enabled.Name = "Enabled"
	enabled.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	enabled.BackgroundTransparency = 0.5
	enabled.LayoutOrder = -1
	enabled.Size = UDim2.new(1, -10, 0, 30)
	enabled.ZIndex = 6

	title10 = Instance.new("Frame")
	title10.Name = "Title"
	title10.AnchorPoint = Vector2.new(0.5, 0.5)
	title10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title10.BackgroundTransparency = 1
	title10.BorderSizePixel = 0
	title10.Position = UDim2.fromScale(0.5, 0.5)
	title10.Size = UDim2.new(0.95, 0, 0, 20)
	title10.ZIndex = 6

	icon16 = Instance.new("ImageLabel")
	icon16.Name = "Icon"
	icon16.Image = "rbxassetid://8685962752"
	icon16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon16.BackgroundTransparency = 1
	icon16.Size = UDim2.fromOffset(20, 20)
	icon16.ZIndex = 6
	icon16.Parent = title10

	label8 = Instance.new("TextLabel")
	label8.Name = "Label"
	label8.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label8.Text = "Enabled"
	label8.TextColor3 = Color3.fromRGB(255, 255, 255)
	label8.TextSize = 14
	label8.TextXAlignment = Enum.TextXAlignment.Left
	label8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label8.BackgroundTransparency = 1
	label8.Position = UDim2.fromOffset(25, 0)
	label8.Size = UDim2.new(0.5, 0, 0, 18)
	label8.ZIndex = 6
	label8.Parent = title10

	title10.Parent = enabled

	uICorner30 = Instance.new("UICorner")
	uICorner30.Name = "UICorner"
	uICorner30.Parent = enabled

	toggle1 = Instance.new("Frame")
	toggle1.Name = "Toggle"
	toggle1.AnchorPoint = Vector2.new(1, 0.5)
	toggle1.BackgroundColor3 = Color3.fromRGB(72, 175, 240)
	toggle1.BorderSizePixel = 0
	toggle1.Position = UDim2.new(1, -5, 0.5, 0)
	toggle1.Size = UDim2.fromOffset(40, 18)
	toggle1.ZIndex = 6

	ignore12 = Instance.new("UICorner")
	ignore12.Name = "Ignore"
	ignore12.CornerRadius = UDim.new(1, 0)
	ignore12.Parent = toggle1

	zone2 = Instance.new("TextButton")
	zone2.Name = "Zone"
	zone2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	zone2.Text = ""
	zone2.TextColor3 = Color3.fromRGB(0, 0, 0)
	zone2.TextSize = 14
	zone2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	zone2.BackgroundTransparency = 1
	zone2.Size = UDim2.fromScale(1, 1)
	zone2.ZIndex = 8

	ignore13 = Instance.new("UICorner")
	ignore13.Name = "Ignore"
	ignore13.CornerRadius = UDim.new(1, 0)
	ignore13.Parent = zone2

	zone2.Parent = toggle1

	rounded4 = Instance.new("Frame")
	rounded4.Name = "Rounded"
	rounded4.AnchorPoint = Vector2.new(1, 0.5)
	rounded4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	rounded4.Position = UDim2.new(1, -3, 0.5, 0)
	rounded4.Size = UDim2.fromOffset(14, 14)
	rounded4.ZIndex = 6

	ignore14 = Instance.new("UICorner")
	ignore14.Name = "Ignore"
	ignore14.CornerRadius = UDim.new(1, 0)
	ignore14.Parent = rounded4

	rounded4.Parent = toggle1

	toggle1.Parent = enabled

	enabled.Parent = scroller4

	scroller4.Parent = bubbleChat1

	bubbleChat1.Parent = pages

	quickChat1 = Instance.new("Frame")
	quickChat1.Name = "QuickChat"
	quickChat1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	quickChat1.BackgroundTransparency = 1
	quickChat1.Position = UDim2.fromScale(1, 0)
	quickChat1.Size = UDim2.fromScale(1, 1)
	quickChat1.ZIndex = 6

	title11 = Instance.new("TextLabel")
	title11.Name = "Title"
	title11.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	title11.Text = "Quick Chat"
	title11.TextColor3 = Color3.fromRGB(255, 255, 255)
	title11.TextSize = 20
	title11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title11.BackgroundTransparency = 1
	title11.Position = UDim2.fromOffset(0, 5)
	title11.Size = UDim2.new(1, 0, 0, 30)
	title11.ZIndex = 6

	back2 = Instance.new("TextButton")
	back2.Name = "Back"
	back2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	back2.Text = ""
	back2.TextColor3 = Color3.fromRGB(0, 0, 0)
	back2.TextSize = 14
	back2.AnchorPoint = Vector2.new(0, 0.5)
	back2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	back2.Position = UDim2.new(0, 5, 0.5, 0)
	back2.Size = UDim2.fromOffset(25, 25)
	back2.ZIndex = 6

	imageLabel2 = Instance.new("ImageLabel")
	imageLabel2.Name = "ImageLabel"
	imageLabel2.Image = "rbxassetid://8677511725"
	imageLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	imageLabel2.BackgroundTransparency = 1
	imageLabel2.Position = UDim2.fromScale(0.5, 0.5)
	imageLabel2.Size = UDim2.fromScale(0.85, 0.85)
	imageLabel2.ZIndex = 6
	imageLabel2.Parent = back2

	uICorner31 = Instance.new("UICorner")
	uICorner31.Name = "UICorner"
	uICorner31.Parent = back2

	back2.Parent = title11

	title11.Parent = quickChat1

	scroller5 = Instance.new("ScrollingFrame")
	scroller5.Name = "Scroller"
	scroller5.BottomImage = "rbxassetid://8082116996"
	scroller5.CanvasSize = UDim2.new()
	scroller5.MidImage = "rbxassetid://7488333553"
	scroller5.ScrollBarThickness = 5
	scroller5.TopImage = "rbxassetid://8082122989"
	scroller5.AnchorPoint = Vector2.new(0.5, 1)
	scroller5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scroller5.BackgroundTransparency = 1
	scroller5.BorderSizePixel = 0
	scroller5.Position = UDim2.new(0.5, 0, 1, -10)
	scroller5.Selectable = false
	scroller5.Size = UDim2.new(1, -10, 1, -50)
	scroller5.ZIndex = 6

	uIListLayout8 = Instance.new("UIListLayout")
	uIListLayout8.Name = "UIListLayout"
	uIListLayout8.Padding = UDim.new(0, 5)
	uIListLayout8.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout8.Parent = scroller5

	scroller5.Parent = quickChat1

	quickChat1.Parent = pages

	help1 = Instance.new("Frame")
	help1.Name = "Help"
	help1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	help1.BackgroundTransparency = 1
	help1.Position = UDim2.fromScale(1, 0)
	help1.Size = UDim2.fromScale(1, 1)
	help1.ZIndex = 6

	title12 = Instance.new("TextLabel")
	title12.Name = "Title"
	title12.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	title12.Text = "Help"
	title12.TextColor3 = Color3.fromRGB(255, 255, 255)
	title12.TextSize = 20
	title12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title12.BackgroundTransparency = 1
	title12.Position = UDim2.fromOffset(0, 5)
	title12.Size = UDim2.new(1, 0, 0, 30)
	title12.ZIndex = 6

	back3 = Instance.new("TextButton")
	back3.Name = "Back"
	back3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	back3.Text = ""
	back3.TextColor3 = Color3.fromRGB(0, 0, 0)
	back3.TextSize = 14
	back3.AnchorPoint = Vector2.new(0, 0.5)
	back3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	back3.Position = UDim2.new(0, 5, 0.5, 0)
	back3.Size = UDim2.fromOffset(25, 25)
	back3.ZIndex = 6

	imageLabel3 = Instance.new("ImageLabel")
	imageLabel3.Name = "ImageLabel"
	imageLabel3.Image = "rbxassetid://8677511725"
	imageLabel3.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	imageLabel3.BackgroundTransparency = 1
	imageLabel3.Position = UDim2.fromScale(0.5, 0.5)
	imageLabel3.Size = UDim2.fromScale(0.85, 0.85)
	imageLabel3.ZIndex = 6
	imageLabel3.Parent = back3

	uICorner32 = Instance.new("UICorner")
	uICorner32.Name = "UICorner"
	uICorner32.Parent = back3

	back3.Parent = title12

	title12.Parent = help1

	scroller6 = Instance.new("ScrollingFrame")
	scroller6.Name = "Scroller"
	scroller6.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroller6.BottomImage = "rbxassetid://8082116996"
	scroller6.CanvasSize = UDim2.new()
	scroller6.MidImage = "rbxassetid://7488333553"
	scroller6.ScrollBarThickness = 5
	scroller6.TopImage = "rbxassetid://8082122989"
	scroller6.AnchorPoint = Vector2.new(0.5, 1)
	scroller6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scroller6.BackgroundTransparency = 1
	scroller6.BorderSizePixel = 0
	scroller6.Position = UDim2.new(0.5, 0, 1, -10)
	scroller6.Selectable = false
	scroller6.Size = UDim2.new(1, -10, 1, -50)
	scroller6.ZIndex = 6

	uIListLayout9 = Instance.new("UIListLayout")
	uIListLayout9.Name = "UIListLayout"
	uIListLayout9.Padding = UDim.new(0, 5)
	uIListLayout9.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout9.Parent = scroller6

	generalFormatting = Instance.new("Frame")
	generalFormatting.Name = "GeneralFormatting"
	generalFormatting.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	generalFormatting.BackgroundTransparency = 1
	generalFormatting.Size = UDim2.new(1, -10, 0, 30)
	generalFormatting.ZIndex = 6

	dropdown3 = Instance.new("Frame")
	dropdown3.Name = "Dropdown"
	dropdown3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dropdown3.BackgroundTransparency = 1
	dropdown3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	dropdown3.BorderSizePixel = 0
	dropdown3.ClipsDescendants = true
	dropdown3.Position = UDim2.fromOffset(0, 35)
	dropdown3.Size = UDim2.fromScale(1, 0)
	dropdown3.Visible = false

	italicBold = Instance.new("Frame")
	italicBold.Name = "ItalicBold"
	italicBold.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	italicBold.BackgroundTransparency = 1
	italicBold.LayoutOrder = 3
	italicBold.Size = UDim2.new(1, -10, 0, 30)
	italicBold.ZIndex = 6

	uICorner33 = Instance.new("UICorner")
	uICorner33.Name = "UICorner"
	uICorner33.Parent = italicBold

	example = Instance.new("TextLabel")
	example.Name = "Example"
	example.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	example.Text = "Italic bold: ***text***"
	example.TextColor3 = Color3.fromRGB(255, 255, 255)
	example.TextSize = 15
	example.TextXAlignment = Enum.TextXAlignment.Left
	example.AutomaticSize = Enum.AutomaticSize.X
	example.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	example.BackgroundTransparency = 1
	example.BorderColor3 = Color3.fromRGB(0, 0, 0)
	example.BorderSizePixel = 0
	example.Position = UDim2.fromOffset(20, 0)
	example.Size = UDim2.fromScale(0, 1)
	example.ZIndex = 10

	uIPadding7 = Instance.new("UIPadding")
	uIPadding7.Name = "UIPadding"
	uIPadding7.PaddingRight = UDim.new(0, 5)
	uIPadding7.Parent = example

	imageLabel4 = Instance.new("ImageLabel")
	imageLabel4.Name = "ImageLabel"
	imageLabel4.Image = "http://www.roblox.com/asset/?id=6031090995"
	imageLabel4.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel4.BackgroundTransparency = 1
	imageLabel4.BorderSizePixel = 0
	imageLabel4.Position = UDim2.new(1, 5, 0.5, 0)
	imageLabel4.Size = UDim2.fromOffset(20, 20)
	imageLabel4.ZIndex = 10

	formatted = Instance.new("TextLabel")
	formatted.Name = "Formatted"
	formatted.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	formatted.RichText = true
	formatted.Text = "<i><b>text</b></i>"
	formatted.TextColor3 = Color3.fromRGB(255, 255, 255)
	formatted.TextSize = 15
	formatted.TextXAlignment = Enum.TextXAlignment.Left
	formatted.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	formatted.BorderColor3 = Color3.fromRGB(0, 0, 0)
	formatted.BorderSizePixel = 0
	formatted.Position = UDim2.new(1, 5, 0, 0)
	formatted.Size = UDim2.fromScale(0, 1)
	formatted.ZIndex = 10
	formatted.Parent = imageLabel4

	imageLabel4.Parent = example

	example.Parent = italicBold

	bulletPoint = Instance.new("Frame")
	bulletPoint.Name = "BulletPoint"
	bulletPoint.AnchorPoint = Vector2.new(0, 0.5)
	bulletPoint.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bulletPoint.BorderColor3 = Color3.fromRGB(0, 0, 0)
	bulletPoint.BorderSizePixel = 0
	bulletPoint.Position = UDim2.new(0, 5, 0.5, 0)
	bulletPoint.Size = UDim2.fromOffset(10, 10)
	bulletPoint.ZIndex = 9

	ignore15 = Instance.new("UICorner")
	ignore15.Name = "Ignore"
	ignore15.CornerRadius = UDim.new(1, 0)
	ignore15.Parent = bulletPoint

	bulletPoint.Parent = italicBold

	italicBold.Parent = dropdown3

	italics = Instance.new("Frame")
	italics.Name = "Italics"
	italics.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	italics.BackgroundTransparency = 1
	italics.LayoutOrder = 1
	italics.Size = UDim2.new(1, -10, 0, 30)
	italics.ZIndex = 6

	uICorner34 = Instance.new("UICorner")
	uICorner34.Name = "UICorner"
	uICorner34.Parent = italics

	example1 = Instance.new("TextLabel")
	example1.Name = "Example"
	example1.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	example1.Text = "Italics: *text*"
	example1.TextColor3 = Color3.fromRGB(255, 255, 255)
	example1.TextSize = 15
	example1.TextXAlignment = Enum.TextXAlignment.Left
	example1.AutomaticSize = Enum.AutomaticSize.X
	example1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	example1.BackgroundTransparency = 1
	example1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	example1.BorderSizePixel = 0
	example1.Position = UDim2.fromOffset(20, 0)
	example1.Size = UDim2.fromScale(0, 1)
	example1.ZIndex = 10

	uIPadding8 = Instance.new("UIPadding")
	uIPadding8.Name = "UIPadding"
	uIPadding8.PaddingRight = UDim.new(0, 5)
	uIPadding8.Parent = example1

	imageLabel5 = Instance.new("ImageLabel")
	imageLabel5.Name = "ImageLabel"
	imageLabel5.Image = "http://www.roblox.com/asset/?id=6031090995"
	imageLabel5.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel5.BackgroundTransparency = 1
	imageLabel5.BorderSizePixel = 0
	imageLabel5.Position = UDim2.new(1, 5, 0.5, 0)
	imageLabel5.Size = UDim2.fromOffset(20, 20)
	imageLabel5.ZIndex = 10

	formatted1 = Instance.new("TextLabel")
	formatted1.Name = "Formatted"
	formatted1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	formatted1.RichText = true
	formatted1.Text = "<i>text</i>"
	formatted1.TextColor3 = Color3.fromRGB(255, 255, 255)
	formatted1.TextSize = 15
	formatted1.TextXAlignment = Enum.TextXAlignment.Left
	formatted1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	formatted1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	formatted1.BorderSizePixel = 0
	formatted1.Position = UDim2.new(1, 5, 0, 0)
	formatted1.Size = UDim2.fromScale(0, 1)
	formatted1.ZIndex = 10
	formatted1.Parent = imageLabel5

	imageLabel5.Parent = example1

	example1.Parent = italics

	bulletPoint1 = Instance.new("Frame")
	bulletPoint1.Name = "BulletPoint"
	bulletPoint1.AnchorPoint = Vector2.new(0, 0.5)
	bulletPoint1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bulletPoint1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	bulletPoint1.BorderSizePixel = 0
	bulletPoint1.Position = UDim2.new(0, 5, 0.5, 0)
	bulletPoint1.Size = UDim2.fromOffset(10, 10)
	bulletPoint1.ZIndex = 9

	ignore16 = Instance.new("UICorner")
	ignore16.Name = "Ignore"
	ignore16.CornerRadius = UDim.new(1, 0)
	ignore16.Parent = bulletPoint1

	bulletPoint1.Parent = italics

	italics.Parent = dropdown3

	underlined = Instance.new("Frame")
	underlined.Name = "Underlined"
	underlined.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	underlined.BackgroundTransparency = 1
	underlined.LayoutOrder = 4
	underlined.Size = UDim2.new(1, -10, 0, 30)
	underlined.ZIndex = 6

	uICorner35 = Instance.new("UICorner")
	uICorner35.Name = "UICorner"
	uICorner35.Parent = underlined

	example2 = Instance.new("TextLabel")
	example2.Name = "Example"
	example2.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	example2.Text = "Underlined: __text__"
	example2.TextColor3 = Color3.fromRGB(255, 255, 255)
	example2.TextSize = 15
	example2.TextXAlignment = Enum.TextXAlignment.Left
	example2.AutomaticSize = Enum.AutomaticSize.X
	example2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	example2.BackgroundTransparency = 1
	example2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	example2.BorderSizePixel = 0
	example2.Position = UDim2.fromOffset(20, 0)
	example2.Size = UDim2.fromScale(0, 1)
	example2.ZIndex = 10

	uIPadding9 = Instance.new("UIPadding")
	uIPadding9.Name = "UIPadding"
	uIPadding9.PaddingRight = UDim.new(0, 5)
	uIPadding9.Parent = example2

	imageLabel6 = Instance.new("ImageLabel")
	imageLabel6.Name = "ImageLabel"
	imageLabel6.Image = "http://www.roblox.com/asset/?id=6031090995"
	imageLabel6.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel6.BackgroundTransparency = 1
	imageLabel6.BorderSizePixel = 0
	imageLabel6.Position = UDim2.new(1, 5, 0.5, 0)
	imageLabel6.Size = UDim2.fromOffset(20, 20)
	imageLabel6.ZIndex = 10

	formatted2 = Instance.new("TextLabel")
	formatted2.Name = "Formatted"
	formatted2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	formatted2.RichText = true
	formatted2.Text = "<u>text</u>"
	formatted2.TextColor3 = Color3.fromRGB(255, 255, 255)
	formatted2.TextSize = 15
	formatted2.TextXAlignment = Enum.TextXAlignment.Left
	formatted2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	formatted2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	formatted2.BorderSizePixel = 0
	formatted2.Position = UDim2.new(1, 5, 0, 0)
	formatted2.Size = UDim2.fromScale(0, 1)
	formatted2.ZIndex = 10
	formatted2.Parent = imageLabel6

	imageLabel6.Parent = example2

	example2.Parent = underlined

	bulletPoint2 = Instance.new("Frame")
	bulletPoint2.Name = "BulletPoint"
	bulletPoint2.AnchorPoint = Vector2.new(0, 0.5)
	bulletPoint2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bulletPoint2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	bulletPoint2.BorderSizePixel = 0
	bulletPoint2.Position = UDim2.new(0, 5, 0.5, 0)
	bulletPoint2.Size = UDim2.fromOffset(10, 10)
	bulletPoint2.ZIndex = 9

	ignore17 = Instance.new("UICorner")
	ignore17.Name = "Ignore"
	ignore17.CornerRadius = UDim.new(1, 0)
	ignore17.Parent = bulletPoint2

	bulletPoint2.Parent = underlined

	underlined.Parent = dropdown3

	strikethrough = Instance.new("Frame")
	strikethrough.Name = "Strikethrough"
	strikethrough.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	strikethrough.BackgroundTransparency = 1
	strikethrough.LayoutOrder = 5
	strikethrough.Size = UDim2.new(1, -10, 0, 30)
	strikethrough.ZIndex = 6

	uICorner36 = Instance.new("UICorner")
	uICorner36.Name = "UICorner"
	uICorner36.Parent = strikethrough

	example3 = Instance.new("TextLabel")
	example3.Name = "Example"
	example3.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	example3.Text = "Strikethrough: ~~text~~"
	example3.TextColor3 = Color3.fromRGB(255, 255, 255)
	example3.TextSize = 15
	example3.TextXAlignment = Enum.TextXAlignment.Left
	example3.AutomaticSize = Enum.AutomaticSize.X
	example3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	example3.BackgroundTransparency = 1
	example3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	example3.BorderSizePixel = 0
	example3.Position = UDim2.fromOffset(20, 0)
	example3.Size = UDim2.fromScale(0, 1)
	example3.ZIndex = 10

	uIPadding10 = Instance.new("UIPadding")
	uIPadding10.Name = "UIPadding"
	uIPadding10.PaddingRight = UDim.new(0, 5)
	uIPadding10.Parent = example3

	imageLabel7 = Instance.new("ImageLabel")
	imageLabel7.Name = "ImageLabel"
	imageLabel7.Image = "http://www.roblox.com/asset/?id=6031090995"
	imageLabel7.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel7.BackgroundTransparency = 1
	imageLabel7.BorderSizePixel = 0
	imageLabel7.Position = UDim2.new(1, 5, 0.5, 0)
	imageLabel7.Size = UDim2.fromOffset(20, 20)
	imageLabel7.ZIndex = 10

	formatted3 = Instance.new("TextLabel")
	formatted3.Name = "Formatted"
	formatted3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	formatted3.RichText = true
	formatted3.Text = "<s>text</s>"
	formatted3.TextColor3 = Color3.fromRGB(255, 255, 255)
	formatted3.TextSize = 15
	formatted3.TextXAlignment = Enum.TextXAlignment.Left
	formatted3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	formatted3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	formatted3.BorderSizePixel = 0
	formatted3.Position = UDim2.new(1, 5, 0, 0)
	formatted3.Size = UDim2.fromScale(0, 1)
	formatted3.ZIndex = 10
	formatted3.Parent = imageLabel7

	imageLabel7.Parent = example3

	example3.Parent = strikethrough

	bulletPoint3 = Instance.new("Frame")
	bulletPoint3.Name = "BulletPoint"
	bulletPoint3.AnchorPoint = Vector2.new(0, 0.5)
	bulletPoint3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bulletPoint3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	bulletPoint3.BorderSizePixel = 0
	bulletPoint3.Position = UDim2.new(0, 5, 0.5, 0)
	bulletPoint3.Size = UDim2.fromOffset(10, 10)
	bulletPoint3.ZIndex = 9

	ignore18 = Instance.new("UICorner")
	ignore18.Name = "Ignore"
	ignore18.CornerRadius = UDim.new(1, 0)
	ignore18.Parent = bulletPoint3

	bulletPoint3.Parent = strikethrough

	strikethrough.Parent = dropdown3

	bold = Instance.new("Frame")
	bold.Name = "Bold"
	bold.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bold.BackgroundTransparency = 1
	bold.LayoutOrder = 2
	bold.Size = UDim2.new(1, -10, 0, 30)
	bold.ZIndex = 6

	uICorner37 = Instance.new("UICorner")
	uICorner37.Name = "UICorner"
	uICorner37.Parent = bold

	example4 = Instance.new("TextLabel")
	example4.Name = "Example"
	example4.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	example4.Text = "Bold: **text**"
	example4.TextColor3 = Color3.fromRGB(255, 255, 255)
	example4.TextSize = 15
	example4.TextXAlignment = Enum.TextXAlignment.Left
	example4.AutomaticSize = Enum.AutomaticSize.X
	example4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	example4.BackgroundTransparency = 1
	example4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	example4.BorderSizePixel = 0
	example4.Position = UDim2.fromOffset(20, 0)
	example4.Size = UDim2.fromScale(0, 1)
	example4.ZIndex = 10

	uIPadding11 = Instance.new("UIPadding")
	uIPadding11.Name = "UIPadding"
	uIPadding11.PaddingRight = UDim.new(0, 5)
	uIPadding11.Parent = example4

	imageLabel8 = Instance.new("ImageLabel")
	imageLabel8.Name = "ImageLabel"
	imageLabel8.Image = "http://www.roblox.com/asset/?id=6031090995"
	imageLabel8.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel8.BackgroundTransparency = 1
	imageLabel8.BorderSizePixel = 0
	imageLabel8.Position = UDim2.new(1, 5, 0.5, 0)
	imageLabel8.Size = UDim2.fromOffset(20, 20)
	imageLabel8.ZIndex = 10

	formatted4 = Instance.new("TextLabel")
	formatted4.Name = "Formatted"
	formatted4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	formatted4.RichText = true
	formatted4.Text = "<b>text</b>"
	formatted4.TextColor3 = Color3.fromRGB(255, 255, 255)
	formatted4.TextSize = 15
	formatted4.TextXAlignment = Enum.TextXAlignment.Left
	formatted4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	formatted4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	formatted4.BorderSizePixel = 0
	formatted4.Position = UDim2.new(1, 5, 0, 0)
	formatted4.Size = UDim2.fromScale(0, 1)
	formatted4.ZIndex = 10
	formatted4.Parent = imageLabel8

	imageLabel8.Parent = example4

	example4.Parent = bold

	bulletPoint4 = Instance.new("Frame")
	bulletPoint4.Name = "BulletPoint"
	bulletPoint4.AnchorPoint = Vector2.new(0, 0.5)
	bulletPoint4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bulletPoint4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	bulletPoint4.BorderSizePixel = 0
	bulletPoint4.Position = UDim2.new(0, 5, 0.5, 0)
	bulletPoint4.Size = UDim2.fromOffset(10, 10)
	bulletPoint4.ZIndex = 9

	ignore19 = Instance.new("UICorner")
	ignore19.Name = "Ignore"
	ignore19.CornerRadius = UDim.new(1, 0)
	ignore19.Parent = bulletPoint4

	bulletPoint4.Parent = bold

	bold.Parent = dropdown3

	uIListLayout10 = Instance.new("UIListLayout")
	uIListLayout10.Name = "UIListLayout"
	uIListLayout10.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout10.Parent = dropdown3

	dropdown3.Parent = generalFormatting

	cover = Instance.new("Frame")
	cover.Name = "Cover"
	cover.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	cover.BackgroundTransparency = 0.5
	cover.BorderColor3 = Color3.fromRGB(0, 0, 0)
	cover.BorderSizePixel = 0
	cover.Size = UDim2.new(1, 0, 0, 30)

	uICorner38 = Instance.new("UICorner")
	uICorner38.Name = "UICorner"
	uICorner38.Parent = cover

	textLabel = Instance.new("TextLabel")
	textLabel.Name = "TextLabel"
	textLabel.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	textLabel.Text = "General formatting:"
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextSize = 14
	textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.BackgroundTransparency = 1
	textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.BorderSizePixel = 0
	textLabel.Size = UDim2.fromScale(1, 1)
	textLabel.ZIndex = 8
	textLabel.Parent = cover

	drop3 = Instance.new("TextButton")
	drop3.Name = "Drop"
	drop3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	drop3.Text = ""
	drop3.TextColor3 = Color3.fromRGB(0, 0, 0)
	drop3.TextSize = 14
	drop3.AnchorPoint = Vector2.new(1, 0.5)
	drop3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	drop3.BorderSizePixel = 0
	drop3.Position = UDim2.new(1, -5, 0.5, 0)
	drop3.Size = UDim2.fromOffset(30, 20)
	drop3.ZIndex = 9

	uICorner39 = Instance.new("UICorner")
	uICorner39.Name = "UICorner"
	uICorner39.Parent = drop3

	icon17 = Instance.new("ImageLabel")
	icon17.Name = "Icon"
	icon17.Image = "rbxassetid://8677555693"
	icon17.AnchorPoint = Vector2.new(0.5, 0.5)
	icon17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon17.BackgroundTransparency = 1
	icon17.Position = UDim2.fromScale(0.5, 0.5)
	icon17.Size = UDim2.fromOffset(25, 25)
	icon17.ZIndex = 10
	icon17.Parent = drop3

	drop3.Parent = cover

	cover.Parent = generalFormatting

	generalFormatting.Parent = scroller6

	colorFormatting = Instance.new("Frame")
	colorFormatting.Name = "ColorFormatting"
	colorFormatting.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	colorFormatting.BackgroundTransparency = 1
	colorFormatting.Size = UDim2.new(1, -10, 0, 30)
	colorFormatting.ZIndex = 6

	cover1 = Instance.new("Frame")
	cover1.Name = "Cover"
	cover1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	cover1.BackgroundTransparency = 0.5
	cover1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	cover1.BorderSizePixel = 0
	cover1.Size = UDim2.new(1, 0, 0, 30)

	uICorner40 = Instance.new("UICorner")
	uICorner40.Name = "UICorner"
	uICorner40.Parent = cover1

	textLabel1 = Instance.new("TextLabel")
	textLabel1.Name = "TextLabel"
	textLabel1.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	textLabel1.Text = "Color formatting:"
	textLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel1.TextSize = 14
	textLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel1.BackgroundTransparency = 1
	textLabel1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textLabel1.BorderSizePixel = 0
	textLabel1.Size = UDim2.fromScale(1, 1)
	textLabel1.ZIndex = 8
	textLabel1.Parent = cover1

	drop4 = Instance.new("TextButton")
	drop4.Name = "Drop"
	drop4.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	drop4.Text = ""
	drop4.TextColor3 = Color3.fromRGB(0, 0, 0)
	drop4.TextSize = 14
	drop4.AnchorPoint = Vector2.new(1, 0.5)
	drop4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	drop4.BorderSizePixel = 0
	drop4.Position = UDim2.new(1, -5, 0.5, 0)
	drop4.Size = UDim2.fromOffset(30, 20)
	drop4.ZIndex = 9

	uICorner41 = Instance.new("UICorner")
	uICorner41.Name = "UICorner"
	uICorner41.Parent = drop4

	icon18 = Instance.new("ImageLabel")
	icon18.Name = "Icon"
	icon18.Image = "rbxassetid://8677555693"
	icon18.AnchorPoint = Vector2.new(0.5, 0.5)
	icon18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon18.BackgroundTransparency = 1
	icon18.Position = UDim2.fromScale(0.5, 0.5)
	icon18.Size = UDim2.fromOffset(25, 25)
	icon18.ZIndex = 10
	icon18.Parent = drop4

	drop4.Parent = cover1

	cover1.Parent = colorFormatting

	dropdown4 = Instance.new("Frame")
	dropdown4.Name = "Dropdown"
	dropdown4.AutomaticSize = Enum.AutomaticSize.X
	dropdown4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dropdown4.BackgroundTransparency = 1
	dropdown4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	dropdown4.BorderSizePixel = 0
	dropdown4.ClipsDescendants = true
	dropdown4.LayoutOrder = 12
	dropdown4.Position = UDim2.fromOffset(0, 35)
	dropdown4.Size = UDim2.fromScale(1, 0)

	hex = Instance.new("Frame")
	hex.Name = "Hex"
	hex.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	hex.BackgroundTransparency = 1
	hex.LayoutOrder = 9
	hex.Size = UDim2.new(1, -10, 0, 30)
	hex.ZIndex = 6

	uICorner42 = Instance.new("UICorner")
	uICorner42.Name = "UICorner"
	uICorner42.Parent = hex

	example5 = Instance.new("TextLabel")
	example5.Name = "Example"
	example5.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	example5.Text = "Hex: (#FF0000 / text)"
	example5.TextColor3 = Color3.fromRGB(255, 255, 255)
	example5.TextSize = 15
	example5.TextXAlignment = Enum.TextXAlignment.Left
	example5.AutomaticSize = Enum.AutomaticSize.X
	example5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	example5.BackgroundTransparency = 1
	example5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	example5.BorderSizePixel = 0
	example5.Position = UDim2.fromOffset(20, 0)
	example5.Size = UDim2.fromScale(0, 1)
	example5.ZIndex = 10

	uIPadding12 = Instance.new("UIPadding")
	uIPadding12.Name = "UIPadding"
	uIPadding12.PaddingRight = UDim.new(0, 5)
	uIPadding12.Parent = example5

	imageLabel9 = Instance.new("ImageLabel")
	imageLabel9.Name = "ImageLabel"
	imageLabel9.Image = "http://www.roblox.com/asset/?id=6031090995"
	imageLabel9.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel9.BackgroundTransparency = 1
	imageLabel9.BorderSizePixel = 0
	imageLabel9.Position = UDim2.new(1, 5, 0.5, 0)
	imageLabel9.Size = UDim2.fromOffset(20, 20)
	imageLabel9.ZIndex = 10

	formatted5 = Instance.new("TextLabel")
	formatted5.Name = "Formatted"
	formatted5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	formatted5.RichText = true
	formatted5.Text = "<font color=\"rgb(255,0,0)\">text</font>"
	formatted5.TextColor3 = Color3.fromRGB(255, 255, 255)
	formatted5.TextSize = 15
	formatted5.TextXAlignment = Enum.TextXAlignment.Left
	formatted5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	formatted5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	formatted5.BorderSizePixel = 0
	formatted5.Position = UDim2.new(1, 5, 0, 0)
	formatted5.Size = UDim2.fromScale(0, 1)
	formatted5.ZIndex = 10
	formatted5.Parent = imageLabel9

	imageLabel9.Parent = example5

	example5.Parent = hex

	bulletPoint5 = Instance.new("Frame")
	bulletPoint5.Name = "BulletPoint"
	bulletPoint5.AnchorPoint = Vector2.new(0, 0.5)
	bulletPoint5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bulletPoint5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	bulletPoint5.BorderSizePixel = 0
	bulletPoint5.Position = UDim2.new(0, 5, 0.5, 0)
	bulletPoint5.Size = UDim2.fromOffset(10, 10)
	bulletPoint5.ZIndex = 9

	ignore20 = Instance.new("UICorner")
	ignore20.Name = "Ignore"
	ignore20.CornerRadius = UDim.new(1, 0)
	ignore20.Parent = bulletPoint5

	bulletPoint5.Parent = hex

	hex.Parent = dropdown4

	rGB = Instance.new("Frame")
	rGB.Name = "RGB"
	rGB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	rGB.BackgroundTransparency = 1
	rGB.LayoutOrder = 8
	rGB.Size = UDim2.new(1, -10, 0, 30)
	rGB.ZIndex = 6

	uICorner43 = Instance.new("UICorner")
	uICorner43.Name = "UICorner"
	uICorner43.Parent = rGB

	example6 = Instance.new("TextLabel")
	example6.Name = "Example"
	example6.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	example6.Text = "RGB: (255,0,0 / text)"
	example6.TextColor3 = Color3.fromRGB(255, 255, 255)
	example6.TextSize = 15
	example6.TextXAlignment = Enum.TextXAlignment.Left
	example6.AutomaticSize = Enum.AutomaticSize.X
	example6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	example6.BackgroundTransparency = 1
	example6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	example6.BorderSizePixel = 0
	example6.Position = UDim2.fromOffset(20, 0)
	example6.Size = UDim2.fromScale(0, 1)
	example6.ZIndex = 10

	uIPadding13 = Instance.new("UIPadding")
	uIPadding13.Name = "UIPadding"
	uIPadding13.PaddingRight = UDim.new(0, 5)
	uIPadding13.Parent = example6

	imageLabel10 = Instance.new("ImageLabel")
	imageLabel10.Name = "ImageLabel"
	imageLabel10.Image = "http://www.roblox.com/asset/?id=6031090995"
	imageLabel10.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel10.BackgroundTransparency = 1
	imageLabel10.BorderSizePixel = 0
	imageLabel10.Position = UDim2.new(1, 5, 0.5, 0)
	imageLabel10.Size = UDim2.fromOffset(20, 20)
	imageLabel10.ZIndex = 10

	formatted6 = Instance.new("TextLabel")
	formatted6.Name = "Formatted"
	formatted6.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	formatted6.RichText = true
	formatted6.Text = "<font color=\"rgb(255,0,0)\">text</font>"
	formatted6.TextColor3 = Color3.fromRGB(255, 255, 255)
	formatted6.TextSize = 15
	formatted6.TextXAlignment = Enum.TextXAlignment.Left
	formatted6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	formatted6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	formatted6.BorderSizePixel = 0
	formatted6.Position = UDim2.new(1, 5, 0, 0)
	formatted6.Size = UDim2.fromScale(0, 1)
	formatted6.ZIndex = 10
	formatted6.Parent = imageLabel10

	imageLabel10.Parent = example6

	example6.Parent = rGB

	bulletPoint6 = Instance.new("Frame")
	bulletPoint6.Name = "BulletPoint"
	bulletPoint6.AnchorPoint = Vector2.new(0, 0.5)
	bulletPoint6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bulletPoint6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	bulletPoint6.BorderSizePixel = 0
	bulletPoint6.Position = UDim2.new(0, 5, 0.5, 0)
	bulletPoint6.Size = UDim2.fromOffset(10, 10)
	bulletPoint6.ZIndex = 9

	ignore21 = Instance.new("UICorner")
	ignore21.Name = "Ignore"
	ignore21.CornerRadius = UDim.new(1, 0)
	ignore21.Parent = bulletPoint6

	bulletPoint6.Parent = rGB

	rGB.Parent = dropdown4

	brickColors = Instance.new("Frame")
	brickColors.Name = "BrickColors"
	brickColors.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	brickColors.BackgroundTransparency = 1
	brickColors.LayoutOrder = 7
	brickColors.Size = UDim2.new(1, -10, 0, 30)
	brickColors.ZIndex = 6

	uICorner44 = Instance.new("UICorner")
	uICorner44.Name = "UICorner"
	uICorner44.Parent = brickColors

	example7 = Instance.new("TextLabel")
	example7.Name = "Example"
	example7.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	example7.Text = "Brick colors: (Really red / text)"
	example7.TextColor3 = Color3.fromRGB(255, 255, 255)
	example7.TextSize = 15
	example7.TextXAlignment = Enum.TextXAlignment.Left
	example7.AutomaticSize = Enum.AutomaticSize.X
	example7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	example7.BackgroundTransparency = 1
	example7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	example7.BorderSizePixel = 0
	example7.Position = UDim2.fromOffset(20, 0)
	example7.Size = UDim2.fromScale(0, 1)
	example7.ZIndex = 10

	uIPadding14 = Instance.new("UIPadding")
	uIPadding14.Name = "UIPadding"
	uIPadding14.PaddingRight = UDim.new(0, 5)
	uIPadding14.Parent = example7

	imageLabel11 = Instance.new("ImageLabel")
	imageLabel11.Name = "ImageLabel"
	imageLabel11.Image = "http://www.roblox.com/asset/?id=6031090995"
	imageLabel11.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel11.BackgroundTransparency = 1
	imageLabel11.BorderSizePixel = 0
	imageLabel11.Position = UDim2.new(1, 5, 0.5, 0)
	imageLabel11.Size = UDim2.fromOffset(20, 20)
	imageLabel11.ZIndex = 10

	formatted7 = Instance.new("TextLabel")
	formatted7.Name = "Formatted"
	formatted7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	formatted7.RichText = true
	formatted7.Text = "<font color=\"rgb(255,0,0)\">text</font>"
	formatted7.TextColor3 = Color3.fromRGB(255, 255, 255)
	formatted7.TextSize = 15
	formatted7.TextXAlignment = Enum.TextXAlignment.Left
	formatted7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	formatted7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	formatted7.BorderSizePixel = 0
	formatted7.Position = UDim2.new(1, 5, 0, 0)
	formatted7.Size = UDim2.fromScale(0, 1)
	formatted7.ZIndex = 10
	formatted7.Parent = imageLabel11

	imageLabel11.Parent = example7

	example7.Parent = brickColors

	bulletPoint7 = Instance.new("Frame")
	bulletPoint7.Name = "BulletPoint"
	bulletPoint7.AnchorPoint = Vector2.new(0, 0.5)
	bulletPoint7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bulletPoint7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	bulletPoint7.BorderSizePixel = 0
	bulletPoint7.Position = UDim2.new(0, 5, 0.5, 0)
	bulletPoint7.Size = UDim2.fromOffset(10, 10)
	bulletPoint7.ZIndex = 9

	ignore22 = Instance.new("UICorner")
	ignore22.Name = "Ignore"
	ignore22.CornerRadius = UDim.new(1, 0)
	ignore22.Parent = bulletPoint7

	bulletPoint7.Parent = brickColors

	brickColors.Parent = dropdown4

	uIListLayout11 = Instance.new("UIListLayout")
	uIListLayout11.Name = "UIListLayout"
	uIListLayout11.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout11.Parent = dropdown4

	dropdown4.Parent = colorFormatting

	colorFormatting.Parent = scroller6

	colorpicker = Instance.new("Frame")
	colorpicker.Name = "Colorpicker"
	colorpicker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	colorpicker.BackgroundTransparency = 1
	colorpicker.ClipsDescendants = true
	colorpicker.Size = UDim2.new(1, -10, 0, 30)
	colorpicker.ZIndex = 6

	cover2 = Instance.new("Frame")
	cover2.Name = "Cover"
	cover2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	cover2.BackgroundTransparency = 0.5
	cover2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	cover2.BorderSizePixel = 0
	cover2.Size = UDim2.new(1, 0, 0, 30)

	uICorner45 = Instance.new("UICorner")
	uICorner45.Name = "UICorner"
	uICorner45.Parent = cover2

	textLabel2 = Instance.new("TextLabel")
	textLabel2.Name = "TextLabel"
	textLabel2.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	textLabel2.Text = "Color picker:"
	textLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel2.TextSize = 14
	textLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel2.BackgroundTransparency = 1
	textLabel2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textLabel2.BorderSizePixel = 0
	textLabel2.Size = UDim2.fromScale(1, 1)
	textLabel2.ZIndex = 8
	textLabel2.Parent = cover2

	drop5 = Instance.new("TextButton")
	drop5.Name = "Drop"
	drop5.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	drop5.Text = ""
	drop5.TextColor3 = Color3.fromRGB(0, 0, 0)
	drop5.TextSize = 14
	drop5.AnchorPoint = Vector2.new(1, 0.5)
	drop5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	drop5.BorderSizePixel = 0
	drop5.Position = UDim2.new(1, -5, 0.5, 0)
	drop5.Size = UDim2.fromOffset(30, 20)
	drop5.ZIndex = 9

	uICorner46 = Instance.new("UICorner")
	uICorner46.Name = "UICorner"
	uICorner46.Parent = drop5

	icon19 = Instance.new("ImageLabel")
	icon19.Name = "Icon"
	icon19.Image = "rbxassetid://8677555693"
	icon19.AnchorPoint = Vector2.new(0.5, 0.5)
	icon19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon19.BackgroundTransparency = 1
	icon19.Position = UDim2.fromScale(0.5, 0.5)
	icon19.Size = UDim2.fromOffset(25, 25)
	icon19.ZIndex = 10
	icon19.Parent = drop5

	drop5.Parent = cover2

	cover2.Parent = colorpicker

	dropdown5 = Instance.new("Frame")
	dropdown5.Name = "Dropdown"
	dropdown5.AutomaticSize = Enum.AutomaticSize.X
	dropdown5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dropdown5.BackgroundTransparency = 1
	dropdown5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	dropdown5.BorderSizePixel = 0
	dropdown5.ClipsDescendants = true
	dropdown5.LayoutOrder = 12
	dropdown5.Position = UDim2.fromOffset(0, 35)
	dropdown5.Size = UDim2.new(1, 0, 0, 235)

	uIListLayout12 = Instance.new("UIListLayout")
	uIListLayout12.Name = "UIListLayout"
	uIListLayout12.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout12.Parent = dropdown5

	colorpicker1 = Instance.new("Frame")
	colorpicker1.Name = "Colorpicker"
	colorpicker1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	colorpicker1.BackgroundTransparency = 1
	colorpicker1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	colorpicker1.BorderSizePixel = 0
	colorpicker1.Size = UDim2.new(1, 0, 0, 235)

	pickerWidget = Instance.new("Frame")
	pickerWidget.Name = "PickerWidget"
	pickerWidget.Active = true
	pickerWidget.AnchorPoint = Vector2.new(1, 0)
	pickerWidget.BackgroundColor3 = Color3.fromRGB(0, 10, 16)
	pickerWidget.BackgroundTransparency = 0.25
	pickerWidget.BorderColor3 = Color3.fromRGB(27, 42, 53)
	pickerWidget.BorderSizePixel = 0
	pickerWidget.Position = UDim2.new(1, -5, 0, 0)
	pickerWidget.Size = UDim2.fromOffset(190, 235)
	pickerWidget.ZIndex = 5

	wheel = Instance.new("ImageButton")
	wheel.Name = "Wheel"
	wheel.Image = "rbxassetid://8733540188"
	wheel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	wheel.BackgroundTransparency = 1
	wheel.Selectable = false
	wheel.Size = UDim2.fromOffset(128, 128)
	wheel.ZIndex = 9

	marker = Instance.new("TextButton")
	marker.Name = "Marker"
	marker.Text = ""
	marker.TextTransparency = 1
	marker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	marker.BackgroundTransparency = 1
	marker.BorderColor3 = Color3.fromRGB(27, 42, 53)
	marker.Position = UDim2.new(0.5, -8, 0.5, -8)
	marker.Selectable = false
	marker.Size = UDim2.fromOffset(17, 17)
	marker.ZIndex = 9

	uICorner47 = Instance.new("UICorner")
	uICorner47.Name = "UICorner"
	uICorner47.CornerRadius = UDim.new(1, 0)
	uICorner47.Parent = marker

	uIStroke = Instance.new("UIStroke")
	uIStroke.Name = "UIStroke"
	uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uIStroke.Thickness = 2
	uIStroke.Parent = marker

	marker.Parent = wheel

	wheel.Parent = pickerWidget

	slider = Instance.new("Frame")
	slider.Name = "Slider"
	slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	slider.BorderColor3 = Color3.fromRGB(27, 42, 53)
	slider.BorderSizePixel = 3
	slider.Position = UDim2.fromOffset(140, 0)
	slider.Size = UDim2.fromOffset(30, 128)
	slider.ZIndex = 9

	drag = Instance.new("TextButton")
	drag.Name = "Drag"
	drag.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	drag.Text = ""
	drag.TextColor3 = Color3.fromRGB(0, 0, 0)
	drag.TextSize = 14
	drag.Active = false
	drag.AnchorPoint = Vector2.new(0, 1)
	drag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	drag.BorderColor3 = Color3.fromRGB(27, 42, 53)
	drag.BorderSizePixel = 3
	drag.Position = UDim2.fromOffset(0, 10)
	drag.Selectable = false
	drag.Size = UDim2.fromOffset(30, 10)
	drag.ZIndex = 9

	uICorner48 = Instance.new("UICorner")
	uICorner48.Name = "UICorner"
	uICorner48.Parent = drag

	uIStroke1 = Instance.new("UIStroke")
	uIStroke1.Name = "UIStroke"
	uIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uIStroke1.Color = Color3.fromRGB(200, 200, 200)
	uIStroke1.Thickness = 2
	uIStroke1.Parent = drag

	drag.Parent = slider

	gradient = Instance.new("UIGradient")
	gradient.Name = "Gradient"
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(242, 242, 0)),
		ColorSequenceKeypoint.new(0.1, Color3.fromRGB(229, 229, 0)),
		ColorSequenceKeypoint.new(0.15, Color3.fromRGB(217, 217, 0)),
		ColorSequenceKeypoint.new(0.2, Color3.fromRGB(204, 204, 0)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(191, 191, 0)),
		ColorSequenceKeypoint.new(0.3, Color3.fromRGB(178, 178, 0)),
		ColorSequenceKeypoint.new(0.35, Color3.fromRGB(166, 166, 0)),
		ColorSequenceKeypoint.new(0.4, Color3.fromRGB(153, 153, 0)),
		ColorSequenceKeypoint.new(0.45, Color3.fromRGB(140, 140, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(128, 128, 0)),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(115, 115, 0)),
		ColorSequenceKeypoint.new(0.6, Color3.fromRGB(102, 102, 0)),
		ColorSequenceKeypoint.new(0.65, Color3.fromRGB(89, 89, 0)),
		ColorSequenceKeypoint.new(0.7, Color3.fromRGB(77, 77, 0)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(64, 64, 0)),
		ColorSequenceKeypoint.new(0.8, Color3.fromRGB(51, 51, 0)),
		ColorSequenceKeypoint.new(0.85, Color3.fromRGB(38, 38, 0)),
		ColorSequenceKeypoint.new(0.9, Color3.fromRGB(26, 26, 0)),
		ColorSequenceKeypoint.new(0.95, Color3.fromRGB(13, 13, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
	})
	gradient.Rotation = 90
	gradient.Parent = slider

	uICorner49 = Instance.new("UICorner")
	uICorner49.Name = "UICorner"
	uICorner49.Parent = slider

	slider.Parent = pickerWidget

	uIPadding15 = Instance.new("UIPadding")
	uIPadding15.Name = "UIPadding"
	uIPadding15.PaddingBottom = UDim.new(0, 20)
	uIPadding15.PaddingLeft = UDim.new(0, 10)
	uIPadding15.PaddingRight = UDim.new(0, 10)
	uIPadding15.PaddingTop = UDim.new(0, 10)
	uIPadding15.Parent = pickerWidget

	options3 = Instance.new("Frame")
	options3.Name = "Options"
	options3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	options3.BackgroundTransparency = 1
	options3.BorderColor3 = Color3.fromRGB(27, 42, 53)
	options3.BorderSizePixel = 0
	options3.Position = UDim2.fromOffset(0, 155)
	options3.Size = UDim2.new(1, 0, 0, 30)
	options3.ZIndex = 9

	r = Instance.new("TextBox")
	r.Name = "R"
	r.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	r.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
	r.PlaceholderText = "..."
	r.Text = "255"
	r.TextColor3 = Color3.fromRGB(255, 255, 255)
	r.TextSize = 14
	r.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	r.BorderColor3 = Color3.fromRGB(27, 42, 53)
	r.BorderSizePixel = 0
	r.Size = UDim2.fromOffset(50, 25)
	r.ZIndex = 9

	uICorner50 = Instance.new("UICorner")
	uICorner50.Name = "UICorner"
	uICorner50.CornerRadius = UDim.new(0, 5)
	uICorner50.Parent = r

	textLabel3 = Instance.new("TextLabel")
	textLabel3.Name = "TextLabel"
	textLabel3.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	textLabel3.Text = "R"
	textLabel3.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel3.TextSize = 12
	textLabel3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel3.BackgroundTransparency = 1
	textLabel3.BorderColor3 = Color3.fromRGB(27, 42, 53)
	textLabel3.Position = UDim2.new(0, 0, -1, 2)
	textLabel3.Size = UDim2.new(1, 0, 0, 20)
	textLabel3.ZIndex = 9
	textLabel3.Parent = r

	r.Parent = options3

	uIListLayout13 = Instance.new("UIListLayout")
	uIListLayout13.Name = "UIListLayout"
	uIListLayout13.Padding = UDim.new(0, 10)
	uIListLayout13.FillDirection = Enum.FillDirection.Horizontal
	uIListLayout13.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout13.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout13.VerticalAlignment = Enum.VerticalAlignment.Center
	uIListLayout13.Parent = options3

	g = Instance.new("TextBox")
	g.Name = "G"
	g.CursorPosition = -1
	g.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	g.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
	g.PlaceholderText = "..."
	g.Text = "255"
	g.TextColor3 = Color3.fromRGB(255, 255, 255)
	g.TextSize = 14
	g.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	g.BorderColor3 = Color3.fromRGB(27, 42, 53)
	g.BorderSizePixel = 0
	g.Size = UDim2.fromOffset(50, 25)
	g.ZIndex = 9

	uICorner51 = Instance.new("UICorner")
	uICorner51.Name = "UICorner"
	uICorner51.CornerRadius = UDim.new(0, 5)
	uICorner51.Parent = g

	textLabel4 = Instance.new("TextLabel")
	textLabel4.Name = "TextLabel"
	textLabel4.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	textLabel4.Text = "G"
	textLabel4.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel4.TextSize = 12
	textLabel4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel4.BackgroundTransparency = 1
	textLabel4.BorderColor3 = Color3.fromRGB(27, 42, 53)
	textLabel4.Position = UDim2.new(0, 0, -1, 2)
	textLabel4.Size = UDim2.new(1, 0, 0, 20)
	textLabel4.ZIndex = 9
	textLabel4.Parent = g

	g.Parent = options3

	b = Instance.new("TextBox")
	b.Name = "B"
	b.CursorPosition = -1
	b.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	b.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
	b.PlaceholderText = "..."
	b.Text = "255"
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	b.TextSize = 14
	b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	b.BorderColor3 = Color3.fromRGB(27, 42, 53)
	b.BorderSizePixel = 0
	b.Size = UDim2.fromOffset(50, 25)
	b.ZIndex = 9

	uICorner52 = Instance.new("UICorner")
	uICorner52.Name = "UICorner"
	uICorner52.CornerRadius = UDim.new(0, 5)
	uICorner52.Parent = b

	textLabel5 = Instance.new("TextLabel")
	textLabel5.Name = "TextLabel"
	textLabel5.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	textLabel5.Text = "B"
	textLabel5.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel5.TextSize = 12
	textLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel5.BackgroundTransparency = 1
	textLabel5.BorderColor3 = Color3.fromRGB(27, 42, 53)
	textLabel5.Position = UDim2.new(0, 0, -1, 2)
	textLabel5.Size = UDim2.new(1, 0, 0, 20)
	textLabel5.ZIndex = 9
	textLabel5.Parent = b

	b.Parent = options3

	options3.Parent = pickerWidget

	uICorner53 = Instance.new("UICorner")
	uICorner53.Name = "UICorner"
	uICorner53.Parent = pickerWidget

	hex1 = Instance.new("Frame")
	hex1.Name = "Hex"
	hex1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	hex1.BackgroundTransparency = 1
	hex1.BorderColor3 = Color3.fromRGB(27, 42, 53)
	hex1.BorderSizePixel = 0
	hex1.Position = UDim2.fromOffset(0, 190)
	hex1.Size = UDim2.new(1, 0, 0, 30)
	hex1.ZIndex = 9

	value = Instance.new("TextBox")
	value.Name = "Value"
	value.ClearTextOnFocus = false
	value.CursorPosition = -1
	value.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	value.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
	value.PlaceholderText = "..."
	value.Text = "#FFFFFF"
	value.TextColor3 = Color3.fromRGB(255, 255, 255)
	value.TextSize = 14
	value.AnchorPoint = Vector2.new(0.5, 0.5)
	value.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	value.BorderColor3 = Color3.fromRGB(27, 42, 53)
	value.BorderSizePixel = 0
	value.Position = UDim2.fromScale(0.5, 0.5)
	value.Size = UDim2.fromOffset(170, 25)
	value.ZIndex = 9

	uICorner54 = Instance.new("UICorner")
	uICorner54.Name = "UICorner"
	uICorner54.CornerRadius = UDim.new(0, 5)
	uICorner54.Parent = value

	value.Parent = hex1

	hex1.Parent = pickerWidget

	pickerWidget.Parent = colorpicker1

	options4 = Instance.new("Frame")
	options4.Name = "Options"
	options4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	options4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	options4.BorderSizePixel = 0
	options4.Size = UDim2.new(1, -200, 0, 0)

	uIListLayout14 = Instance.new("UIListLayout")
	uIListLayout14.Name = "UIListLayout"
	uIListLayout14.Padding = UDim.new(0, 5)
	uIListLayout14.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout14.Parent = options4

	picker = Instance.new("TextButton")
	picker.Name = "Picker"
	picker.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	picker.Text = "Color picker"
	picker.TextColor3 = Color3.fromRGB(255, 255, 255)
	picker.TextSize = 14
	picker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	picker.BackgroundTransparency = 0.5
	picker.BorderColor3 = Color3.fromRGB(0, 0, 0)
	picker.BorderSizePixel = 0
	picker.Size = UDim2.new(1, 0, 0, 25)
	picker.ZIndex = 10

	uICorner55 = Instance.new("UICorner")
	uICorner55.Name = "UICorner"
	uICorner55.Parent = picker

	picker.Parent = options4

	picker1 = Instance.new("TextButton")
	picker1.Name = "Picker"
	picker1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	picker1.Text = "Brick colors"
	picker1.TextColor3 = Color3.fromRGB(255, 255, 255)
	picker1.TextSize = 14
	picker1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	picker1.BackgroundTransparency = 0.5
	picker1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	picker1.BorderSizePixel = 0
	picker1.Size = UDim2.new(1, 0, 0, 25)
	picker1.ZIndex = 10

	uICorner56 = Instance.new("UICorner")
	uICorner56.Name = "UICorner"
	uICorner56.Parent = picker1

	picker1.Parent = options4

	options4.Parent = colorpicker1

	brickColors1 = Instance.new("Frame")
	brickColors1.Name = "BrickColors"
	brickColors1.Active = true
	brickColors1.AnchorPoint = Vector2.new(1, 0)
	brickColors1.BackgroundColor3 = Color3.fromRGB(0, 10, 16)
	brickColors1.BackgroundTransparency = 0.25
	brickColors1.BorderColor3 = Color3.fromRGB(27, 42, 53)
	brickColors1.BorderSizePixel = 0
	brickColors1.Position = UDim2.new(1, -5, 0, 0)
	brickColors1.Size = UDim2.fromOffset(190, 235)
	brickColors1.Visible = false
	brickColors1.ZIndex = 5

	uICorner57 = Instance.new("UICorner")
	uICorner57.Name = "UICorner"
	uICorner57.Parent = brickColors1

	scroller7 = Instance.new("ScrollingFrame")
	scroller7.Name = "Scroller"
	scroller7.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroller7.BottomImage = "rbxassetid://8082116996"
	scroller7.CanvasSize = UDim2.new()
	scroller7.MidImage = "rbxassetid://7488333553"
	scroller7.ScrollBarThickness = 5
	scroller7.TopImage = "rbxassetid://8082122989"
	scroller7.AnchorPoint = Vector2.new(0.5, 0)
	scroller7.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	scroller7.BackgroundTransparency = 1
	scroller7.BorderSizePixel = 0
	scroller7.Position = UDim2.new(0.5, 0, 0, 35)
	scroller7.Selectable = false
	scroller7.Size = UDim2.new(1, -10, 1, -40)
	scroller7.ZIndex = 6

	uIListLayout15 = Instance.new("UIListLayout")
	uIListLayout15.Name = "UIListLayout"
	uIListLayout15.Padding = UDim.new(0, 5)
	uIListLayout15.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout15.Parent = scroller7

	brickColor = Instance.new("Frame")
	brickColor.Name = "BrickColor"
	brickColor.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	brickColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
	brickColor.BorderSizePixel = 0
	brickColor.Size = UDim2.new(1, -10, 0, 25)
	brickColor.ZIndex = 10

	colorPreview = Instance.new("Frame")
	colorPreview.Name = "ColorPreview"
	colorPreview.AnchorPoint = Vector2.new(1, 0.5)
	colorPreview.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
	colorPreview.BorderColor3 = Color3.fromRGB(0, 0, 0)
	colorPreview.BorderSizePixel = 0
	colorPreview.Position = UDim2.new(1, -2, 0.5, 0)
	colorPreview.Size = UDim2.fromOffset(20, 20)
	colorPreview.ZIndex = 10

	uICorner58 = Instance.new("UICorner")
	uICorner58.Name = "UICorner"
	uICorner58.Parent = colorPreview

	colorPreview.Parent = brickColor

	textBox = Instance.new("TextBox")
	textBox.Name = "TextBox"
	textBox.ClearTextOnFocus = false
	textBox.CursorPosition = -1
	textBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	textBox.Text = "Test"
	textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	textBox.TextEditable = false
	textBox.TextSize = 13
	textBox.TextTruncate = Enum.TextTruncate.AtEnd
	textBox.TextXAlignment = Enum.TextXAlignment.Left
	textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textBox.BackgroundTransparency = 1
	textBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textBox.BorderSizePixel = 0
	textBox.Position = UDim2.fromOffset(5, 0)
	textBox.Size = UDim2.new(1, -25, 1, 0)
	textBox.ZIndex = 10
	textBox.Parent = brickColor

	uICorner59 = Instance.new("UICorner")
	uICorner59.Name = "UICorner"
	uICorner59.Parent = brickColor

	brickColor.Parent = scroller7

	scroller7.Parent = brickColors1

	searchbar = Instance.new("Frame")
	searchbar.Name = "Searchbar"
	searchbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	searchbar.BackgroundTransparency = 1
	searchbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	searchbar.BorderSizePixel = 0
	searchbar.Size = UDim2.new(1, 0, 0, 30)

	box1 = Instance.new("TextBox")
	box1.Name = "Box"
	box1.CursorPosition = -1
	box1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	box1.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
	box1.PlaceholderText = "Search here"
	box1.Text = ""
	box1.TextColor3 = Color3.fromRGB(255, 255, 255)
	box1.TextSize = 12
	box1.TextTruncate = Enum.TextTruncate.AtEnd
	box1.TextXAlignment = Enum.TextXAlignment.Left
	box1.AnchorPoint = Vector2.new(0, 0.5)
	box1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	box1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	box1.BorderSizePixel = 0
	box1.Position = UDim2.new(0, 5, 0.5, 0)
	box1.Size = UDim2.new(1, -10, 1, -10)
	box1.ZIndex = 10

	uICorner60 = Instance.new("UICorner")
	uICorner60.Name = "UICorner"
	uICorner60.Parent = box1

	uIPadding16 = Instance.new("UIPadding")
	uIPadding16.Name = "UIPadding"
	uIPadding16.PaddingBottom = UDim.new(0, 5)
	uIPadding16.PaddingLeft = UDim.new(0, 5)
	uIPadding16.PaddingRight = UDim.new(0, 25)
	uIPadding16.PaddingTop = UDim.new(0, 5)
	uIPadding16.Parent = box1

	box1.Parent = searchbar

	imageLabel12 = Instance.new("ImageLabel")
	imageLabel12.Name = "ImageLabel"
	imageLabel12.Image = "http://www.roblox.com/asset/?id=6031154871"
	imageLabel12.AnchorPoint = Vector2.new(1, 0.5)
	imageLabel12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	imageLabel12.BackgroundTransparency = 1
	imageLabel12.BorderColor3 = Color3.fromRGB(0, 0, 0)
	imageLabel12.BorderSizePixel = 0
	imageLabel12.Position = UDim2.new(1, -10, 0.5, 0)
	imageLabel12.Size = UDim2.fromOffset(20, 20)
	imageLabel12.ZIndex = 10
	imageLabel12.Parent = searchbar

	searchbar.Parent = brickColors1

	brickColors1.Parent = colorpicker1

	colorpicker1.Parent = dropdown5

	dropdown5.Parent = colorpicker

	colorpicker.Parent = scroller6

	scroller6.Parent = help1

	help1.Parent = pages

	pages.Parent = settings

	settings.Parent = chat

	saveChat = Instance.new("Frame")
	saveChat.Name = "SaveChat"
	saveChat.AnchorPoint = Vector2.new(0.5, 0.5)
	saveChat.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	saveChat.BackgroundTransparency = 0.5
	saveChat.BorderSizePixel = 0
	saveChat.Position = UDim2.fromScale(0.5, -1.5)
	saveChat.Size = UDim2.fromOffset(150, 240)

	container5 = Instance.new("ScrollingFrame")
	container5.Name = "Container"
	container5.BottomImage = "rbxassetid://8082116996"
	container5.CanvasSize = UDim2.new()
	container5.MidImage = "rbxassetid://7488333553"
	container5.ScrollBarThickness = 5
	container5.TopImage = "rbxassetid://8082122989"
	container5.AnchorPoint = Vector2.new(0.5, 1)
	container5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	container5.BackgroundTransparency = 1
	container5.BorderSizePixel = 0
	container5.Position = UDim2.new(0.5, 0, 1, -5)
	container5.Selectable = false
	container5.Size = UDim2.new(0, 140, 1, -45)

	uIListLayout16 = Instance.new("UIListLayout")
	uIListLayout16.Name = "UIListLayout"
	uIListLayout16.Padding = UDim.new(0, 2)
	uIListLayout16.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout16.Parent = container5

	slot = Instance.new("TextButton")
	slot.Name = "Slot"
	slot.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	slot.Text = "Slot 0"
	slot.TextColor3 = Color3.fromRGB(255, 255, 255)
	slot.TextSize = 14
	slot.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	slot.BorderSizePixel = 0
	slot.Size = UDim2.new(1, -10, 0, 25)

	uICorner61 = Instance.new("UICorner")
	uICorner61.Name = "UICorner"
	uICorner61.Parent = slot

	slot.Parent = container5

	container5.Parent = saveChat

	uICorner62 = Instance.new("UICorner")
	uICorner62.Name = "UICorner"
	uICorner62.Parent = saveChat

	header = Instance.new("Frame")
	header.Name = "Header"
	header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	header.BackgroundTransparency = 1
	header.ClipsDescendants = true
	header.Size = UDim2.new(1, 0, 0, 35)

	uI2 = Instance.new("Frame")
	uI2.Name = "UI"
	uI2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	uI2.Size = UDim2.fromScale(1, 1)

	close1 = Instance.new("TextButton")
	close1.Name = "Close"
	close1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	close1.Text = ""
	close1.TextColor3 = Color3.fromRGB(0, 0, 0)
	close1.TextSize = 14
	close1.AnchorPoint = Vector2.new(1, 0)
	close1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	close1.BackgroundTransparency = 1
	close1.BorderSizePixel = 0
	close1.Position = UDim2.new(1, -5, 0, 5)
	close1.Size = UDim2.fromOffset(25, 25)
	close1.ZIndex = 5

	imageLabel13 = Instance.new("ImageLabel")
	imageLabel13.Name = "ImageLabel"
	imageLabel13.Image = "http://www.roblox.com/asset/?id=6031094678"
	imageLabel13.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	imageLabel13.BackgroundTransparency = 1
	imageLabel13.Position = UDim2.fromScale(0.5, 0.5)
	imageLabel13.Size = UDim2.fromOffset(20, 20)
	imageLabel13.ZIndex = 6
	imageLabel13.Parent = close1

	uICorner63 = Instance.new("UICorner")
	uICorner63.Name = "UICorner"
	uICorner63.Parent = close1

	close1.Parent = uI2

	title13 = Instance.new("TextLabel")
	title13.Name = "Title"
	title13.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	title13.Text = "Save Chat"
	title13.TextColor3 = Color3.fromRGB(255, 255, 255)
	title13.TextSize = 14
	title13.TextXAlignment = Enum.TextXAlignment.Left
	title13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title13.BackgroundTransparency = 1
	title13.Position = UDim2.fromOffset(5, 5)
	title13.Size = UDim2.new(1, 0, 0, 25)
	title13.ZIndex = 8
	title13.Parent = uI2

	uI2.Parent = header

	header.Parent = saveChat

	saveChat.Parent = chat
	return chat
end