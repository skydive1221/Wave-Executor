-- Author: @Jumpathy
-- Name: channelBar.lua
-- Description: Set up the main channel bar

local players = game:GetService("Players")
local collectionService = game:GetService("CollectionService")
local localPlayer = players.LocalPlayer

local new = function(buttonColor,textColor,font)
	local button = Instance.new("TextButton")
	button.Name = "Button"
	button.Font = font
	button.Text = "Main"
	button.TextColor3 = textColor
	button.TextSize = 14
	button.AutomaticSize = Enum.AutomaticSize.X
	button.BackgroundColor3 = buttonColor
	button.BackgroundTransparency = 0.5
	button.BorderColor3 = Color3.fromRGB(27, 42, 53)
	button.BorderSizePixel = 0
	button.Size = UDim2.fromOffset(0, 25)
	button.ZIndex = 2
	collectionService:AddTag(button,"TextFont")

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingLeft = UDim.new(0, 5)
	uIPadding.PaddingRight = UDim.new(0, 5)
	uIPadding.Parent = button

	local notifs = Instance.new("TextLabel")
	notifs.Name = "Notifs"
	notifs.Font = Enum.Font.GothamMedium
	notifs.Text = "11"
	notifs.TextColor3 = Color3.fromRGB(255, 255, 255)
	notifs.TextScaled = true
	notifs.TextSize = 14
	notifs.TextWrapped = true
	notifs.Active = true
	notifs.BackgroundColor3 = Color3.fromRGB(255, 0, 11)
	notifs.BorderSizePixel = 0
	notifs.Position = UDim2.fromScale(1, 0)
	notifs.Selectable = true
	notifs.Size = UDim2.fromOffset(12, 12)
	notifs.Visible = false
	notifs.ZIndex = 4

	local ignore = Instance.new("UICorner")
	ignore.Name = "Ignore"
	ignore.CornerRadius = UDim.new(1, 0)
	ignore.Parent = notifs

	notifs.Parent = button

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.Parent = button
	return button
end

return function(environment)
	local channelBar = {}
	local defaultChannel = "Main"
	local teamPrefix = environment.localization:getMessagePrefix("Team")
	local whisperPrefix = environment.localization:getMessagePrefix("To")
	local ui = environment.channelBarUi
	
	local colorOptions = environment.config.UI.ColorOptions
	local buttonColor = colorOptions.Buttons.ChannelButton.BackgroundColor
	local textColor = colorOptions.Buttons.ChannelButton.TextColor

	local getById = function(id)
		for _,plr in pairs(players:GetPlayers()) do
			if(math.abs(plr.UserId) == id) then
				return plr
			end
		end
	end

	local parseChannelName = function(name)
		if(name:sub(1,5) == "team_") then
			return teamPrefix
		elseif(name:sub(1,8) == "whisper_") then
			local list = name:split("_")
			local ids = {tonumber(list[2]),tonumber(list[3])}
			local target,user =  nil,""
			for _,v in pairs(ids) do
				target = getById(v)
				if(target and (target ~= localPlayer) and (target ~= nil)) then
					user = target:GetAttribute("DisplayName")
					break
				end
			end
			return whisperPrefix .. " " .. user
		else
			return name
		end
	end

	function environment:getChannelName(name)
		return parseChannelName(name)
	end

	local connections = {}

	local clear = function()
		for _,child in pairs(ui:GetChildren()) do
			if(child:IsA("TextButton")) then
				child:Destroy()
			end
		end
		for _,connection in pairs(connections) do
			connection:Disconnect()
		end
		connections = {}
	end

	local getButton = function(text)
		local button = new(buttonColor,textColor,environment.config.UI.Fonts.TextFont)
		button.Text = text
		return button
	end

	local currentlySelected
	local last
	local baseSize
	local cb

	local notificationCounts = {}
	local buttons = {}

	local handleNotifications = function(channel)
		local button = buttons[channel]
		if(button ~= nil) then
			if(notificationCounts[channel] ~= nil and (notificationCounts[channel] ~= 0)) then
				button.Notifs.Visible = true
				button.Notifs.Text = notificationCounts[channel]
			else
				button.Notifs.Visible = false
			end
		end
	end

	local clicked = function(channel)
		if not environment.fetchChannelHistory then
			repeat
				task.wait(5/1000)
			until(environment.fetchChannelHistory)
		end
		if currentlySelected ~= channel then
			environment:clearChannelNotifications(channel)
			currentlySelected = channel
			environment:fetchChannelHistory(channel)
		end
	end

	local update = function(channels,size)
		size = size or environment:getTextSize() - 1
		clear()
		local last = baseSize

		local found = false
		for _,channel in pairs(channels or {}) do
			if(currentlySelected ~= nil and (channel == currentlySelected)) then
				found = true
			end

			local parsed = parseChannelName(channel)
			local button = getButton(parsed)
			button.Parent = ui
			button.UIPadding.PaddingLeft = UDim.new(0,math.ceil(size * (5/14)))
			button.UIPadding.PaddingRight = button.UIPadding.PaddingLeft
			button.Size = UDim2.fromOffset(0,(size * (25/14)))
			button.Visible = environment.config.UI.ChannelBarEnabled

			cb = cb or button.Parent.Parent.Parent.Parent
			baseSize = (button.Size.Y.Offset * 1.4)
			cb.Size = UDim2.new(1,0,0,baseSize)

			table.insert(connections,button.MouseButton1Click:Connect(function()
				clicked(channel)
			end))

			buttons[channel] = button
			handleNotifications(channel)
		end
		if(currentlySelected) then
			if(not found) then
				environment:fetchChannelHistory(channels[1])
			end
		end
		if(last ~= baseSize) then
			if(cb.Visible) then
				cb.Visible = false
				cb.Visible = true
			end
		end
	end

	function environment:getChannelBarSize()
		return baseSize
	end

	function environment:clearChannelNotifications(channelName)
		notificationCounts[channelName] = 0
		handleNotifications(channelName)
	end

	function environment:addNotificationToChannel(channelName)
		notificationCounts[channelName] = notificationCounts[channelName] or 0
		notificationCounts[channelName] += 1
		handleNotifications(channelName)
	end

	function environment:openChannelFromBar(channel)
		clicked(channel)
	end
	
	local firstUpdate = false

	environment.network.onClientEvent("receiveChannelUpdate",function(channels)
		last = channels
		update(channels)
		if not firstUpdate then
			firstUpdate = true
			clicked(channels[1])
		end
	end)

	environment.refreshChannelSizes = function(size)
		if(last) then
			update(last,size)
		end
	end
	
	environment.network:fire("receiveChannelUpdate")

	return channelBar
end