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

	uICorner10 = Instance.new("UICorner")
	uICorner10.Name = "UICorner"
	uICorner10.Parent = close

	icon4 = Instance.new("ImageLabel")
	icon4.Name = "Icon"
	icon4.Image = "http://www.roblox.com/asset/?id=6031094678"
	icon4.AnchorPoint = Vector2.new(0.5, 0.5)
	icon4.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	icon4.BackgroundTransparency = 1
	icon4.BorderSizePixel = 0
	icon4.Position = UDim2.fromScale(0.5, 0.5)
	icon4.Selectable = true
	icon4.Size = UDim2.fromOffset(25, 25)
	icon4.ZIndex = 8
	icon4.Parent = close

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

	uICorner11 = Instance.new("UICorner")
	uICorner11.Name = "UICorner"
	uICorner11.Parent = back

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

	icon5 = Instance.new("ImageLabel")
	icon5.Name = "Icon"
	icon5.Image = "rbxassetid://8677222862"
	icon5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon5.BackgroundTransparency = 1
	icon5.Size = UDim2.fromOffset(20, 20)
	icon5.ZIndex = 6
	icon5.Parent = title2

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

	uICorner12 = Instance.new("UICorner")
	uICorner12.Name = "UICorner"
	uICorner12.Parent = amount

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

	uICorner13 = Instance.new("UICorner")
	uICorner13.Name = "UICorner"
	uICorner13.Parent = textSize

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

	icon6 = Instance.new("ImageLabel")
	icon6.Name = "Icon"
	icon6.Image = "rbxassetid://8677280864"
	icon6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon6.BackgroundTransparency = 1
	icon6.Size = UDim2.fromOffset(20, 20)
	icon6.ZIndex = 6
	icon6.Parent = title3

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

	uICorner14 = Instance.new("UICorner")
	uICorner14.Name = "UICorner"
	uICorner14.Parent = amount1

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

	uICorner15 = Instance.new("UICorner")
	uICorner15.Name = "UICorner"
	uICorner15.Parent = roundness

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

	icon7 = Instance.new("ImageLabel")
	icon7.Name = "Icon"
	icon7.Image = "rbxassetid://8571348189"
	icon7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon7.BackgroundTransparency = 1
	icon7.Size = UDim2.fromOffset(20, 20)
	icon7.ZIndex = 6
	icon7.Parent = title4

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

	uICorner16 = Instance.new("UICorner")
	uICorner16.Name = "UICorner"
	uICorner16.Parent = resizable

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

	chatbarFont = Instance.new("Frame")
	chatbarFont.Name = "ChatbarFont"
	chatbarFont.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	chatbarFont.BackgroundTransparency = 1
	chatbarFont.ClipsDescendants = true
	chatbarFont.LayoutOrder = 1
	chatbarFont.Size = UDim2.new(1, -10, 0, 30)
	chatbarFont.ZIndex = 6

	title5 = Instance.new("Frame")
	title5.Name = "Title"
	title5.AnchorPoint = Vector2.new(0.5, 0.5)
	title5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title5.BackgroundTransparency = 1
	title5.BorderSizePixel = 0
	title5.Position = UDim2.new(0.5, 0, 0, 15)
	title5.Size = UDim2.new(0.95, 0, 0, 20)
	title5.ZIndex = 8

	icon8 = Instance.new("ImageLabel")
	icon8.Name = "Icon"
	icon8.Image = "rbxassetid://8678012976"
	icon8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon8.BackgroundTransparency = 1
	icon8.Size = UDim2.fromOffset(20, 20)
	icon8.ZIndex = 9
	icon8.Parent = title5

	label4 = Instance.new("TextLabel")
	label4.Name = "Label"
	label4.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label4.Text = "Chatbar Font"
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

	uICorner17 = Instance.new("UICorner")
	uICorner17.Name = "UICorner"
	uICorner17.Parent = drop

	icon9 = Instance.new("ImageLabel")
	icon9.Name = "Icon"
	icon9.Image = "rbxassetid://8677555693"
	icon9.AnchorPoint = Vector2.new(0.5, 0.5)
	icon9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon9.BackgroundTransparency = 1
	icon9.Position = UDim2.fromScale(0.5, 0.5)
	icon9.Size = UDim2.fromOffset(25, 25)
	icon9.ZIndex = 10
	icon9.Parent = drop

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

	title5.Parent = chatbarFont

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

	uICorner18 = Instance.new("UICorner")
	uICorner18.Name = "UICorner"
	uICorner18.Parent = main3

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

	topContainer.Parent = chatbarFont

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

	uICorner19 = Instance.new("UICorner")
	uICorner19.Name = "UICorner"
	uICorner19.Parent = rounded1

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

	dropdown.Parent = chatbarFont

	chatbarFont.Parent = scroller3

	textFont = Instance.new("Frame")
	textFont.Name = "TextFont"
	textFont.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textFont.BackgroundTransparency = 1
	textFont.ClipsDescendants = true
	textFont.LayoutOrder = 1
	textFont.Size = UDim2.new(1, -10, 0, 30)
	textFont.ZIndex = 6

	title6 = Instance.new("Frame")
	title6.Name = "Title"
	title6.AnchorPoint = Vector2.new(0.5, 0.5)
	title6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title6.BackgroundTransparency = 1
	title6.BorderSizePixel = 0
	title6.Position = UDim2.new(0.5, 0, 0, 15)
	title6.Size = UDim2.new(0.95, 0, 0, 20)
	title6.ZIndex = 8

	icon10 = Instance.new("ImageLabel")
	icon10.Name = "Icon"
	icon10.Image = "rbxassetid://8678012976"
	icon10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon10.BackgroundTransparency = 1
	icon10.Size = UDim2.fromOffset(20, 20)
	icon10.ZIndex = 9
	icon10.Parent = title6

	label5 = Instance.new("TextLabel")
	label5.Name = "Label"
	label5.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label5.Text = "Text Font"
	label5.TextColor3 = Color3.fromRGB(255, 255, 255)
	label5.TextSize = 14
	label5.TextXAlignment = Enum.TextXAlignment.Left
	label5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label5.BackgroundTransparency = 1
	label5.Position = UDim2.fromOffset(25, 0)
	label5.Size = UDim2.fromOffset(0, 18)
	label5.ZIndex = 9
	label5.Parent = title6

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

	uICorner20 = Instance.new("UICorner")
	uICorner20.Name = "UICorner"
	uICorner20.Parent = drop1

	icon11 = Instance.new("ImageLabel")
	icon11.Name = "Icon"
	icon11.Image = "rbxassetid://8677555693"
	icon11.AnchorPoint = Vector2.new(0.5, 0.5)
	icon11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon11.BackgroundTransparency = 1
	icon11.Position = UDim2.fromScale(0.5, 0.5)
	icon11.Size = UDim2.fromOffset(25, 25)
	icon11.ZIndex = 10
	icon11.Parent = drop1

	drop1.Parent = title6

	selected1 = Instance.new("TextLabel")
	selected1.Name = "Selected"
	selected1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	selected1.Text = "GothamMedium"
	selected1.TextColor3 = Color3.fromRGB(200, 200, 200)
	selected1.TextSize = 14
	selected1.TextXAlignment = Enum.TextXAlignment.Right
	selected1.AnchorPoint = Vector2.new(1, 0.5)
	selected1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	selected1.BackgroundTransparency = 1
	selected1.Position = UDim2.new(1, -35, 0.5, 0)
	selected1.Size = UDim2.fromOffset(0, 18)
	selected1.ZIndex = 9
	selected1.Parent = title6

	title6.Parent = textFont

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

	uICorner21 = Instance.new("UICorner")
	uICorner21.Name = "UICorner"
	uICorner21.Parent = main4

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

	topContainer1.Parent = textFont

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

	uICorner22 = Instance.new("UICorner")
	uICorner22.Name = "UICorner"
	uICorner22.Parent = rounded2

	rounded2.Parent = bottomContainer1

	bottomContainer1.Parent = dropdown1

	options1 = Instance.new("Frame")
	options1.Name = "Options"
	options1.AutomaticSize = Enum.AutomaticSize.Y
	options1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	options1.BackgroundTransparency = 1
	options1.Size = UDim2.fromScale(1, 0)
	options1.ZIndex = 6

	uIListLayout5 = Instance.new("UIListLayout")
	uIListLayout5.Name = "UIListLayout"
	uIListLayout5.Padding = UDim.new(0, 3)
	uIListLayout5.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout5.Parent = options1

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

	dropdown1.Parent = textFont

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

	title7 = Instance.new("TextLabel")
	title7.Name = "Title"
	title7.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	title7.Text = "Bubble Chat"
	title7.TextColor3 = Color3.fromRGB(255, 255, 255)
	title7.TextSize = 20
	title7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title7.BackgroundTransparency = 1
	title7.Position = UDim2.fromOffset(0, 5)
	title7.Size = UDim2.new(1, 0, 0, 30)
	title7.ZIndex = 6

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

	uICorner23 = Instance.new("UICorner")
	uICorner23.Name = "UICorner"
	uICorner23.Parent = back1

	back1.Parent = title7

	title7.Parent = bubbleChat1

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

	uIListLayout6 = Instance.new("UIListLayout")
	uIListLayout6.Name = "UIListLayout"
	uIListLayout6.Padding = UDim.new(0, 5)
	uIListLayout6.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout6.Parent = scroller4

	animationStyle = Instance.new("Frame")
	animationStyle.Name = "AnimationStyle"
	animationStyle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	animationStyle.BackgroundTransparency = 1
	animationStyle.ClipsDescendants = true
	animationStyle.Size = UDim2.new(1, -10, 0, 30)
	animationStyle.ZIndex = 6

	title8 = Instance.new("Frame")
	title8.Name = "Title"
	title8.AnchorPoint = Vector2.new(0.5, 0.5)
	title8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title8.BackgroundTransparency = 1
	title8.BorderSizePixel = 0
	title8.Position = UDim2.new(0.5, 0, 0, 15)
	title8.Size = UDim2.new(0.95, 0, 0, 20)
	title8.ZIndex = 8

	icon12 = Instance.new("ImageLabel")
	icon12.Name = "Icon"
	icon12.Image = "rbxassetid://8677960616"
	icon12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon12.BackgroundTransparency = 1
	icon12.Size = UDim2.fromOffset(20, 20)
	icon12.ZIndex = 9
	icon12.Parent = title8

	label6 = Instance.new("TextLabel")
	label6.Name = "Label"
	label6.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label6.Text = "Animation Style"
	label6.TextColor3 = Color3.fromRGB(255, 255, 255)
	label6.TextSize = 14
	label6.TextXAlignment = Enum.TextXAlignment.Left
	label6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label6.BackgroundTransparency = 1
	label6.Position = UDim2.fromOffset(25, 0)
	label6.Size = UDim2.fromOffset(0, 18)
	label6.ZIndex = 9
	label6.Parent = title8

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

	uICorner24 = Instance.new("UICorner")
	uICorner24.Name = "UICorner"
	uICorner24.Parent = drop2

	icon13 = Instance.new("ImageLabel")
	icon13.Name = "Icon"
	icon13.Image = "rbxassetid://8677555693"
	icon13.AnchorPoint = Vector2.new(0.5, 0.5)
	icon13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon13.BackgroundTransparency = 1
	icon13.Position = UDim2.fromScale(0.5, 0.5)
	icon13.Size = UDim2.fromOffset(25, 25)
	icon13.ZIndex = 10
	icon13.Parent = drop2

	drop2.Parent = title8

	selected2 = Instance.new("TextLabel")
	selected2.Name = "Selected"
	selected2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	selected2.Text = "Linear"
	selected2.TextColor3 = Color3.fromRGB(200, 200, 200)
	selected2.TextSize = 14
	selected2.TextXAlignment = Enum.TextXAlignment.Right
	selected2.AnchorPoint = Vector2.new(1, 0.5)
	selected2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	selected2.BackgroundTransparency = 1
	selected2.Position = UDim2.new(1, -35, 0.5, 0)
	selected2.Size = UDim2.fromOffset(0, 18)
	selected2.ZIndex = 9
	selected2.Parent = title8

	title8.Parent = animationStyle

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

	uICorner25 = Instance.new("UICorner")
	uICorner25.Name = "UICorner"
	uICorner25.Parent = main5

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

	topContainer2.Parent = animationStyle

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

	uICorner26 = Instance.new("UICorner")
	uICorner26.Name = "UICorner"
	uICorner26.Parent = rounded3

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

	uIPadding5 = Instance.new("UIPadding")
	uIPadding5.Name = "UIPadding"
	uIPadding5.PaddingBottom = UDim.new(0, 55)
	uIPadding5.Parent = dropdown2

	frame2 = Instance.new("Frame")
	frame2.Name = "Frame"
	frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame2.BackgroundTransparency = 0.35
	frame2.BorderSizePixel = 0
	frame2.Size = UDim2.new(1, 0, 1, -20)
	frame2.ZIndex = 6
	frame2.Parent = dropdown2

	dropdown2.Parent = animationStyle

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

	title9 = Instance.new("Frame")
	title9.Name = "Title"
	title9.AnchorPoint = Vector2.new(0.5, 0)
	title9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title9.BackgroundTransparency = 1
	title9.BorderSizePixel = 0
	title9.Position = UDim2.fromScale(0.5, 0)
	title9.Size = UDim2.new(0.95, 0, 0, 20)
	title9.ZIndex = 6

	icon14 = Instance.new("ImageLabel")
	icon14.Name = "Icon"
	icon14.Image = "rbxassetid://8677983647"
	icon14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon14.BackgroundTransparency = 1
	icon14.Size = UDim2.fromOffset(20, 20)
	icon14.ZIndex = 6
	icon14.Parent = title9

	label7 = Instance.new("TextLabel")
	label7.Name = "Label"
	label7.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label7.Text = "Fade Time"
	label7.TextColor3 = Color3.fromRGB(255, 255, 255)
	label7.TextSize = 14
	label7.TextXAlignment = Enum.TextXAlignment.Left
	label7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label7.BackgroundTransparency = 1
	label7.Position = UDim2.fromOffset(25, 0)
	label7.Size = UDim2.new(0.5, 0, 0, 18)
	label7.ZIndex = 6
	label7.Parent = title9

	title9.Parent = center2

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

	uICorner27 = Instance.new("UICorner")
	uICorner27.Name = "UICorner"
	uICorner27.Parent = amount2

	uIPadding6 = Instance.new("UIPadding")
	uIPadding6.Name = "UIPadding"
	uIPadding6.PaddingLeft = UDim.new(0, 5)
	uIPadding6.PaddingRight = UDim.new(0, 5)
	uIPadding6.Parent = amount2

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

	uICorner28 = Instance.new("UICorner")
	uICorner28.Name = "UICorner"
	uICorner28.Parent = fadeoutTime

	fadeoutTime.Parent = scroller4

	font = Instance.new("Frame")
	font.Name = "Font"
	font.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	font.BackgroundTransparency = 1
	font.ClipsDescendants = true
	font.LayoutOrder = 1
	font.Size = UDim2.new(1, -10, 0, 30)
	font.ZIndex = 6

	title10 = Instance.new("Frame")
	title10.Name = "Title"
	title10.AnchorPoint = Vector2.new(0.5, 0.5)
	title10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title10.BackgroundTransparency = 1
	title10.BorderSizePixel = 0
	title10.Position = UDim2.new(0.5, 0, 0, 15)
	title10.Size = UDim2.new(0.95, 0, 0, 20)
	title10.ZIndex = 8

	icon15 = Instance.new("ImageLabel")
	icon15.Name = "Icon"
	icon15.Image = "rbxassetid://8678012976"
	icon15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon15.BackgroundTransparency = 1
	icon15.Size = UDim2.fromOffset(20, 20)
	icon15.ZIndex = 9
	icon15.Parent = title10

	label8 = Instance.new("TextLabel")
	label8.Name = "Label"
	label8.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label8.Text = "Font"
	label8.TextColor3 = Color3.fromRGB(255, 255, 255)
	label8.TextSize = 14
	label8.TextXAlignment = Enum.TextXAlignment.Left
	label8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label8.BackgroundTransparency = 1
	label8.Position = UDim2.fromOffset(25, 0)
	label8.Size = UDim2.fromOffset(0, 18)
	label8.ZIndex = 9
	label8.Parent = title10

	drop3 = Instance.new("TextButton")
	drop3.Name = "Drop"
	drop3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	drop3.Text = ""
	drop3.TextColor3 = Color3.fromRGB(0, 0, 0)
	drop3.TextSize = 14
	drop3.AnchorPoint = Vector2.new(1, 0)
	drop3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	drop3.BorderSizePixel = 0
	drop3.Position = UDim2.fromScale(1, 0)
	drop3.Size = UDim2.fromOffset(30, 20)
	drop3.ZIndex = 9

	uICorner29 = Instance.new("UICorner")
	uICorner29.Name = "UICorner"
	uICorner29.Parent = drop3

	icon16 = Instance.new("ImageLabel")
	icon16.Name = "Icon"
	icon16.Image = "rbxassetid://8677555693"
	icon16.AnchorPoint = Vector2.new(0.5, 0.5)
	icon16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon16.BackgroundTransparency = 1
	icon16.Position = UDim2.fromScale(0.5, 0.5)
	icon16.Size = UDim2.fromOffset(25, 25)
	icon16.ZIndex = 10
	icon16.Parent = drop3

	drop3.Parent = title10

	selected3 = Instance.new("TextLabel")
	selected3.Name = "Selected"
	selected3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
	selected3.Text = "GothamMedium"
	selected3.TextColor3 = Color3.fromRGB(200, 200, 200)
	selected3.TextSize = 14
	selected3.TextXAlignment = Enum.TextXAlignment.Right
	selected3.AnchorPoint = Vector2.new(1, 0.5)
	selected3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	selected3.BackgroundTransparency = 1
	selected3.Position = UDim2.new(1, -35, 0.5, 0)
	selected3.Size = UDim2.fromOffset(0, 18)
	selected3.ZIndex = 9
	selected3.Parent = title10

	title10.Parent = font

	topContainer3 = Instance.new("Frame")
	topContainer3.Name = "TopContainer"
	topContainer3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	topContainer3.BackgroundTransparency = 1
	topContainer3.LayoutOrder = 2
	topContainer3.Size = UDim2.new(1, 0, 0, 25)
	topContainer3.ZIndex = 6

	background3 = Instance.new("Frame")
	background3.Name = "Background"
	background3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	background3.BackgroundTransparency = 1
	background3.LayoutOrder = 2
	background3.Size = UDim2.new(1, 0, 0, 25)
	background3.ZIndex = 6

	main6 = Instance.new("Frame")
	main6.Name = "Main"
	main6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	main6.BackgroundTransparency = 0.5
	main6.LayoutOrder = 2
	main6.Size = UDim2.new(1, 0, 0, 30)
	main6.ZIndex = 6

	uICorner30 = Instance.new("UICorner")
	uICorner30.Name = "UICorner"
	uICorner30.Parent = main6

	main6.Parent = background3

	background3.Parent = topContainer3

	flat3 = Instance.new("Frame")
	flat3.Name = "Flat"
	flat3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	flat3.BackgroundTransparency = 0.5
	flat3.BorderSizePixel = 0
	flat3.Position = UDim2.fromOffset(0, 25)
	flat3.Size = UDim2.new(1, 0, 0, 5)
	flat3.Visible = false
	flat3.ZIndex = 6
	flat3.Parent = topContainer3

	topContainer3.Parent = font

	dropdown3 = Instance.new("Frame")
	dropdown3.Name = "Dropdown"
	dropdown3.AutomaticSize = Enum.AutomaticSize.Y
	dropdown3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	dropdown3.BackgroundTransparency = 1
	dropdown3.BorderSizePixel = 0
	dropdown3.ClipsDescendants = true
	dropdown3.Position = UDim2.fromOffset(0, 30)
	dropdown3.Size = UDim2.fromScale(1, 0)
	dropdown3.ZIndex = 6

	bottomContainer3 = Instance.new("Frame")
	bottomContainer3.Name = "BottomContainer"
	bottomContainer3.AnchorPoint = Vector2.new(0, 1)
	bottomContainer3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bottomContainer3.BackgroundTransparency = 1
	bottomContainer3.BorderSizePixel = 0
	bottomContainer3.ClipsDescendants = true
	bottomContainer3.Position = UDim2.new(0, 0, 2, -20)
	bottomContainer3.Size = UDim2.fromScale(1, 1)
	bottomContainer3.ZIndex = 6

	rounded4 = Instance.new("Frame")
	rounded4.Name = "Rounded"
	rounded4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	rounded4.BackgroundTransparency = 0.35
	rounded4.Position = UDim2.fromOffset(0, -30)
	rounded4.Size = UDim2.new(1, 0, 0, 50)
	rounded4.ZIndex = 6

	uICorner31 = Instance.new("UICorner")
	uICorner31.Name = "UICorner"
	uICorner31.Parent = rounded4

	rounded4.Parent = bottomContainer3

	bottomContainer3.Parent = dropdown3

	options3 = Instance.new("Frame")
	options3.Name = "Options"
	options3.AutomaticSize = Enum.AutomaticSize.Y
	options3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	options3.BackgroundTransparency = 1
	options3.Size = UDim2.fromScale(1, 0)
	options3.ZIndex = 6

	uIListLayout8 = Instance.new("UIListLayout")
	uIListLayout8.Name = "UIListLayout"
	uIListLayout8.Padding = UDim.new(0, 3)
	uIListLayout8.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout8.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout8.Parent = options3

	options3.Parent = dropdown3

	uIPadding7 = Instance.new("UIPadding")
	uIPadding7.Name = "UIPadding"
	uIPadding7.PaddingBottom = UDim.new(0, 55)
	uIPadding7.Parent = dropdown3

	frame3 = Instance.new("Frame")
	frame3.Name = "Frame"
	frame3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame3.BackgroundTransparency = 0.35
	frame3.BorderSizePixel = 0
	frame3.Size = UDim2.new(1, 0, 1, -20)
	frame3.ZIndex = 6
	frame3.Parent = dropdown3

	dropdown3.Parent = font

	font.Parent = scroller4

	enabled = Instance.new("Frame")
	enabled.Name = "Enabled"
	enabled.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	enabled.BackgroundTransparency = 0.5
	enabled.LayoutOrder = -1
	enabled.Size = UDim2.new(1, -10, 0, 30)
	enabled.ZIndex = 6

	title11 = Instance.new("Frame")
	title11.Name = "Title"
	title11.AnchorPoint = Vector2.new(0.5, 0.5)
	title11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title11.BackgroundTransparency = 1
	title11.BorderSizePixel = 0
	title11.Position = UDim2.fromScale(0.5, 0.5)
	title11.Size = UDim2.new(0.95, 0, 0, 20)
	title11.ZIndex = 6

	icon17 = Instance.new("ImageLabel")
	icon17.Name = "Icon"
	icon17.Image = "rbxassetid://8685962752"
	icon17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	icon17.BackgroundTransparency = 1
	icon17.Size = UDim2.fromOffset(20, 20)
	icon17.ZIndex = 6
	icon17.Parent = title11

	label9 = Instance.new("TextLabel")
	label9.Name = "Label"
	label9.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	label9.Text = "Enabled"
	label9.TextColor3 = Color3.fromRGB(255, 255, 255)
	label9.TextSize = 14
	label9.TextXAlignment = Enum.TextXAlignment.Left
	label9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label9.BackgroundTransparency = 1
	label9.Position = UDim2.fromOffset(25, 0)
	label9.Size = UDim2.new(0.5, 0, 0, 18)
	label9.ZIndex = 6
	label9.Parent = title11

	title11.Parent = enabled

	uICorner32 = Instance.new("UICorner")
	uICorner32.Name = "UICorner"
	uICorner32.Parent = enabled

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

	rounded5 = Instance.new("Frame")
	rounded5.Name = "Rounded"
	rounded5.AnchorPoint = Vector2.new(1, 0.5)
	rounded5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	rounded5.Position = UDim2.new(1, -3, 0.5, 0)
	rounded5.Size = UDim2.fromOffset(14, 14)
	rounded5.ZIndex = 6

	ignore14 = Instance.new("UICorner")
	ignore14.Name = "Ignore"
	ignore14.CornerRadius = UDim.new(1, 0)
	ignore14.Parent = rounded5

	rounded5.Parent = toggle1

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

	title12 = Instance.new("TextLabel")
	title12.Name = "Title"
	title12.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	title12.Text = "Quick Chat"
	title12.TextColor3 = Color3.fromRGB(255, 255, 255)
	title12.TextSize = 20
	title12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title12.BackgroundTransparency = 1
	title12.Position = UDim2.fromOffset(0, 5)
	title12.Size = UDim2.new(1, 0, 0, 30)
	title12.ZIndex = 6

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

	uICorner33 = Instance.new("UICorner")
	uICorner33.Name = "UICorner"
	uICorner33.Parent = back2

	back2.Parent = title12

	title12.Parent = quickChat1

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

	uIListLayout9 = Instance.new("UIListLayout")
	uIListLayout9.Name = "UIListLayout"
	uIListLayout9.Padding = UDim.new(0, 5)
	uIListLayout9.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout9.Parent = scroller5

	scroller5.Parent = quickChat1

	quickChat1.Parent = pages

	pages.Parent = settings

	settings.Parent = chat

	saveChat = Instance.new("Frame")
	saveChat.Name = "SaveChat"
	saveChat.AnchorPoint = Vector2.new(0.5, 0.5)
	saveChat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	saveChat.BackgroundTransparency = 0.75
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
	container5.Size = UDim2.new(0, 140, 1, -35)

	uIListLayout10 = Instance.new("UIListLayout")
	uIListLayout10.Name = "UIListLayout"
	uIListLayout10.Padding = UDim.new(0, 2)
	uIListLayout10.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout10.Parent = container5

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
	slot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	slot.BackgroundTransparency = 0.5
	slot.BorderSizePixel = 0
	slot.Size = UDim2.new(1, -10, 0, 25)

	uICorner34 = Instance.new("UICorner")
	uICorner34.Name = "UICorner"
	uICorner34.Parent = slot

	slot.Parent = container5

	container5.Parent = saveChat

	uICorner35 = Instance.new("UICorner")
	uICorner35.Name = "UICorner"
	uICorner35.Parent = saveChat

	uIGradient = Instance.new("UIGradient")
	uIGradient.Name = "UIGradient"
	uIGradient.Rotation = -90
	uIGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.9, 0),
		NumberSequenceKeypoint.new(0.9, 1),
		NumberSequenceKeypoint.new(1, 1),
	})
	uIGradient.Parent = saveChat

	header = Instance.new("Frame")
	header.Name = "Header"
	header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	header.BackgroundTransparency = 1
	header.ClipsDescendants = true
	header.Position = UDim2.fromOffset(0, -13)
	header.Size = UDim2.new(1, 0, 0, 35)

	uI2 = Instance.new("Frame")
	uI2.Name = "UI"
	uI2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	uI2.BackgroundTransparency = 0.5
	uI2.Size = UDim2.new(1, 0, 0, 48)

	close1 = Instance.new("TextButton")
	close1.Name = "Close"
	close1.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	close1.Text = ""
	close1.TextColor3 = Color3.fromRGB(0, 0, 0)
	close1.TextSize = 14
	close1.AnchorPoint = Vector2.new(1, 0)
	close1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	close1.BorderSizePixel = 0
	close1.Position = UDim2.new(1, -5, 0, 5)
	close1.Size = UDim2.fromOffset(25, 25)
	close1.ZIndex = 5

	imageLabel3 = Instance.new("ImageLabel")
	imageLabel3.Name = "ImageLabel"
	imageLabel3.Image = "http://www.roblox.com/asset/?id=6031094678"
	imageLabel3.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	imageLabel3.BackgroundTransparency = 1
	imageLabel3.Position = UDim2.fromScale(0.5, 0.5)
	imageLabel3.Size = UDim2.fromOffset(20, 20)
	imageLabel3.ZIndex = 6
	imageLabel3.Parent = close1

	uICorner36 = Instance.new("UICorner")
	uICorner36.Name = "UICorner"
	uICorner36.Parent = close1

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

	uICorner37 = Instance.new("UICorner")
	uICorner37.Name = "UICorner"
	uICorner37.Parent = uI2

	uI2.Parent = header

	header.Parent = saveChat

	saveChat.Parent = chat
	
	chatbarFont:Destroy()
	
	return chat
end