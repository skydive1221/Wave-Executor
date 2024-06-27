-- Author: @Jumpathy
-- Name: chatGui.lua
-- Description: Chat gui

return function()
	local Chat = {
		Chat = Instance.new("ScreenGui"),
		Container = Instance.new("Frame"),
		ChatWindow = Instance.new("Frame"),
		Main = Instance.new("Frame"),
		UICorner = Instance.new("UICorner"),
		Scroller = Instance.new("ScrollingFrame"),
		MessageContainer = Instance.new("Frame"),
		UIListLayout = Instance.new("UIListLayout"),
		ChatBarContainer = Instance.new("Frame"),
		Main_2 = Instance.new("Frame"),
		Container_2 = Instance.new("Frame"),
		UICorner_2 = Instance.new("UICorner"),
		Box = Instance.new("Frame"),
		UICorner_3 = Instance.new("UICorner"),
		Input = Instance.new("TextBox"),
		Bar = Instance.new("TextLabel"),
		UIPadding = Instance.new("UIPadding"),
		Resize = Instance.new("TextButton"),
		Icon = Instance.new("ImageLabel"),
		UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint"),
		UICorner_4 = Instance.new("UICorner"),
		Container_3 = Instance.new("Frame"),
		Channel = Instance.new("TextButton"),
		Label = Instance.new("TextLabel"),
		UICorner_5 = Instance.new("UICorner"),
		ReplyIcon = Instance.new("ImageLabel"),
		Autofill = Instance.new("Frame"),
		Corner = Instance.new("UICorner"),
		Container_4 = Instance.new("Frame"),
		Scroller_2 = Instance.new("ScrollingFrame"),
		Layout = Instance.new("UIListLayout"),
		Zone = Instance.new("Frame"),
		Channelbar = Instance.new("Frame"),
		Main_3 = Instance.new("Frame"),
		Container_5 = Instance.new("Frame"),
		UICorner_6 = Instance.new("UICorner"),
		Scroller_3 = Instance.new("ScrollingFrame"),
		UIListLayout_2 = Instance.new("UIListLayout"),
		Settings = Instance.new("Frame"),
		UICorner_7 = Instance.new("UICorner"),
		Pages = Instance.new("Frame"),
		Navigation = Instance.new("Frame"),
		Content = Instance.new("Frame"),
		UIListLayout_3 = Instance.new("UIListLayout"),
		UI = Instance.new("TextButton"),
		UICorner_8 = Instance.new("UICorner"),
		Icon_2 = Instance.new("ImageLabel"),
		BubbleChat = Instance.new("TextButton"),
		UICorner_9 = Instance.new("UICorner"),
		Icon_3 = Instance.new("ImageLabel"),
		QuickChat = Instance.new("TextButton"),
		UICorner_10 = Instance.new("UICorner"),
		Icon_4 = Instance.new("ImageLabel"),
		Title = Instance.new("TextLabel"),
		Close = Instance.new("TextButton"),
		UICorner_11 = Instance.new("UICorner"),
		Icon_5 = Instance.new("ImageLabel"),
		UI_2 = Instance.new("Frame"),
		Title_2 = Instance.new("TextLabel"),
		Back = Instance.new("TextButton"),
		ImageLabel = Instance.new("ImageLabel"),
		UICorner_12 = Instance.new("UICorner"),
		Scroller_4 = Instance.new("ScrollingFrame"),
		UIListLayout_4 = Instance.new("UIListLayout"),
		TextSize = Instance.new("Frame"),
		Center = Instance.new("Frame"),
		Title_3 = Instance.new("Frame"),
		Icon_6 = Instance.new("ImageLabel"),
		Label_2 = Instance.new("TextLabel"),
		Actual = Instance.new("Frame"),
		Amount = Instance.new("TextBox"),
		UICorner_13 = Instance.new("UICorner"),
		UIPadding_2 = Instance.new("UIPadding"),
		Bar_2 = Instance.new("Frame"),
		Ignore = Instance.new("UICorner"),
		Button = Instance.new("TextButton"),
		Ignore_2 = Instance.new("UICorner"),
		Progress = Instance.new("Frame"),
		Ignore_3 = Instance.new("UICorner"),
		UICorner_14 = Instance.new("UICorner"),
		Roundness = Instance.new("Frame"),
		Center_2 = Instance.new("Frame"),
		Title_4 = Instance.new("Frame"),
		Icon_7 = Instance.new("ImageLabel"),
		Label_3 = Instance.new("TextLabel"),
		Actual_2 = Instance.new("Frame"),
		Amount_2 = Instance.new("TextBox"),
		UICorner_15 = Instance.new("UICorner"),
		UIPadding_3 = Instance.new("UIPadding"),
		Bar_3 = Instance.new("Frame"),
		Ignore_4 = Instance.new("UICorner"),
		Button_2 = Instance.new("TextButton"),
		Ignore_5 = Instance.new("UICorner"),
		Progress_2 = Instance.new("Frame"),
		Ignore_6 = Instance.new("UICorner"),
		UICorner_16 = Instance.new("UICorner"),
		Resizable = Instance.new("Frame"),
		Title_5 = Instance.new("Frame"),
		Icon_8 = Instance.new("ImageLabel"),
		Label_4 = Instance.new("TextLabel"),
		UICorner_17 = Instance.new("UICorner"),
		Toggle = Instance.new("Frame"),
		Ignore_7 = Instance.new("UICorner"),
		Zone_2 = Instance.new("TextButton"),
		Ignore_8 = Instance.new("UICorner"),
		Rounded = Instance.new("Frame"),
		Ignore_9 = Instance.new("UICorner"),
		BubbleChat_2 = Instance.new("Frame"),
		Title_6 = Instance.new("TextLabel"),
		Back_2 = Instance.new("TextButton"),
		ImageLabel_2 = Instance.new("ImageLabel"),
		UICorner_18 = Instance.new("UICorner"),
		Scroller_5 = Instance.new("ScrollingFrame"),
		UIListLayout_5 = Instance.new("UIListLayout"),
		AnimationStyle = Instance.new("Frame"),
		Title_7 = Instance.new("Frame"),
		Icon_9 = Instance.new("ImageLabel"),
		Label_5 = Instance.new("TextLabel"),
		Drop = Instance.new("TextButton"),
		UICorner_19 = Instance.new("UICorner"),
		Icon_10 = Instance.new("ImageLabel"),
		Selected = Instance.new("TextLabel"),
		TopContainer = Instance.new("Frame"),
		Background = Instance.new("Frame"),
		Main_4 = Instance.new("Frame"),
		UICorner_20 = Instance.new("UICorner"),
		Flat = Instance.new("Frame"),
		Dropdown = Instance.new("Frame"),
		BottomContainer = Instance.new("Frame"),
		Rounded_2 = Instance.new("Frame"),
		UICorner_21 = Instance.new("UICorner"),
		Options = Instance.new("Frame"),
		UIListLayout_6 = Instance.new("UIListLayout"),
		UIPadding_4 = Instance.new("UIPadding"),
		Frame = Instance.new("Frame"),
		FadeoutTime = Instance.new("Frame"),
		Center_3 = Instance.new("Frame"),
		Title_8 = Instance.new("Frame"),
		Icon_11 = Instance.new("ImageLabel"),
		Label_6 = Instance.new("TextLabel"),
		Actual_3 = Instance.new("Frame"),
		Amount_3 = Instance.new("TextBox"),
		UICorner_22 = Instance.new("UICorner"),
		UIPadding_5 = Instance.new("UIPadding"),
		Bar_4 = Instance.new("Frame"),
		Ignore_10 = Instance.new("UICorner"),
		Button_3 = Instance.new("TextButton"),
		Ignore_11 = Instance.new("UICorner"),
		Progress_3 = Instance.new("Frame"),
		Ignore_12 = Instance.new("UICorner"),
		UICorner_23 = Instance.new("UICorner"),
		["Font"] = Instance.new("Frame"),
		Title_9 = Instance.new("Frame"),
		Icon_12 = Instance.new("ImageLabel"),
		Label_7 = Instance.new("TextLabel"),
		Drop_2 = Instance.new("TextButton"),
		UICorner_24 = Instance.new("UICorner"),
		Icon_13 = Instance.new("ImageLabel"),
		Selected_2 = Instance.new("TextLabel"),
		TopContainer_2 = Instance.new("Frame"),
		Background_2 = Instance.new("Frame"),
		Main_5 = Instance.new("Frame"),
		UICorner_25 = Instance.new("UICorner"),
		Flat_2 = Instance.new("Frame"),
		Dropdown_2 = Instance.new("Frame"),
		BottomContainer_2 = Instance.new("Frame"),
		Rounded_3 = Instance.new("Frame"),
		UICorner_26 = Instance.new("UICorner"),
		Options_2 = Instance.new("Frame"),
		UIListLayout_7 = Instance.new("UIListLayout"),
		UIPadding_6 = Instance.new("UIPadding"),
		Frame_2 = Instance.new("Frame"),
		Enabled = Instance.new("Frame"),
		Title_10 = Instance.new("Frame"),
		Icon_14 = Instance.new("ImageLabel"),
		Label_8 = Instance.new("TextLabel"),
		UICorner_27 = Instance.new("UICorner"),
		Toggle_2 = Instance.new("Frame"),
		Ignore_13 = Instance.new("UICorner"),
		Zone_3 = Instance.new("TextButton"),
		Ignore_14 = Instance.new("UICorner"),
		Rounded_4 = Instance.new("Frame"),
		Ignore_15 = Instance.new("UICorner"),
		QuickChat_2 = Instance.new("Frame"),
		Title_11 = Instance.new("TextLabel"),
		Back_3 = Instance.new("TextButton"),
		ImageLabel_3 = Instance.new("ImageLabel"),
		UICorner_28 = Instance.new("UICorner"),
		Scroller_6 = Instance.new("ScrollingFrame"),
		UIListLayout_8 = Instance.new("UIListLayout"),
		SaveChat = Instance.new("Frame"),
		Container_6 = Instance.new("ScrollingFrame"),
		UIListLayout_9 = Instance.new("UIListLayout"),
		Slot = Instance.new("TextButton"),
		UICorner_29 = Instance.new("UICorner"),
		UICorner_30 = Instance.new("UICorner"),
		UIGradient = Instance.new("UIGradient"),
		Header = Instance.new("Frame"),
		UI_3 = Instance.new("Frame"),
		Close_2 = Instance.new("TextButton"),
		ImageLabel_4 = Instance.new("ImageLabel"),
		UICorner_31 = Instance.new("UICorner"),
		Title_12 = Instance.new("TextLabel"),
		UICorner_32 = Instance.new("UICorner"),
	}

	--Properties:

	Chat.Chat.Name = "Chat"
	Chat.Chat.DisplayOrder = 2
	Chat.Chat.ResetOnSpawn = false

	Chat.Container.Name = "Container"
	Chat.Container.Parent = Chat.Chat
	Chat.Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Container.BackgroundTransparency = 1.000
	Chat.Container.Position = UDim2.new(0, 16, 0, 8)
	Chat.Container.Size = UDim2.new(0, 400, 0, 235)
	Chat.Container.Visible = false

	Chat.ChatWindow.Name = "ChatWindow"
	Chat.ChatWindow.Parent = Chat.Container
	Chat.ChatWindow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.ChatWindow.BackgroundTransparency = 1.000
	Chat.ChatWindow.BorderSizePixel = 0
	Chat.ChatWindow.Size = UDim2.new(1, 0, 1, -35)

	Chat.Main.Name = "Main"
	Chat.Main.Parent = Chat.ChatWindow
	Chat.Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Main.BackgroundTransparency = 0.750
	Chat.Main.BorderSizePixel = 0
	Chat.Main.ClipsDescendants = true
	Chat.Main.Size = UDim2.new(1, 0, 1, 0)

	Chat.UICorner.Parent = Chat.Main

	Chat.Scroller.Name = "Scroller"
	Chat.Scroller.Parent = Chat.Main
	Chat.Scroller.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Scroller.BackgroundTransparency = 1.000
	Chat.Scroller.BorderSizePixel = 0
	Chat.Scroller.Position = UDim2.new(0, 5, 0, 5)
	Chat.Scroller.Selectable = false
	Chat.Scroller.Size = UDim2.new(1, -15, 1, -10)
	Chat.Scroller.BottomImage = "rbxassetid://8082116996"
	Chat.Scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
	Chat.Scroller.MidImage = "rbxassetid://7488333553"
	Chat.Scroller.ScrollBarThickness = 0
	Chat.Scroller.TopImage = "rbxassetid://8082122989"
	Chat.Scroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
	
	Chat.MessageContainer.Name = "MessageContainer"
	Chat.MessageContainer.Parent = Chat.Scroller
	Chat.MessageContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.MessageContainer.BackgroundTransparency = 1.000
	Chat.MessageContainer.Size = UDim2.new(1, -10, 0, 0)

	Chat.UIListLayout.Parent = Chat.MessageContainer
	Chat.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.UIListLayout.Padding = UDim.new(0, 2)

	Chat.ChatBarContainer.Name = "ChatBarContainer"
	Chat.ChatBarContainer.Parent = Chat.Container
	Chat.ChatBarContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.ChatBarContainer.BackgroundTransparency = 1.000
	Chat.ChatBarContainer.BorderSizePixel = 0
	Chat.ChatBarContainer.Position = UDim2.new(0, 0, 0, 205)
	Chat.ChatBarContainer.Size = UDim2.new(1, 0, 0, 35)

	Chat.Main_2.Name = "Main"
	Chat.Main_2.Parent = Chat.ChatBarContainer
	Chat.Main_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Main_2.BackgroundTransparency = 1.000
	Chat.Main_2.BorderSizePixel = 0
	Chat.Main_2.Size = UDim2.new(1, 0, 0, 35)

	Chat.Container_2.Name = "Container"
	Chat.Container_2.Parent = Chat.Main_2
	Chat.Container_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Container_2.BackgroundTransparency = 0.750
	Chat.Container_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.Container_2.BorderSizePixel = 0
	Chat.Container_2.Size = UDim2.new(1, 0, 1, 0)

	Chat.UICorner_2.Parent = Chat.Container_2

	Chat.Box.Name = "Box"
	Chat.Box.Parent = Chat.Container_2
	Chat.Box.Active = true
	Chat.Box.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Box.BorderSizePixel = 0
	Chat.Box.Position = UDim2.new(0, 5, 0.5, 0)
	Chat.Box.Size = UDim2.new(1, -40, 0, 25)

	Chat.UICorner_3.Parent = Chat.Box

	Chat.Input.Name = "Input"
	Chat.Input.Parent = Chat.Box
	Chat.Input.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Input.BackgroundTransparency = 1.000
	Chat.Input.Position = UDim2.new(0, 5, 0.5, 0)
	Chat.Input.Size = UDim2.new(1, -10, 0, 14)
	Chat.Input.ZIndex = 2
	Chat.Input.ClearTextOnFocus = false
	Chat.Input.Font = Enum.Font.Gotham
	Chat.Input.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
	Chat.Input.PlaceholderText = "Click here or press '/' to chat."
	Chat.Input.Text = ""
	Chat.Input.TextColor3 = Color3.fromRGB(100, 100, 100)
	Chat.Input.TextSize = 14.000
	Chat.Input.TextWrapped = true
	Chat.Input.TextXAlignment = Enum.TextXAlignment.Left
	Chat.Input.TextYAlignment = Enum.TextYAlignment.Top

	Chat.Bar.Name = "Bar"
	Chat.Bar.Parent = Chat.Input
	Chat.Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Bar.BackgroundTransparency = 1.000
	Chat.Bar.BorderSizePixel = 0
	Chat.Bar.Size = UDim2.new(1, 0, 1, 0)
	Chat.Bar.Font = Enum.Font.GothamMedium
	Chat.Bar.Text = ""
	Chat.Bar.TextColor3 = Color3.fromRGB(100, 100, 100)
	Chat.Bar.TextSize = 14.000
	Chat.Bar.TextTransparency = 0.500
	Chat.Bar.TextWrapped = true
	Chat.Bar.TextXAlignment = Enum.TextXAlignment.Left

	Chat.UIPadding.Parent = Chat.Box
	Chat.UIPadding.PaddingBottom = UDim.new(0, 8)
	Chat.UIPadding.PaddingTop = UDim.new(0, 8)

	Chat.Resize.Name = "Resize"
	Chat.Resize.Parent = Chat.Container_2
	Chat.Resize.Active = false
	Chat.Resize.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Resize.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
	Chat.Resize.BorderSizePixel = 0
	Chat.Resize.Position = UDim2.new(1, -5, 0, 17)
	Chat.Resize.Selectable = false
	Chat.Resize.Size = UDim2.new(0, 25, 0, 25)
	Chat.Resize.Visible = false
	Chat.Resize.Text = ""

	Chat.Icon.Name = "Icon"
	Chat.Icon.Parent = Chat.Resize
	Chat.Icon.Active = true
	Chat.Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Icon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Icon.BackgroundTransparency = 1.000
	Chat.Icon.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.Icon.BorderSizePixel = 0
	Chat.Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.Icon.Selectable = true
	Chat.Icon.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
	Chat.Icon.Image = "rbxassetid://8571348189"

	Chat.UIAspectRatioConstraint.Parent = Chat.Icon

	Chat.UICorner_4.Parent = Chat.Resize

	Chat.Container_3.Name = "Container"
	Chat.Container_3.Parent = Chat.Container_2
	Chat.Container_3.Active = true
	Chat.Container_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Container_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Container_3.BackgroundTransparency = 1.000
	Chat.Container_3.Position = UDim2.new(0.5, 0, 0, 17)
	Chat.Container_3.Selectable = true
	Chat.Container_3.Size = UDim2.new(1, -30, 0, 14)

	Chat.Channel.Name = "Channel"
	Chat.Channel.Parent = Chat.Container_3
	Chat.Channel.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Channel.BackgroundColor3 = Color3.fromRGB(253, 80, 111)
	Chat.Channel.BorderSizePixel = 0
	Chat.Channel.Position = UDim2.new(0, -7, 0.5, 0)
	Chat.Channel.Size = UDim2.new(0, 0, 0, 20)
	Chat.Channel.Visible = false
	Chat.Channel.Font = Enum.Font.GothamMedium
	Chat.Channel.Text = ""
	Chat.Channel.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Channel.TextSize = 15.000
	Chat.Channel.TextWrapped = true

	Chat.Label.Name = "Label"
	Chat.Label.Parent = Chat.Channel
	Chat.Label.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label.BackgroundTransparency = 1.000
	Chat.Label.Position = UDim2.new(0, 5, 0.5, 0)
	Chat.Label.Size = UDim2.new(1, 0, 1, 0)
	Chat.Label.Font = Enum.Font.GothamMedium
	Chat.Label.Text = "test"
	Chat.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label.TextSize = 14.000

	Chat.UICorner_5.Parent = Chat.Channel

	Chat.ReplyIcon.Name = "ReplyIcon"
	Chat.ReplyIcon.Parent = Chat.Channel
	Chat.ReplyIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.ReplyIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.ReplyIcon.BackgroundTransparency = 1.000
	Chat.ReplyIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.ReplyIcon.Size = UDim2.new(0, 16, 0, 16)
	Chat.ReplyIcon.Visible = false
	Chat.ReplyIcon.ZIndex = 5
	Chat.ReplyIcon.Image = "rbxassetid://8595302757"

	Chat.Autofill.Name = "Autofill"
	Chat.Autofill.Parent = Chat.Main_2
	Chat.Autofill.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Autofill.BackgroundTransparency = 0.750
	Chat.Autofill.BorderSizePixel = 0
	Chat.Autofill.Position = UDim2.new(0, 0, 1, 5)
	Chat.Autofill.Size = UDim2.new(1, 0, 0, 0)

	Chat.Corner.Name = "Corner"
	Chat.Corner.Parent = Chat.Autofill

	Chat.Container_4.Name = "Container"
	Chat.Container_4.Parent = Chat.Autofill
	Chat.Container_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Container_4.BackgroundTransparency = 1.000
	Chat.Container_4.Size = UDim2.new(1, 0, 1, 0)

	Chat.Scroller_2.Name = "Scroller"
	Chat.Scroller_2.Parent = Chat.Container_4
	Chat.Scroller_2.Active = true
	Chat.Scroller_2.AnchorPoint = Vector2.new(0.5, 0)
	Chat.Scroller_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Scroller_2.BackgroundTransparency = 1.000
	Chat.Scroller_2.BorderSizePixel = 0
	Chat.Scroller_2.Position = UDim2.new(0.5, 0, 0, 4)
	Chat.Scroller_2.Size = UDim2.new(1, -10, 1, 0)
	Chat.Scroller_2.BottomImage = "rbxassetid://8082116996"
	Chat.Scroller_2.CanvasSize = UDim2.new(0, 0, 0, 0)
	Chat.Scroller_2.MidImage = "rbxassetid://7488333553"
	Chat.Scroller_2.ScrollBarThickness = 0
	Chat.Scroller_2.TopImage = "rbxassetid://8082122989"

	Chat.Layout.Name = "Layout"
	Chat.Layout.Parent = Chat.Scroller_2
	Chat.Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.Layout.VerticalAlignment = Enum.VerticalAlignment.Center
	Chat.Layout.Padding = UDim.new(0, 2)

	Chat.Zone.Name = "Zone"
	Chat.Zone.Parent = Chat.Container
	Chat.Zone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Zone.BackgroundTransparency = 1.000
	Chat.Zone.Size = UDim2.new(1, 0, 1, 5)
	Chat.Zone.ZIndex = 3

	Chat.Channelbar.Name = "Channelbar"
	Chat.Channelbar.Parent = Chat.Container
	Chat.Channelbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Channelbar.BackgroundTransparency = 1.000
	Chat.Channelbar.BorderSizePixel = 0
	Chat.Channelbar.ClipsDescendants = true
	Chat.Channelbar.Size = UDim2.new(1, 0, 0, 35)
	Chat.Channelbar.Visible = false

	Chat.Main_3.Name = "Main"
	Chat.Main_3.Parent = Chat.Channelbar
	Chat.Main_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Main_3.BackgroundTransparency = 1.000
	Chat.Main_3.BorderSizePixel = 0
	Chat.Main_3.Size = UDim2.new(1, 0, 1, 0)

	Chat.Container_5.Name = "Container"
	Chat.Container_5.Parent = Chat.Main_3
	Chat.Container_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Container_5.BackgroundTransparency = 0.750
	Chat.Container_5.BorderSizePixel = 0
	Chat.Container_5.Size = UDim2.new(1, 0, 1, 0)

	Chat.UICorner_6.Parent = Chat.Container_5

	Chat.Scroller_3.Name = "Scroller"
	Chat.Scroller_3.Parent = Chat.Container_5
	Chat.Scroller_3.Active = true
	Chat.Scroller_3.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Scroller_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Scroller_3.BackgroundTransparency = 1.000
	Chat.Scroller_3.BorderSizePixel = 0
	Chat.Scroller_3.Position = UDim2.new(1, -5, 0.5, 0)
	Chat.Scroller_3.Size = UDim2.new(1, -10, 1, 0)
	Chat.Scroller_3.BottomImage = "rbxassetid://8082116996"
	Chat.Scroller_3.CanvasSize = UDim2.new(0, 0, 0, 0)
	Chat.Scroller_3.MidImage = "rbxassetid://7488333553"
	Chat.Scroller_3.ScrollBarThickness = 0
	Chat.Scroller_3.TopImage = "rbxassetid://8082122989"

	Chat.UIListLayout_2.Parent = Chat.Scroller_3
	Chat.UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
	Chat.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
	Chat.UIListLayout_2.Padding = UDim.new(0, 5)

	Chat.Settings.Name = "Settings"
	Chat.Settings.Parent = Chat.Chat
	Chat.Settings.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Settings.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Settings.BackgroundTransparency = 0.500
	Chat.Settings.BorderSizePixel = 0
	Chat.Settings.Position = UDim2.new(0.5, 0, -1.5, 0)
	Chat.Settings.Size = UDim2.new(0, 325, 0, 300)
	Chat.Settings.ZIndex = 5

	Chat.UICorner_7.Parent = Chat.Settings

	Chat.Pages.Name = "Pages"
	Chat.Pages.Parent = Chat.Settings
	Chat.Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Pages.BackgroundTransparency = 1.000
	Chat.Pages.ClipsDescendants = true
	Chat.Pages.Size = UDim2.new(1, 0, 1, 0)
	Chat.Pages.ZIndex = 6

	Chat.Navigation.Name = "Navigation"
	Chat.Navigation.Parent = Chat.Pages
	Chat.Navigation.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Navigation.BackgroundTransparency = 1.000
	Chat.Navigation.Size = UDim2.new(1, 0, 1, 0)
	Chat.Navigation.ZIndex = 6

	Chat.Content.Name = "Content"
	Chat.Content.Parent = Chat.Navigation
	Chat.Content.AnchorPoint = Vector2.new(0.5, 1)
	Chat.Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Content.BackgroundTransparency = 1.000
	Chat.Content.Position = UDim2.new(0.5, 0, 1, -10)
	Chat.Content.Size = UDim2.new(1, -10, 1, -50)
	Chat.Content.ZIndex = 6

	Chat.UIListLayout_3.Parent = Chat.Content
	Chat.UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.UIListLayout_3.Padding = UDim.new(0, 5)

	Chat.UI.Name = "UI"
	Chat.UI.Parent = Chat.Content
	Chat.UI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.UI.BackgroundTransparency = 0.300
	Chat.UI.BorderSizePixel = 0
	Chat.UI.Size = UDim2.new(1, 0, 0, 35)
	Chat.UI.ZIndex = 6
	Chat.UI.Font = Enum.Font.GothamMedium
	Chat.UI.Text = "UI"
	Chat.UI.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.UI.TextSize = 20.000
	Chat.UI.TextWrapped = true

	Chat.UICorner_8.Parent = Chat.UI

	Chat.Icon_2.Name = "Icon"
	Chat.Icon_2.Parent = Chat.UI
	Chat.Icon_2.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Icon_2.BackgroundTransparency = 1.000
	Chat.Icon_2.BorderSizePixel = 0
	Chat.Icon_2.Position = UDim2.new(0, 5, 0.5, 0)
	Chat.Icon_2.Size = UDim2.new(0, 25, 0, 25)
	Chat.Icon_2.ZIndex = 7
	Chat.Icon_2.Image = "http://www.roblox.com/asset/?id=6035030081"

	Chat.BubbleChat.Name = "BubbleChat"
	Chat.BubbleChat.Parent = Chat.Content
	Chat.BubbleChat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.BubbleChat.BackgroundTransparency = 0.300
	Chat.BubbleChat.BorderSizePixel = 0
	Chat.BubbleChat.Position = UDim2.new(0.0327868834, 0, 0.0439999998, 0)
	Chat.BubbleChat.Size = UDim2.new(1, 0, 0, 35)
	Chat.BubbleChat.ZIndex = 6
	Chat.BubbleChat.Font = Enum.Font.GothamMedium
	Chat.BubbleChat.Text = "Bubble Chat"
	Chat.BubbleChat.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.BubbleChat.TextSize = 20.000
	Chat.BubbleChat.TextWrapped = true

	Chat.UICorner_9.Parent = Chat.BubbleChat

	Chat.Icon_3.Name = "Icon"
	Chat.Icon_3.Parent = Chat.BubbleChat
	Chat.Icon_3.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Icon_3.BackgroundTransparency = 1.000
	Chat.Icon_3.BorderSizePixel = 0
	Chat.Icon_3.Position = UDim2.new(0, 5, 0.5, 0)
	Chat.Icon_3.Size = UDim2.new(0, 25, 0, 25)
	Chat.Icon_3.ZIndex = 7
	Chat.Icon_3.Image = "rbxassetid://8678032944"

	Chat.QuickChat.Name = "QuickChat"
	Chat.QuickChat.Parent = Chat.Content
	Chat.QuickChat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.QuickChat.BackgroundTransparency = 0.300
	Chat.QuickChat.BorderSizePixel = 0
	Chat.QuickChat.LayoutOrder = 2
	Chat.QuickChat.Size = UDim2.new(1, 0, 0, 35)
	Chat.QuickChat.ZIndex = 6
	Chat.QuickChat.Font = Enum.Font.GothamMedium
	Chat.QuickChat.Text = "Quick Chat"
	Chat.QuickChat.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.QuickChat.TextSize = 20.000
	Chat.QuickChat.TextWrapped = true

	Chat.UICorner_10.Parent = Chat.QuickChat

	Chat.Icon_4.Name = "Icon"
	Chat.Icon_4.Parent = Chat.QuickChat
	Chat.Icon_4.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Icon_4.BackgroundTransparency = 1.000
	Chat.Icon_4.BorderSizePixel = 0
	Chat.Icon_4.Position = UDim2.new(0, 5, 0.5, 0)
	Chat.Icon_4.Size = UDim2.new(0, 25, 0, 25)
	Chat.Icon_4.ZIndex = 7
	Chat.Icon_4.Image = "rbxassetid://6031243319"

	Chat.Title.Name = "Title"
	Chat.Title.Parent = Chat.Navigation
	Chat.Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title.BackgroundTransparency = 1.000
	Chat.Title.Position = UDim2.new(0, 0, 0, 5)
	Chat.Title.Size = UDim2.new(1, 0, 0, 30)
	Chat.Title.ZIndex = 6
	Chat.Title.Font = Enum.Font.GothamMedium
	Chat.Title.Text = "BetterChat Settings"
	Chat.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title.TextSize = 20.000

	Chat.Close.Name = "Close"
	Chat.Close.Parent = Chat.Title
	Chat.Close.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Close.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Close.BackgroundTransparency = 0.300
	Chat.Close.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.Close.BorderSizePixel = 0
	Chat.Close.Position = UDim2.new(1, -5, 0.5, 0)
	Chat.Close.Size = UDim2.new(0, 30, 0, 30)
	Chat.Close.ZIndex = 8
	Chat.Close.Text = ""

	Chat.UICorner_11.Parent = Chat.Close

	Chat.Icon_5.Name = "Icon"
	Chat.Icon_5.Parent = Chat.Close
	Chat.Icon_5.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Icon_5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Chat.Icon_5.BackgroundTransparency = 1.000
	Chat.Icon_5.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.Icon_5.BorderSizePixel = 0
	Chat.Icon_5.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.Icon_5.Selectable = true
	Chat.Icon_5.Size = UDim2.new(0, 25, 0, 25)
	Chat.Icon_5.ZIndex = 8
	Chat.Icon_5.Image = "http://www.roblox.com/asset/?id=6031094678"

	Chat.UI_2.Name = "UI"
	Chat.UI_2.Parent = Chat.Pages
	Chat.UI_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.UI_2.BackgroundTransparency = 1.000
	Chat.UI_2.Position = UDim2.new(1, 0, 0, 0)
	Chat.UI_2.Size = UDim2.new(1, 0, 1, 0)
	Chat.UI_2.ZIndex = 6

	Chat.Title_2.Name = "Title"
	Chat.Title_2.Parent = Chat.UI_2
	Chat.Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_2.BackgroundTransparency = 1.000
	Chat.Title_2.Position = UDim2.new(0, 0, 0, 5)
	Chat.Title_2.Size = UDim2.new(1, 0, 0, 30)
	Chat.Title_2.ZIndex = 6
	Chat.Title_2.Font = Enum.Font.GothamMedium
	Chat.Title_2.Text = "UI Settings"
	Chat.Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_2.TextSize = 20.000

	Chat.Back.Name = "Back"
	Chat.Back.Parent = Chat.Title_2
	Chat.Back.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Back.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Back.Position = UDim2.new(0, 5, 0.5, 0)
	Chat.Back.Size = UDim2.new(0, 25, 0, 25)
	Chat.Back.ZIndex = 6
	Chat.Back.Font = Enum.Font.SourceSans
	Chat.Back.Text = ""
	Chat.Back.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Back.TextSize = 14.000

	Chat.ImageLabel.Parent = Chat.Back
	Chat.ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.ImageLabel.BackgroundTransparency = 1.000
	Chat.ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.ImageLabel.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
	Chat.ImageLabel.ZIndex = 6
	Chat.ImageLabel.Image = "rbxassetid://8677511725"

	Chat.UICorner_12.Parent = Chat.Back

	Chat.Scroller_4.Name = "Scroller"
	Chat.Scroller_4.Parent = Chat.UI_2
	Chat.Scroller_4.AnchorPoint = Vector2.new(0.5, 1)
	Chat.Scroller_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Scroller_4.BackgroundTransparency = 1.000
	Chat.Scroller_4.BorderSizePixel = 0
	Chat.Scroller_4.Position = UDim2.new(0.5, 0, 1, -10)
	Chat.Scroller_4.Selectable = false
	Chat.Scroller_4.Size = UDim2.new(1, -10, 1, -50)
	Chat.Scroller_4.ZIndex = 6
	Chat.Scroller_4.BottomImage = "rbxassetid://8082116996"
	Chat.Scroller_4.CanvasSize = UDim2.new(0, 0, 0, 0)
	Chat.Scroller_4.MidImage = "rbxassetid://7488333553"
	Chat.Scroller_4.ScrollBarThickness = 5
	Chat.Scroller_4.TopImage = "rbxassetid://8082122989"

	Chat.UIListLayout_4.Parent = Chat.Scroller_4
	Chat.UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.UIListLayout_4.Padding = UDim.new(0, 5)

	Chat.TextSize.Name = "TextSize"
	Chat.TextSize.Parent = Chat.Scroller_4
	Chat.TextSize.Active = true
	Chat.TextSize.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.TextSize.BackgroundTransparency = 0.500
	Chat.TextSize.BorderSizePixel = 0
	Chat.TextSize.Position = UDim2.new(0.0327868834, 0, 0.0439999998, 0)
	Chat.TextSize.Selectable = true
	Chat.TextSize.Size = UDim2.new(1, -10, 0, 55)
	Chat.TextSize.ZIndex = 6

	Chat.Center.Name = "Center"
	Chat.Center.Parent = Chat.TextSize
	Chat.Center.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Center.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Center.BackgroundTransparency = 1.000
	Chat.Center.Position = UDim2.new(0, 0, 0.5, 0)
	Chat.Center.Size = UDim2.new(1, 0, 0.75, 0)
	Chat.Center.ZIndex = 6

	Chat.Title_3.Name = "Title"
	Chat.Title_3.Parent = Chat.Center
	Chat.Title_3.AnchorPoint = Vector2.new(0.5, 0)
	Chat.Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_3.BackgroundTransparency = 1.000
	Chat.Title_3.BorderSizePixel = 0
	Chat.Title_3.Position = UDim2.new(0.5, 0, 0, 0)
	Chat.Title_3.Size = UDim2.new(0.949999988, 0, 0, 20)
	Chat.Title_3.ZIndex = 6

	Chat.Icon_6.Name = "Icon"
	Chat.Icon_6.Parent = Chat.Title_3
	Chat.Icon_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Icon_6.BackgroundTransparency = 1.000
	Chat.Icon_6.Size = UDim2.new(0, 20, 0, 20)
	Chat.Icon_6.ZIndex = 6
	Chat.Icon_6.Image = "rbxassetid://8677222862"

	Chat.Label_2.Name = "Label"
	Chat.Label_2.Parent = Chat.Title_3
	Chat.Label_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_2.BackgroundTransparency = 1.000
	Chat.Label_2.Position = UDim2.new(0, 25, 0, 0)
	Chat.Label_2.Size = UDim2.new(0.5, 0, 0, 18)
	Chat.Label_2.ZIndex = 6
	Chat.Label_2.Font = Enum.Font.GothamBold
	Chat.Label_2.Text = "Text Size"
	Chat.Label_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_2.TextSize = 14.000
	Chat.Label_2.TextXAlignment = Enum.TextXAlignment.Left

	Chat.Actual.Name = "Actual"
	Chat.Actual.Parent = Chat.Center
	Chat.Actual.AnchorPoint = Vector2.new(0.5, 1)
	Chat.Actual.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Actual.BackgroundTransparency = 1.000
	Chat.Actual.Position = UDim2.new(0.5, 0, 1, 5)
	Chat.Actual.Size = UDim2.new(0.949999988, 0, 0, 25)
	Chat.Actual.ZIndex = 6

	Chat.Amount.Name = "Amount"
	Chat.Amount.Parent = Chat.Actual
	Chat.Amount.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Amount.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Amount.BackgroundTransparency = 0.500
	Chat.Amount.BorderSizePixel = 0
	Chat.Amount.Position = UDim2.new(1, 0, 0.5, 0)
	Chat.Amount.Size = UDim2.new(0.125, 0, 0, 20)
	Chat.Amount.ZIndex = 6
	Chat.Amount.Font = Enum.Font.GothamMedium
	Chat.Amount.PlaceholderColor3 = Color3.fromRGB(220, 220, 220)
	Chat.Amount.PlaceholderText = "%"
	Chat.Amount.Text = "_"
	Chat.Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Amount.TextSize = 14.000

	Chat.UICorner_13.Parent = Chat.Amount

	Chat.UIPadding_2.Parent = Chat.Amount
	Chat.UIPadding_2.PaddingLeft = UDim.new(0, 5)
	Chat.UIPadding_2.PaddingRight = UDim.new(0, 5)

	Chat.Bar_2.Name = "Bar"
	Chat.Bar_2.Parent = Chat.Actual
	Chat.Bar_2.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Bar_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Bar_2.BorderSizePixel = 0
	Chat.Bar_2.Position = UDim2.new(0, 0, 0.5, 0)
	Chat.Bar_2.Size = UDim2.new(0.850000024, 0, 0, 10)
	Chat.Bar_2.ZIndex = 6

	Chat.Ignore.CornerRadius = UDim.new(1, 0)
	Chat.Ignore.Name = "Ignore"
	Chat.Ignore.Parent = Chat.Bar_2

	Chat.Button.Name = "Button"
	Chat.Button.Parent = Chat.Bar_2
	Chat.Button.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Button.BackgroundColor3 = Color3.fromRGB(30, 200, 150)
	Chat.Button.BorderSizePixel = 0
	Chat.Button.Position = UDim2.new(0, 10, 0.5, 0)
	Chat.Button.Size = UDim2.new(0, 20, 0, 20)
	Chat.Button.ZIndex = 7
	Chat.Button.Font = Enum.Font.SourceSans
	Chat.Button.Text = ""
	Chat.Button.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Button.TextSize = 14.000

	Chat.Ignore_2.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_2.Name = "Ignore"
	Chat.Ignore_2.Parent = Chat.Button

	Chat.Progress.Name = "Progress"
	Chat.Progress.Parent = Chat.Bar_2
	Chat.Progress.BackgroundColor3 = Color3.fromRGB(25, 170, 127)
	Chat.Progress.BorderSizePixel = 0
	Chat.Progress.Size = UDim2.new(0, 0, 1, 0)
	Chat.Progress.ZIndex = 6

	Chat.Ignore_3.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_3.Name = "Ignore"
	Chat.Ignore_3.Parent = Chat.Progress

	Chat.UICorner_14.Parent = Chat.TextSize

	Chat.Roundness.Name = "Roundness"
	Chat.Roundness.Parent = Chat.Scroller_4
	Chat.Roundness.Active = true
	Chat.Roundness.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Roundness.BackgroundTransparency = 0.500
	Chat.Roundness.BorderSizePixel = 0
	Chat.Roundness.Position = UDim2.new(0.0327868834, 0, 0.0439999998, 0)
	Chat.Roundness.Selectable = true
	Chat.Roundness.Size = UDim2.new(1, -10, 0, 55)
	Chat.Roundness.ZIndex = 6

	Chat.Center_2.Name = "Center"
	Chat.Center_2.Parent = Chat.Roundness
	Chat.Center_2.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Center_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Center_2.BackgroundTransparency = 1.000
	Chat.Center_2.Position = UDim2.new(0, 0, 0.5, 0)
	Chat.Center_2.Size = UDim2.new(1, 0, 0.75, 0)
	Chat.Center_2.ZIndex = 6

	Chat.Title_4.Name = "Title"
	Chat.Title_4.Parent = Chat.Center_2
	Chat.Title_4.AnchorPoint = Vector2.new(0.5, 0)
	Chat.Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_4.BackgroundTransparency = 1.000
	Chat.Title_4.BorderSizePixel = 0
	Chat.Title_4.Position = UDim2.new(0.5, 0, 0, 0)
	Chat.Title_4.Size = UDim2.new(0.949999988, 0, 0, 20)
	Chat.Title_4.ZIndex = 6

	Chat.Icon_7.Name = "Icon"
	Chat.Icon_7.Parent = Chat.Title_4
	Chat.Icon_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Icon_7.BackgroundTransparency = 1.000
	Chat.Icon_7.Size = UDim2.new(0, 20, 0, 20)
	Chat.Icon_7.ZIndex = 6
	Chat.Icon_7.Image = "rbxassetid://8677280864"

	Chat.Label_3.Name = "Label"
	Chat.Label_3.Parent = Chat.Title_4
	Chat.Label_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_3.BackgroundTransparency = 1.000
	Chat.Label_3.Position = UDim2.new(0, 25, 0, 0)
	Chat.Label_3.Size = UDim2.new(0.5, 0, 0, 18)
	Chat.Label_3.ZIndex = 6
	Chat.Label_3.Font = Enum.Font.GothamBold
	Chat.Label_3.Text = "Roundness"
	Chat.Label_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_3.TextSize = 14.000
	Chat.Label_3.TextXAlignment = Enum.TextXAlignment.Left

	Chat.Actual_2.Name = "Actual"
	Chat.Actual_2.Parent = Chat.Center_2
	Chat.Actual_2.AnchorPoint = Vector2.new(0.5, 1)
	Chat.Actual_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Actual_2.BackgroundTransparency = 1.000
	Chat.Actual_2.Position = UDim2.new(0.5, 0, 1, 5)
	Chat.Actual_2.Size = UDim2.new(0.949999988, 0, 0, 25)
	Chat.Actual_2.ZIndex = 6

	Chat.Amount_2.Name = "Amount"
	Chat.Amount_2.Parent = Chat.Actual_2
	Chat.Amount_2.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Amount_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Amount_2.BackgroundTransparency = 0.500
	Chat.Amount_2.BorderSizePixel = 0
	Chat.Amount_2.Position = UDim2.new(1, 0, 0.5, 0)
	Chat.Amount_2.Size = UDim2.new(0.125, 0, 0, 20)
	Chat.Amount_2.ZIndex = 6
	Chat.Amount_2.Font = Enum.Font.GothamMedium
	Chat.Amount_2.PlaceholderColor3 = Color3.fromRGB(220, 220, 220)
	Chat.Amount_2.PlaceholderText = "%"
	Chat.Amount_2.Text = "_"
	Chat.Amount_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Amount_2.TextSize = 14.000

	Chat.UICorner_15.Parent = Chat.Amount_2

	Chat.UIPadding_3.Parent = Chat.Amount_2
	Chat.UIPadding_3.PaddingLeft = UDim.new(0, 5)
	Chat.UIPadding_3.PaddingRight = UDim.new(0, 5)

	Chat.Bar_3.Name = "Bar"
	Chat.Bar_3.Parent = Chat.Actual_2
	Chat.Bar_3.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Bar_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Bar_3.BorderSizePixel = 0
	Chat.Bar_3.Position = UDim2.new(0, 0, 0.5, 0)
	Chat.Bar_3.Size = UDim2.new(0.850000024, 0, 0, 10)
	Chat.Bar_3.ZIndex = 6

	Chat.Ignore_4.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_4.Name = "Ignore"
	Chat.Ignore_4.Parent = Chat.Bar_3

	Chat.Button_2.Name = "Button"
	Chat.Button_2.Parent = Chat.Bar_3
	Chat.Button_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Button_2.BackgroundColor3 = Color3.fromRGB(30, 200, 150)
	Chat.Button_2.BorderSizePixel = 0
	Chat.Button_2.Position = UDim2.new(0, 10, 0.5, 0)
	Chat.Button_2.Size = UDim2.new(0, 20, 0, 20)
	Chat.Button_2.ZIndex = 7
	Chat.Button_2.Font = Enum.Font.SourceSans
	Chat.Button_2.Text = ""
	Chat.Button_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Button_2.TextSize = 14.000

	Chat.Ignore_5.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_5.Name = "Ignore"
	Chat.Ignore_5.Parent = Chat.Button_2

	Chat.Progress_2.Name = "Progress"
	Chat.Progress_2.Parent = Chat.Bar_3
	Chat.Progress_2.BackgroundColor3 = Color3.fromRGB(25, 170, 127)
	Chat.Progress_2.BorderSizePixel = 0
	Chat.Progress_2.Size = UDim2.new(0, 0, 1, 0)
	Chat.Progress_2.ZIndex = 6

	Chat.Ignore_6.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_6.Name = "Ignore"
	Chat.Ignore_6.Parent = Chat.Progress_2

	Chat.UICorner_16.Parent = Chat.Roundness

	Chat.Resizable.Name = "Resizable"
	Chat.Resizable.Parent = Chat.Scroller_4
	Chat.Resizable.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Resizable.BackgroundTransparency = 0.500
	Chat.Resizable.Size = UDim2.new(1, -10, 0, 30)
	Chat.Resizable.ZIndex = 6

	Chat.Title_5.Name = "Title"
	Chat.Title_5.Parent = Chat.Resizable
	Chat.Title_5.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_5.BackgroundTransparency = 1.000
	Chat.Title_5.BorderSizePixel = 0
	Chat.Title_5.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.Title_5.Size = UDim2.new(0.949999988, 0, 0, 20)
	Chat.Title_5.ZIndex = 6

	Chat.Icon_8.Name = "Icon"
	Chat.Icon_8.Parent = Chat.Title_5
	Chat.Icon_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Icon_8.BackgroundTransparency = 1.000
	Chat.Icon_8.Size = UDim2.new(0, 20, 0, 20)
	Chat.Icon_8.ZIndex = 6
	Chat.Icon_8.Image = "rbxassetid://8571348189"

	Chat.Label_4.Name = "Label"
	Chat.Label_4.Parent = Chat.Title_5
	Chat.Label_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_4.BackgroundTransparency = 1.000
	Chat.Label_4.Position = UDim2.new(0, 25, 0, 0)
	Chat.Label_4.Size = UDim2.new(0.5, 0, 0, 18)
	Chat.Label_4.ZIndex = 6
	Chat.Label_4.Font = Enum.Font.GothamBold
	Chat.Label_4.Text = "Resizable"
	Chat.Label_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_4.TextSize = 14.000
	Chat.Label_4.TextXAlignment = Enum.TextXAlignment.Left

	Chat.UICorner_17.Parent = Chat.Resizable

	Chat.Toggle.Name = "Toggle"
	Chat.Toggle.Parent = Chat.Resizable
	Chat.Toggle.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Toggle.BackgroundColor3 = Color3.fromRGB(72, 175, 240)
	Chat.Toggle.BorderSizePixel = 0
	Chat.Toggle.Position = UDim2.new(1, -5, 0.5, 0)
	Chat.Toggle.Size = UDim2.new(0, 40, 0, 18)
	Chat.Toggle.ZIndex = 6

	Chat.Ignore_7.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_7.Name = "Ignore"
	Chat.Ignore_7.Parent = Chat.Toggle

	Chat.Zone_2.Name = "Zone"
	Chat.Zone_2.Parent = Chat.Toggle
	Chat.Zone_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Zone_2.BackgroundTransparency = 1.000
	Chat.Zone_2.Size = UDim2.new(1, 0, 1, 0)
	Chat.Zone_2.ZIndex = 8
	Chat.Zone_2.Font = Enum.Font.SourceSans
	Chat.Zone_2.Text = ""
	Chat.Zone_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Zone_2.TextSize = 14.000

	Chat.Ignore_8.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_8.Name = "Ignore"
	Chat.Ignore_8.Parent = Chat.Zone_2

	Chat.Rounded.Name = "Rounded"
	Chat.Rounded.Parent = Chat.Toggle
	Chat.Rounded.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Rounded.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Rounded.Position = UDim2.new(1, -3, 0.5, 0)
	Chat.Rounded.Size = UDim2.new(0, 14, 0, 14)
	Chat.Rounded.ZIndex = 6

	Chat.Ignore_9.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_9.Name = "Ignore"
	Chat.Ignore_9.Parent = Chat.Rounded

	Chat.BubbleChat_2.Name = "BubbleChat"
	Chat.BubbleChat_2.Parent = Chat.Pages
	Chat.BubbleChat_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.BubbleChat_2.BackgroundTransparency = 1.000
	Chat.BubbleChat_2.Position = UDim2.new(1, 0, 0, 0)
	Chat.BubbleChat_2.Size = UDim2.new(1, 0, 1, 0)
	Chat.BubbleChat_2.ZIndex = 6

	Chat.Title_6.Name = "Title"
	Chat.Title_6.Parent = Chat.BubbleChat_2
	Chat.Title_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_6.BackgroundTransparency = 1.000
	Chat.Title_6.Position = UDim2.new(0, 0, 0, 5)
	Chat.Title_6.Size = UDim2.new(1, 0, 0, 30)
	Chat.Title_6.ZIndex = 6
	Chat.Title_6.Font = Enum.Font.GothamMedium
	Chat.Title_6.Text = "Bubble Chat"
	Chat.Title_6.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_6.TextSize = 20.000

	Chat.Back_2.Name = "Back"
	Chat.Back_2.Parent = Chat.Title_6
	Chat.Back_2.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Back_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Back_2.Position = UDim2.new(0, 5, 0.5, 0)
	Chat.Back_2.Size = UDim2.new(0, 25, 0, 25)
	Chat.Back_2.ZIndex = 6
	Chat.Back_2.Font = Enum.Font.SourceSans
	Chat.Back_2.Text = ""
	Chat.Back_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Back_2.TextSize = 14.000

	Chat.ImageLabel_2.Parent = Chat.Back_2
	Chat.ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.ImageLabel_2.BackgroundTransparency = 1.000
	Chat.ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.ImageLabel_2.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
	Chat.ImageLabel_2.ZIndex = 6
	Chat.ImageLabel_2.Image = "rbxassetid://8677511725"

	Chat.UICorner_18.Parent = Chat.Back_2

	Chat.Scroller_5.Name = "Scroller"
	Chat.Scroller_5.Parent = Chat.BubbleChat_2
	Chat.Scroller_5.AnchorPoint = Vector2.new(0.5, 1)
	Chat.Scroller_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Scroller_5.BackgroundTransparency = 1.000
	Chat.Scroller_5.BorderSizePixel = 0
	Chat.Scroller_5.Position = UDim2.new(0.5, 0, 1, -10)
	Chat.Scroller_5.Selectable = false
	Chat.Scroller_5.Size = UDim2.new(1, -10, 1, -50)
	Chat.Scroller_5.ZIndex = 6
	Chat.Scroller_5.BottomImage = "rbxassetid://8082116996"
	Chat.Scroller_5.CanvasSize = UDim2.new(0, 0, 0, 0)
	Chat.Scroller_5.MidImage = "rbxassetid://7488333553"
	Chat.Scroller_5.ScrollBarThickness = 5
	Chat.Scroller_5.TopImage = "rbxassetid://8082122989"

	Chat.UIListLayout_5.Parent = Chat.Scroller_5
	Chat.UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.UIListLayout_5.Padding = UDim.new(0, 5)

	Chat.AnimationStyle.Name = "AnimationStyle"
	Chat.AnimationStyle.Parent = Chat.Scroller_5
	Chat.AnimationStyle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.AnimationStyle.BackgroundTransparency = 1.000
	Chat.AnimationStyle.ClipsDescendants = true
	Chat.AnimationStyle.Size = UDim2.new(1, -10, 0, 30)
	Chat.AnimationStyle.ZIndex = 6

	Chat.Title_7.Name = "Title"
	Chat.Title_7.Parent = Chat.AnimationStyle
	Chat.Title_7.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Title_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_7.BackgroundTransparency = 1.000
	Chat.Title_7.BorderSizePixel = 0
	Chat.Title_7.Position = UDim2.new(0.5, 0, 0, 15)
	Chat.Title_7.Size = UDim2.new(0.949999988, 0, 0, 20)
	Chat.Title_7.ZIndex = 8

	Chat.Icon_9.Name = "Icon"
	Chat.Icon_9.Parent = Chat.Title_7
	Chat.Icon_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Icon_9.BackgroundTransparency = 1.000
	Chat.Icon_9.Size = UDim2.new(0, 20, 0, 20)
	Chat.Icon_9.ZIndex = 9
	Chat.Icon_9.Image = "rbxassetid://8677960616"

	Chat.Label_5.Name = "Label"
	Chat.Label_5.Parent = Chat.Title_7
	Chat.Label_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_5.BackgroundTransparency = 1.000
	Chat.Label_5.Position = UDim2.new(0, 25, 0, 0)
	Chat.Label_5.Size = UDim2.new(0, 0, 0, 18)
	Chat.Label_5.ZIndex = 9
	Chat.Label_5.Font = Enum.Font.GothamBold
	Chat.Label_5.Text = "Animation Style"
	Chat.Label_5.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_5.TextSize = 14.000
	Chat.Label_5.TextXAlignment = Enum.TextXAlignment.Left

	Chat.Drop.Name = "Drop"
	Chat.Drop.Parent = Chat.Title_7
	Chat.Drop.AnchorPoint = Vector2.new(1, 0)
	Chat.Drop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Drop.BorderSizePixel = 0
	Chat.Drop.Position = UDim2.new(1, 0, 0, 0)
	Chat.Drop.Size = UDim2.new(0, 30, 0, 20)
	Chat.Drop.ZIndex = 9
	Chat.Drop.Font = Enum.Font.SourceSans
	Chat.Drop.Text = ""
	Chat.Drop.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Drop.TextSize = 14.000

	Chat.UICorner_19.Parent = Chat.Drop

	Chat.Icon_10.Name = "Icon"
	Chat.Icon_10.Parent = Chat.Drop
	Chat.Icon_10.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Icon_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Icon_10.BackgroundTransparency = 1.000
	Chat.Icon_10.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.Icon_10.Size = UDim2.new(0, 25, 0, 25)
	Chat.Icon_10.ZIndex = 10
	Chat.Icon_10.Image = "rbxassetid://8677555693"

	Chat.Selected.Name = "Selected"
	Chat.Selected.Parent = Chat.Title_7
	Chat.Selected.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Selected.BackgroundTransparency = 1.000
	Chat.Selected.Position = UDim2.new(1, -35, 0.5, 0)
	Chat.Selected.Size = UDim2.new(0, 0, 0, 18)
	Chat.Selected.ZIndex = 9
	Chat.Selected.Font = Enum.Font.Gotham
	Chat.Selected.Text = "Linear"
	Chat.Selected.TextColor3 = Color3.fromRGB(200, 200, 200)
	Chat.Selected.TextSize = 14.000
	Chat.Selected.TextXAlignment = Enum.TextXAlignment.Right

	Chat.TopContainer.Name = "TopContainer"
	Chat.TopContainer.Parent = Chat.AnimationStyle
	Chat.TopContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.TopContainer.BackgroundTransparency = 1.000
	Chat.TopContainer.LayoutOrder = 2
	Chat.TopContainer.Size = UDim2.new(1, 0, 0, 25)
	Chat.TopContainer.ZIndex = 6

	Chat.Background.Name = "Background"
	Chat.Background.Parent = Chat.TopContainer
	Chat.Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Background.BackgroundTransparency = 1.000
	Chat.Background.LayoutOrder = 2
	Chat.Background.Size = UDim2.new(1, 0, 0, 25)
	Chat.Background.ZIndex = 6

	Chat.Main_4.Name = "Main"
	Chat.Main_4.Parent = Chat.Background
	Chat.Main_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Main_4.BackgroundTransparency = 0.500
	Chat.Main_4.LayoutOrder = 2
	Chat.Main_4.Size = UDim2.new(1, 0, 0, 30)
	Chat.Main_4.ZIndex = 6

	Chat.UICorner_20.Parent = Chat.Main_4

	Chat.Flat.Name = "Flat"
	Chat.Flat.Parent = Chat.TopContainer
	Chat.Flat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Flat.BackgroundTransparency = 0.500
	Chat.Flat.BorderSizePixel = 0
	Chat.Flat.Position = UDim2.new(0, 0, 0, 25)
	Chat.Flat.Size = UDim2.new(1, 0, 0, 5)
	Chat.Flat.Visible = false
	Chat.Flat.ZIndex = 6

	Chat.Dropdown.Name = "Dropdown"
	Chat.Dropdown.Parent = Chat.AnimationStyle
	Chat.Dropdown.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Dropdown.BackgroundTransparency = 1.000
	Chat.Dropdown.BorderSizePixel = 0
	Chat.Dropdown.ClipsDescendants = true
	Chat.Dropdown.Position = UDim2.new(0, 0, 0, 30)
	Chat.Dropdown.Size = UDim2.new(1, 0, 0, 0)
	Chat.Dropdown.ZIndex = 6
	Chat.Dropdown.AutomaticSize = Enum.AutomaticSize.Y
	
	Chat.BottomContainer.Name = "BottomContainer"
	Chat.BottomContainer.Parent = Chat.Dropdown
	Chat.BottomContainer.AnchorPoint = Vector2.new(0, 1)
	Chat.BottomContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.BottomContainer.BackgroundTransparency = 1.000
	Chat.BottomContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.BottomContainer.BorderSizePixel = 0
	Chat.BottomContainer.ClipsDescendants = true
	Chat.BottomContainer.Position = UDim2.new(0, 0, 2, -20)
	Chat.BottomContainer.Size = UDim2.new(1, 0, 1, 0)
	Chat.BottomContainer.ZIndex = 6

	Chat.Rounded_2.Name = "Rounded"
	Chat.Rounded_2.Parent = Chat.BottomContainer
	Chat.Rounded_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Rounded_2.BackgroundTransparency = 0.350
	Chat.Rounded_2.Position = UDim2.new(0, 0, 0, -30)
	Chat.Rounded_2.Size = UDim2.new(1, 0, 0, 50)
	Chat.Rounded_2.ZIndex = 6

	Chat.UICorner_21.Parent = Chat.Rounded_2

	Chat.Options.Name = "Options"
	Chat.Options.Parent = Chat.Dropdown
	Chat.Options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Options.BackgroundTransparency = 1.000
	Chat.Options.Size = UDim2.new(1, 0, 0, 0)
	Chat.Options.ZIndex = 6
	Chat.Options.AutomaticSize = Enum.AutomaticSize.Y
	
	Chat.UIListLayout_6.Parent = Chat.Options
	Chat.UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Chat.UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.UIListLayout_6.Padding = UDim.new(0, 3)

	Chat.UIPadding_4.Parent = Chat.Dropdown
	Chat.UIPadding_4.PaddingBottom = UDim.new(0, 55)

	Chat.Frame.Parent = Chat.Dropdown
	Chat.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Frame.BackgroundTransparency = 0.350
	Chat.Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.Frame.BorderSizePixel = 0
	Chat.Frame.Size = UDim2.new(1, 0, 1, -20)
	Chat.Frame.ZIndex = 6

	Chat.FadeoutTime.Name = "FadeoutTime"
	Chat.FadeoutTime.Parent = Chat.Scroller_5
	Chat.FadeoutTime.Active = true
	Chat.FadeoutTime.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.FadeoutTime.BackgroundTransparency = 0.500
	Chat.FadeoutTime.BorderSizePixel = 0
	Chat.FadeoutTime.LayoutOrder = 2
	Chat.FadeoutTime.Position = UDim2.new(0.0327868834, 0, 0.0439999998, 0)
	Chat.FadeoutTime.Selectable = true
	Chat.FadeoutTime.Size = UDim2.new(1, -10, 0, 55)
	Chat.FadeoutTime.ZIndex = 6

	Chat.Center_3.Name = "Center"
	Chat.Center_3.Parent = Chat.FadeoutTime
	Chat.Center_3.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Center_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Center_3.BackgroundTransparency = 1.000
	Chat.Center_3.Position = UDim2.new(0, 0, 0.5, 0)
	Chat.Center_3.Size = UDim2.new(1, 0, 0.75, 0)
	Chat.Center_3.ZIndex = 6

	Chat.Title_8.Name = "Title"
	Chat.Title_8.Parent = Chat.Center_3
	Chat.Title_8.AnchorPoint = Vector2.new(0.5, 0)
	Chat.Title_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_8.BackgroundTransparency = 1.000
	Chat.Title_8.BorderSizePixel = 0
	Chat.Title_8.Position = UDim2.new(0.5, 0, 0, 0)
	Chat.Title_8.Size = UDim2.new(0.949999988, 0, 0, 20)
	Chat.Title_8.ZIndex = 6

	Chat.Icon_11.Name = "Icon"
	Chat.Icon_11.Parent = Chat.Title_8
	Chat.Icon_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Icon_11.BackgroundTransparency = 1.000
	Chat.Icon_11.Size = UDim2.new(0, 20, 0, 20)
	Chat.Icon_11.ZIndex = 6
	Chat.Icon_11.Image = "rbxassetid://8677983647"

	Chat.Label_6.Name = "Label"
	Chat.Label_6.Parent = Chat.Title_8
	Chat.Label_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_6.BackgroundTransparency = 1.000
	Chat.Label_6.Position = UDim2.new(0, 25, 0, 0)
	Chat.Label_6.Size = UDim2.new(0.5, 0, 0, 18)
	Chat.Label_6.ZIndex = 6
	Chat.Label_6.Font = Enum.Font.GothamBold
	Chat.Label_6.Text = "Fade Time"
	Chat.Label_6.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_6.TextSize = 14.000
	Chat.Label_6.TextXAlignment = Enum.TextXAlignment.Left

	Chat.Actual_3.Name = "Actual"
	Chat.Actual_3.Parent = Chat.Center_3
	Chat.Actual_3.AnchorPoint = Vector2.new(0.5, 1)
	Chat.Actual_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Actual_3.BackgroundTransparency = 1.000
	Chat.Actual_3.Position = UDim2.new(0.5, 0, 1, 5)
	Chat.Actual_3.Size = UDim2.new(0.949999988, 0, 0, 25)
	Chat.Actual_3.ZIndex = 6

	Chat.Amount_3.Name = "Amount"
	Chat.Amount_3.Parent = Chat.Actual_3
	Chat.Amount_3.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Amount_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Amount_3.BackgroundTransparency = 0.500
	Chat.Amount_3.BorderSizePixel = 0
	Chat.Amount_3.Position = UDim2.new(1, 0, 0.5, 0)
	Chat.Amount_3.Size = UDim2.new(0.125, 0, 0, 20)
	Chat.Amount_3.ZIndex = 6
	Chat.Amount_3.Font = Enum.Font.GothamMedium
	Chat.Amount_3.PlaceholderColor3 = Color3.fromRGB(220, 220, 220)
	Chat.Amount_3.PlaceholderText = "%"
	Chat.Amount_3.Text = "_"
	Chat.Amount_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Amount_3.TextSize = 14.000

	Chat.UICorner_22.Parent = Chat.Amount_3

	Chat.UIPadding_5.Parent = Chat.Amount_3
	Chat.UIPadding_5.PaddingLeft = UDim.new(0, 5)
	Chat.UIPadding_5.PaddingRight = UDim.new(0, 5)

	Chat.Bar_4.Name = "Bar"
	Chat.Bar_4.Parent = Chat.Actual_3
	Chat.Bar_4.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Bar_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Bar_4.BorderSizePixel = 0
	Chat.Bar_4.Position = UDim2.new(0, 0, 0.5, 0)
	Chat.Bar_4.Size = UDim2.new(0.850000024, 0, 0, 10)
	Chat.Bar_4.ZIndex = 6

	Chat.Ignore_10.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_10.Name = "Ignore"
	Chat.Ignore_10.Parent = Chat.Bar_4

	Chat.Button_3.Name = "Button"
	Chat.Button_3.Parent = Chat.Bar_4
	Chat.Button_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Button_3.BackgroundColor3 = Color3.fromRGB(30, 200, 150)
	Chat.Button_3.BorderSizePixel = 0
	Chat.Button_3.Position = UDim2.new(0, 10, 0.5, 0)
	Chat.Button_3.Size = UDim2.new(0, 20, 0, 20)
	Chat.Button_3.ZIndex = 7
	Chat.Button_3.Font = Enum.Font.SourceSans
	Chat.Button_3.Text = ""
	Chat.Button_3.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Button_3.TextSize = 14.000

	Chat.Ignore_11.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_11.Name = "Ignore"
	Chat.Ignore_11.Parent = Chat.Button_3

	Chat.Progress_3.Name = "Progress"
	Chat.Progress_3.Parent = Chat.Bar_4
	Chat.Progress_3.BackgroundColor3 = Color3.fromRGB(25, 170, 127)
	Chat.Progress_3.BorderSizePixel = 0
	Chat.Progress_3.Size = UDim2.new(0, 0, 1, 0)
	Chat.Progress_3.ZIndex = 6

	Chat.Ignore_12.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_12.Name = "Ignore"
	Chat.Ignore_12.Parent = Chat.Progress_3

	Chat.UICorner_23.Parent = Chat.FadeoutTime

	Chat.Font.Name = "Font"
	Chat.Font.Parent = Chat.Scroller_5
	Chat.Font.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Font.BackgroundTransparency = 1.000
	Chat.Font.ClipsDescendants = true
	Chat.Font.LayoutOrder = 1
	Chat.Font.Size = UDim2.new(1, -10, 0, 30)
	Chat.Font.ZIndex = 6

	Chat.Title_9.Name = "Title"
	Chat.Title_9.Parent = Chat.Font
	Chat.Title_9.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Title_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_9.BackgroundTransparency = 1.000
	Chat.Title_9.BorderSizePixel = 0
	Chat.Title_9.Position = UDim2.new(0.5, 0, 0, 15)
	Chat.Title_9.Size = UDim2.new(0.949999988, 0, 0, 20)
	Chat.Title_9.ZIndex = 8

	Chat.Icon_12.Name = "Icon"
	Chat.Icon_12.Parent = Chat.Title_9
	Chat.Icon_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Icon_12.BackgroundTransparency = 1.000
	Chat.Icon_12.Size = UDim2.new(0, 20, 0, 20)
	Chat.Icon_12.ZIndex = 9
	Chat.Icon_12.Image = "rbxassetid://8678012976"

	Chat.Label_7.Name = "Label"
	Chat.Label_7.Parent = Chat.Title_9
	Chat.Label_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_7.BackgroundTransparency = 1.000
	Chat.Label_7.Position = UDim2.new(0, 25, 0, 0)
	Chat.Label_7.Size = UDim2.new(0, 0, 0, 18)
	Chat.Label_7.ZIndex = 9
	Chat.Label_7.Font = Enum.Font.GothamBold
	Chat.Label_7.Text = "Font"
	Chat.Label_7.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_7.TextSize = 14.000
	Chat.Label_7.TextXAlignment = Enum.TextXAlignment.Left

	Chat.Drop_2.Name = "Drop"
	Chat.Drop_2.Parent = Chat.Title_9
	Chat.Drop_2.AnchorPoint = Vector2.new(1, 0)
	Chat.Drop_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Drop_2.BorderSizePixel = 0
	Chat.Drop_2.Position = UDim2.new(1, 0, 0, 0)
	Chat.Drop_2.Size = UDim2.new(0, 30, 0, 20)
	Chat.Drop_2.ZIndex = 9
	Chat.Drop_2.Font = Enum.Font.SourceSans
	Chat.Drop_2.Text = ""
	Chat.Drop_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Drop_2.TextSize = 14.000

	Chat.UICorner_24.Parent = Chat.Drop_2

	Chat.Icon_13.Name = "Icon"
	Chat.Icon_13.Parent = Chat.Drop_2
	Chat.Icon_13.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Icon_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Icon_13.BackgroundTransparency = 1.000
	Chat.Icon_13.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.Icon_13.Size = UDim2.new(0, 25, 0, 25)
	Chat.Icon_13.ZIndex = 10
	Chat.Icon_13.Image = "rbxassetid://8677555693"

	Chat.Selected_2.Name = "Selected"
	Chat.Selected_2.Parent = Chat.Title_9
	Chat.Selected_2.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Selected_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Selected_2.BackgroundTransparency = 1.000
	Chat.Selected_2.Position = UDim2.new(1, -35, 0.5, 0)
	Chat.Selected_2.Size = UDim2.new(0, 0, 0, 18)
	Chat.Selected_2.ZIndex = 9
	Chat.Selected_2.Font = Enum.Font.Gotham
	Chat.Selected_2.Text = "GothamMedium"
	Chat.Selected_2.TextColor3 = Color3.fromRGB(200, 200, 200)
	Chat.Selected_2.TextSize = 14.000
	Chat.Selected_2.TextXAlignment = Enum.TextXAlignment.Right

	Chat.TopContainer_2.Name = "TopContainer"
	Chat.TopContainer_2.Parent = Chat.Font
	Chat.TopContainer_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.TopContainer_2.BackgroundTransparency = 1.000
	Chat.TopContainer_2.LayoutOrder = 2
	Chat.TopContainer_2.Size = UDim2.new(1, 0, 0, 25)
	Chat.TopContainer_2.ZIndex = 6

	Chat.Background_2.Name = "Background"
	Chat.Background_2.Parent = Chat.TopContainer_2
	Chat.Background_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Background_2.BackgroundTransparency = 1.000
	Chat.Background_2.LayoutOrder = 2
	Chat.Background_2.Size = UDim2.new(1, 0, 0, 25)
	Chat.Background_2.ZIndex = 6

	Chat.Main_5.Name = "Main"
	Chat.Main_5.Parent = Chat.Background_2
	Chat.Main_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Main_5.BackgroundTransparency = 0.500
	Chat.Main_5.LayoutOrder = 2
	Chat.Main_5.Size = UDim2.new(1, 0, 0, 30)
	Chat.Main_5.ZIndex = 6

	Chat.UICorner_25.Parent = Chat.Main_5

	Chat.Flat_2.Name = "Flat"
	Chat.Flat_2.Parent = Chat.TopContainer_2
	Chat.Flat_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Flat_2.BackgroundTransparency = 0.500
	Chat.Flat_2.BorderSizePixel = 0
	Chat.Flat_2.Position = UDim2.new(0, 0, 0, 25)
	Chat.Flat_2.Size = UDim2.new(1, 0, 0, 5)
	Chat.Flat_2.Visible = false
	Chat.Flat_2.ZIndex = 6

	Chat.Dropdown_2.Name = "Dropdown"
	Chat.Dropdown_2.Parent = Chat.Font
	Chat.Dropdown_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Dropdown_2.BackgroundTransparency = 1.000
	Chat.Dropdown_2.BorderSizePixel = 0
	Chat.Dropdown_2.ClipsDescendants = true
	Chat.Dropdown_2.Position = UDim2.new(0, 0, 0, 30)
	Chat.Dropdown_2.Size = UDim2.new(1, 0, 0, 0)
	Chat.Dropdown_2.ZIndex = 6
	Chat.Dropdown_2.AutomaticSize = Enum.AutomaticSize.Y
	
	Chat.BottomContainer_2.Name = "BottomContainer"
	Chat.BottomContainer_2.Parent = Chat.Dropdown_2
	Chat.BottomContainer_2.AnchorPoint = Vector2.new(0, 1)
	Chat.BottomContainer_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.BottomContainer_2.BackgroundTransparency = 1.000
	Chat.BottomContainer_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.BottomContainer_2.BorderSizePixel = 0
	Chat.BottomContainer_2.ClipsDescendants = true
	Chat.BottomContainer_2.Position = UDim2.new(0, 0, 2, -20)
	Chat.BottomContainer_2.Size = UDim2.new(1, 0, 1, 0)
	Chat.BottomContainer_2.ZIndex = 6

	Chat.Rounded_3.Name = "Rounded"
	Chat.Rounded_3.Parent = Chat.BottomContainer_2
	Chat.Rounded_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Rounded_3.BackgroundTransparency = 0.350
	Chat.Rounded_3.Position = UDim2.new(0, 0, 0, -30)
	Chat.Rounded_3.Size = UDim2.new(1, 0, 0, 50)
	Chat.Rounded_3.ZIndex = 6

	Chat.UICorner_26.Parent = Chat.Rounded_3

	Chat.Options_2.Name = "Options"
	Chat.Options_2.Parent = Chat.Dropdown_2
	Chat.Options_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Options_2.BackgroundTransparency = 1.000
	Chat.Options_2.Size = UDim2.new(1, 0, 0, 0)
	Chat.Options_2.ZIndex = 6
	Chat.Options_2.AutomaticSize = Enum.AutomaticSize.Y
	
	Chat.UIListLayout_7.Parent = Chat.Options_2
	Chat.UIListLayout_7.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Chat.UIListLayout_7.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.UIListLayout_7.Padding = UDim.new(0, 3)

	Chat.UIPadding_6.Parent = Chat.Dropdown_2
	Chat.UIPadding_6.PaddingBottom = UDim.new(0, 55)

	Chat.Frame_2.Parent = Chat.Dropdown_2
	Chat.Frame_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Frame_2.BackgroundTransparency = 0.350
	Chat.Frame_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.Frame_2.BorderSizePixel = 0
	Chat.Frame_2.Size = UDim2.new(1, 0, 1, -20)
	Chat.Frame_2.ZIndex = 6

	Chat.Enabled.Name = "Enabled"
	Chat.Enabled.Parent = Chat.Scroller_5
	Chat.Enabled.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Enabled.BackgroundTransparency = 0.500
	Chat.Enabled.LayoutOrder = -1
	Chat.Enabled.Size = UDim2.new(1, -10, 0, 30)
	Chat.Enabled.ZIndex = 6

	Chat.Title_10.Name = "Title"
	Chat.Title_10.Parent = Chat.Enabled
	Chat.Title_10.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.Title_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_10.BackgroundTransparency = 1.000
	Chat.Title_10.BorderSizePixel = 0
	Chat.Title_10.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.Title_10.Size = UDim2.new(0.949999988, 0, 0, 20)
	Chat.Title_10.ZIndex = 6

	Chat.Icon_14.Name = "Icon"
	Chat.Icon_14.Parent = Chat.Title_10
	Chat.Icon_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Icon_14.BackgroundTransparency = 1.000
	Chat.Icon_14.Size = UDim2.new(0, 20, 0, 20)
	Chat.Icon_14.ZIndex = 6
	Chat.Icon_14.Image = "rbxassetid://8685962752"

	Chat.Label_8.Name = "Label"
	Chat.Label_8.Parent = Chat.Title_10
	Chat.Label_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_8.BackgroundTransparency = 1.000
	Chat.Label_8.Position = UDim2.new(0, 25, 0, 0)
	Chat.Label_8.Size = UDim2.new(0.5, 0, 0, 18)
	Chat.Label_8.ZIndex = 6
	Chat.Label_8.Font = Enum.Font.GothamBold
	Chat.Label_8.Text = "Enabled"
	Chat.Label_8.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Label_8.TextSize = 14.000
	Chat.Label_8.TextXAlignment = Enum.TextXAlignment.Left

	Chat.UICorner_27.Parent = Chat.Enabled

	Chat.Toggle_2.Name = "Toggle"
	Chat.Toggle_2.Parent = Chat.Enabled
	Chat.Toggle_2.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Toggle_2.BackgroundColor3 = Color3.fromRGB(72, 175, 240)
	Chat.Toggle_2.BorderSizePixel = 0
	Chat.Toggle_2.Position = UDim2.new(1, -5, 0.5, 0)
	Chat.Toggle_2.Size = UDim2.new(0, 40, 0, 18)
	Chat.Toggle_2.ZIndex = 6

	Chat.Ignore_13.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_13.Name = "Ignore"
	Chat.Ignore_13.Parent = Chat.Toggle_2

	Chat.Zone_3.Name = "Zone"
	Chat.Zone_3.Parent = Chat.Toggle_2
	Chat.Zone_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Zone_3.BackgroundTransparency = 1.000
	Chat.Zone_3.Size = UDim2.new(1, 0, 1, 0)
	Chat.Zone_3.ZIndex = 8
	Chat.Zone_3.Font = Enum.Font.SourceSans
	Chat.Zone_3.Text = ""
	Chat.Zone_3.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Zone_3.TextSize = 14.000

	Chat.Ignore_14.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_14.Name = "Ignore"
	Chat.Ignore_14.Parent = Chat.Zone_3

	Chat.Rounded_4.Name = "Rounded"
	Chat.Rounded_4.Parent = Chat.Toggle_2
	Chat.Rounded_4.AnchorPoint = Vector2.new(1, 0.5)
	Chat.Rounded_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Rounded_4.Position = UDim2.new(1, -3, 0.5, 0)
	Chat.Rounded_4.Size = UDim2.new(0, 14, 0, 14)
	Chat.Rounded_4.ZIndex = 6

	Chat.Ignore_15.CornerRadius = UDim.new(1, 0)
	Chat.Ignore_15.Name = "Ignore"
	Chat.Ignore_15.Parent = Chat.Rounded_4

	Chat.QuickChat_2.Name = "QuickChat"
	Chat.QuickChat_2.Parent = Chat.Pages
	Chat.QuickChat_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.QuickChat_2.BackgroundTransparency = 1.000
	Chat.QuickChat_2.Position = UDim2.new(1, 0, 0, 0)
	Chat.QuickChat_2.Size = UDim2.new(1, 0, 1, 0)
	Chat.QuickChat_2.ZIndex = 6

	Chat.Title_11.Name = "Title"
	Chat.Title_11.Parent = Chat.QuickChat_2
	Chat.Title_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_11.BackgroundTransparency = 1.000
	Chat.Title_11.Position = UDim2.new(0, 0, 0, 5)
	Chat.Title_11.Size = UDim2.new(1, 0, 0, 30)
	Chat.Title_11.ZIndex = 6
	Chat.Title_11.Font = Enum.Font.GothamMedium
	Chat.Title_11.Text = "Quick Chat"
	Chat.Title_11.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_11.TextSize = 20.000

	Chat.Back_3.Name = "Back"
	Chat.Back_3.Parent = Chat.Title_11
	Chat.Back_3.AnchorPoint = Vector2.new(0, 0.5)
	Chat.Back_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Back_3.Position = UDim2.new(0, 5, 0.5, 0)
	Chat.Back_3.Size = UDim2.new(0, 25, 0, 25)
	Chat.Back_3.ZIndex = 6
	Chat.Back_3.Font = Enum.Font.SourceSans
	Chat.Back_3.Text = ""
	Chat.Back_3.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Back_3.TextSize = 14.000

	Chat.ImageLabel_3.Parent = Chat.Back_3
	Chat.ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.ImageLabel_3.BackgroundTransparency = 1.000
	Chat.ImageLabel_3.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.ImageLabel_3.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
	Chat.ImageLabel_3.ZIndex = 6
	Chat.ImageLabel_3.Image = "rbxassetid://8677511725"

	Chat.UICorner_28.Parent = Chat.Back_3

	Chat.Scroller_6.Name = "Scroller"
	Chat.Scroller_6.Parent = Chat.QuickChat_2
	Chat.Scroller_6.AnchorPoint = Vector2.new(0.5, 1)
	Chat.Scroller_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Scroller_6.BackgroundTransparency = 1.000
	Chat.Scroller_6.BorderSizePixel = 0
	Chat.Scroller_6.Position = UDim2.new(0.5, 0, 1, -10)
	Chat.Scroller_6.Selectable = false
	Chat.Scroller_6.Size = UDim2.new(1, -10, 1, -50)
	Chat.Scroller_6.ZIndex = 6
	Chat.Scroller_6.BottomImage = "rbxassetid://8082116996"
	Chat.Scroller_6.CanvasSize = UDim2.new(0, 0, 0, 0)
	Chat.Scroller_6.MidImage = "rbxassetid://7488333553"
	Chat.Scroller_6.ScrollBarThickness = 5
	Chat.Scroller_6.TopImage = "rbxassetid://8082122989"

	Chat.UIListLayout_8.Parent = Chat.Scroller_6
	Chat.UIListLayout_8.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.UIListLayout_8.Padding = UDim.new(0, 5)

	Chat.SaveChat.Name = "SaveChat"
	Chat.SaveChat.Parent = Chat.Chat
	Chat.SaveChat.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.SaveChat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.SaveChat.BackgroundTransparency = 0.750
	Chat.SaveChat.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.SaveChat.BorderSizePixel = 0
	Chat.SaveChat.Position = UDim2.new(0.5, 0, -1.5, 0)
	Chat.SaveChat.Size = UDim2.new(0, 150, 0, 240)

	Chat.Container_6.Name = "Container"
	Chat.Container_6.Parent = Chat.SaveChat
	Chat.Container_6.AnchorPoint = Vector2.new(0.5, 1)
	Chat.Container_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Container_6.BackgroundTransparency = 1.000
	Chat.Container_6.BorderSizePixel = 0
	Chat.Container_6.Position = UDim2.new(0.5, 0, 1, -5)
	Chat.Container_6.Selectable = false
	Chat.Container_6.Size = UDim2.new(0, 140, 1, -35)
	Chat.Container_6.BottomImage = "rbxassetid://8082116996"
	Chat.Container_6.CanvasSize = UDim2.new(0, 0, 0, 0)
	Chat.Container_6.MidImage = "rbxassetid://7488333553"
	Chat.Container_6.ScrollBarThickness = 5
	Chat.Container_6.TopImage = "rbxassetid://8082122989"

	Chat.UIListLayout_9.Parent = Chat.Container_6
	Chat.UIListLayout_9.SortOrder = Enum.SortOrder.LayoutOrder
	Chat.UIListLayout_9.Padding = UDim.new(0, 2)

	Chat.Slot.Name = "Slot"
	Chat.Slot.Parent = Chat.Container_6
	Chat.Slot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Slot.BackgroundTransparency = 0.500
	Chat.Slot.BorderSizePixel = 0
	Chat.Slot.Size = UDim2.new(1, -10, 0, 25)
	Chat.Slot.Font = Enum.Font.GothamMedium
	Chat.Slot.Text = "Slot 0"
	Chat.Slot.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Slot.TextSize = 14.000

	Chat.UICorner_29.Parent = Chat.Slot

	Chat.UICorner_30.Parent = Chat.SaveChat

	Chat.UIGradient.Rotation = -90
	Chat.UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.90, 0.00), NumberSequenceKeypoint.new(0.90, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
	Chat.UIGradient.Parent = Chat.SaveChat

	Chat.Header.Name = "Header"
	Chat.Header.Parent = Chat.SaveChat
	Chat.Header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Header.BackgroundTransparency = 1.000
	Chat.Header.ClipsDescendants = true
	Chat.Header.Position = UDim2.new(0, 0, 0, -13)
	Chat.Header.Size = UDim2.new(1, 0, 0, 35)

	Chat.UI_3.Name = "UI"
	Chat.UI_3.Parent = Chat.Header
	Chat.UI_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Chat.UI_3.BackgroundTransparency = 0.500
	Chat.UI_3.Size = UDim2.new(1, 0, 0, 48)

	Chat.Close_2.Name = "Close"
	Chat.Close_2.Parent = Chat.UI_3
	Chat.Close_2.AnchorPoint = Vector2.new(1, 0)
	Chat.Close_2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Chat.Close_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Chat.Close_2.BorderSizePixel = 0
	Chat.Close_2.Position = UDim2.new(1, -5, 0, 5)
	Chat.Close_2.Size = UDim2.new(0, 25, 0, 25)
	Chat.Close_2.ZIndex = 5
	Chat.Close_2.Font = Enum.Font.SourceSans
	Chat.Close_2.Text = ""
	Chat.Close_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	Chat.Close_2.TextSize = 14.000

	Chat.ImageLabel_4.Parent = Chat.Close_2
	Chat.ImageLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
	Chat.ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.ImageLabel_4.BackgroundTransparency = 1.000
	Chat.ImageLabel_4.Position = UDim2.new(0.5, 0, 0.5, 0)
	Chat.ImageLabel_4.Size = UDim2.new(0, 20, 0, 20)
	Chat.ImageLabel_4.ZIndex = 6
	Chat.ImageLabel_4.Image = "http://www.roblox.com/asset/?id=6031094678"

	Chat.UICorner_31.Parent = Chat.Close_2

	Chat.Title_12.Name = "Title"
	Chat.Title_12.Parent = Chat.UI_3
	Chat.Title_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_12.BackgroundTransparency = 1.000
	Chat.Title_12.Position = UDim2.new(0, 5, 0, 5)
	Chat.Title_12.Size = UDim2.new(1, 0, 0, 25)
	Chat.Title_12.ZIndex = 8
	Chat.Title_12.Font = Enum.Font.GothamBold
	Chat.Title_12.Text = "Save Chat"
	Chat.Title_12.TextColor3 = Color3.fromRGB(255, 255, 255)
	Chat.Title_12.TextSize = 14.000
	Chat.Title_12.TextXAlignment = Enum.TextXAlignment.Left

	Chat.UICorner_32.Parent = Chat.UI_3

	return Chat.Chat
end