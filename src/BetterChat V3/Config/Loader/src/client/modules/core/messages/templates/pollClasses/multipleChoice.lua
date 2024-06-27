-- Author: @Jumpathy
-- Name: multipleChoice.lua
-- Description: Multiple choice poll option

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local localId = localPlayer.UserId

local createVoterHeadshot = function(id)
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "ImageLabel"
	imageLabel.Image = ("rbxthumb://type=AvatarHeadShot&id=%s&w=150&h=150"):format(id)
	imageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Size = UDim2.fromOffset(100, 100)

	local uICorner1 = Instance.new("UICorner")
	uICorner1.Name = "UICorner"
	uICorner1.CornerRadius = UDim.new(1, 0)
	uICorner1.Parent = imageLabel
	return imageLabel
end

local createCloseButton = function()
	local close = Instance.new("TextButton")
	close.Name = "Close"
	close.Font = Enum.Font.GothamMedium
	close.Text = "Close"
	close.TextColor3 = Color3.fromRGB(255, 255, 255)
	close.TextSize = 14
	close.TextXAlignment = Enum.TextXAlignment.Right
	close.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	close.BorderSizePixel = 0
	close.Position = UDim2.new(0, 5, 0, 5)
	close.Size = UDim2.fromOffset(73, 25)

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.Parent = close

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingLeft = UDim.new(0, 5)
	uIPadding.PaddingRight = UDim.new(0, 5)
	uIPadding.Parent = close

	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "ImageLabel"
	imageLabel.Image = "http://www.roblox.com/asset/?id=6031094678"
	imageLabel.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel.BackgroundTransparency = 1
	imageLabel.BorderSizePixel = 0
	imageLabel.Position = UDim2.fromScale(0, 0.5)
	imageLabel.Size = UDim2.fromOffset(20, 20)
	imageLabel.Parent = close
	return close
end

local createStopButton = function()
	local stop = Instance.new("TextButton")
	stop.Name = "Stop"
	stop.Font = Enum.Font.GothamMedium
	stop.Text = "Stop"
	stop.TextColor3 = Color3.fromRGB(255, 255, 255)
	stop.TextSize = 14
	stop.TextXAlignment = Enum.TextXAlignment.Right
	stop.AutomaticSize = Enum.AutomaticSize.X
	stop.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	stop.BorderSizePixel = 0
	stop.AnchorPoint = Vector2.new(1,0)
	stop.Position = UDim2.new(1,-5, 0, 5)
	stop.Size = UDim2.fromOffset(66, 25)

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.Parent = stop

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingLeft = UDim.new(0, 5)
	uIPadding.PaddingRight = UDim.new(0, 5)
	uIPadding.Parent = stop

	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "ImageLabel"
	imageLabel.Image = "http://www.roblox.com/asset/?id=6026681576"
	imageLabel.AnchorPoint = Vector2.new(0, 0.5)
	imageLabel.BackgroundTransparency = 1
	imageLabel.BorderSizePixel = 0
	imageLabel.Position = UDim2.fromScale(0, 0.5)
	imageLabel.Size = UDim2.fromOffset(20, 20)
	imageLabel.Parent = stop
	return stop
end

local create = function(titleText,imageId,optionsList,callback)
	local multipleChoicePoll = Instance.new("Frame")
	multipleChoicePoll.Name = "MultipleChoicePoll"
	multipleChoicePoll.AutomaticSize = Enum.AutomaticSize.Y
	multipleChoicePoll.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	multipleChoicePoll.BackgroundTransparency = 0.5
	multipleChoicePoll.BorderColor3 = Color3.fromRGB(27, 42, 53)
	multipleChoicePoll.Size = UDim2.fromScale(1, 0)
	
	local closeButton = createCloseButton()
	closeButton.Parent = multipleChoicePoll
	closeButton.Visible = false
	
	local hasHeader = titleText ~= "" or imageId
	
	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Font = Enum.Font.GothamBold
	title.Text = titleText
	title.TextColor3 = Color3.fromRGB(230, 230, 230)
	title.TextSize = 16
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1
	title.Position = UDim2.fromOffset(0, 5)
	title.Size = UDim2.new(1, 0, 0, 25)
	title.Parent = multipleChoicePoll

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.Parent = multipleChoicePoll

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 10)
	uIPadding.Parent = multipleChoicePoll

	local percent = Instance.new("Frame")
	percent.Name = "Percent"
	percent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	percent.BorderSizePixel = 0
	percent.Position = UDim2.fromOffset(5,35)
	percent.Size = UDim2.fromScale(1, 0)
	percent.Visible = false

	local uIListLayout = Instance.new("UIListLayout")
	uIListLayout.Name = "UIListLayout"
	uIListLayout.Padding = UDim.new(0, 10)
	uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.Parent = percent

	local option = Instance.new("Frame")
	option.Name = "Option"
	option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	option.BackgroundTransparency = 1
	option.LayoutOrder = 1
	option.Size = UDim2.new(1, -10, 0, 50)
	option.AutomaticSize = Enum.AutomaticSize.Y
	
	local frame = Instance.new("Frame")
	frame.Name = "Frame"
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.Position = UDim2.fromScale(0.5, 0)
	frame.Size = UDim2.new(1, -10, 1,0)

	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Font = Enum.Font.GothamMedium
	label.Text = "hey"
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 14
	label.AnchorPoint = Vector2.new(0.5,0)
	label.TextTruncate = Enum.TextTruncate.AtEnd
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromScale(0.5,0)
	label.Size = UDim2.new(1,0,0,20)

	label.Parent = frame

	local holder = Instance.new("Frame")
	holder.Name = "Holder"
	holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	holder.BorderSizePixel = 0
	holder.LayoutOrder = 2
	holder.AnchorPoint = Vector2.new(1/2,0)
	holder.Position = UDim2.new(0.5,0,0,25)
	holder.Size = UDim2.new(1, 0, 0, 20)

	local percentage = Instance.new("Frame")
	percentage.Name = "Percentage"
	percentage.BackgroundColor3 = Color3.fromRGB(13, 150, 255)
	percentage.BorderSizePixel = 0
	percentage.LayoutOrder = 2
	percentage.Size = UDim2.new(0.5,1)
	percentage.ZIndex = 2
	percentage.Parent = holder

	holder.Parent = frame
	frame.Parent = option

	local voters = Instance.new("Frame")
	voters.Name = "Voters"
	voters.AnchorPoint = Vector2.new(0.5, 0)
	voters.AutomaticSize = Enum.AutomaticSize.Y
	voters.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	voters.BackgroundTransparency = 0.5
	voters.BorderColor3 = Color3.fromRGB(27, 42, 53)
	voters.Position = UDim2.new(0.5, 0, 0, 50)
	voters.Size = UDim2.new(1, -10, 0, 0)
	voters.Visible = false

	local uIGridLayout = Instance.new("UIGridLayout")
	uIGridLayout.Name = "UIGridLayout"
	uIGridLayout.CellSize = UDim2.fromOffset(20, 20)
	uIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIGridLayout.Parent = voters

	local uIPadding1 = Instance.new("UIPadding")
	uIPadding1.Name = "UIPadding"
	uIPadding1.PaddingBottom = UDim.new(0, 5)
	uIPadding1.PaddingLeft = UDim.new(0, 5)
	uIPadding1.PaddingRight = UDim.new(0, 5)
	uIPadding1.PaddingTop = UDim.new(0, 5)
	uIPadding1.Parent = voters

	local uICorner2 = Instance.new("UICorner")
	uICorner2.Name = "UICorner"
	uICorner2.Parent = voters

	voters.Parent = option

	option.Parent = percent

	percent.Parent = multipleChoicePoll

	local options = Instance.new("Frame")
	options.Name = "Options"
	options.AutomaticSize = Enum.AutomaticSize.Y
	options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	options.BackgroundTransparency = 1
	options.Size = UDim2.fromScale(1, 0)
	
	local image = Instance.new("ImageLabel")
	image.Name = "Image"
	image.Image = "rbxassetid://3359973082"
	image.ScaleType = Enum.ScaleType.Fit
	image.Active = true
	image.AnchorPoint = Vector2.new(1, 0)
	image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	image.BackgroundTransparency = 1
	image.Position = UDim2.new(1, -5, 0, 5)
	image.Size = UDim2.fromOffset(50, 50)
	image.Visible = false
	if(imageId) then
		image.Image = imageId
		image.Visible = true
	end

	local uICorner3 = Instance.new("UICorner")
	uICorner3.Name = "UICorner"
	uICorner3.Parent = image

	image.Parent = options

	local holder1 = Instance.new("Frame")
	holder1.Name = "Holder"
	holder1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	holder1.BorderSizePixel = 0
	holder1.Position = UDim2.fromOffset(0,(hasHeader and 35 or 5))
	holder1.Size = UDim2.fromScale(1, 0)

	local uIListLayout2 = Instance.new("UIListLayout")
	uIListLayout2.Name = "UIListLayout"
	uIListLayout2.Padding = UDim.new(0, 5)
	uIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout2.Parent = holder1

	local option1 = Instance.new("Frame")
	option1.Name = "Option"
	option1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	option1.BackgroundTransparency = 1
	option1.Size = UDim2.new(1, -10, 0, 20)

	local selectButton = Instance.new("ImageButton")
	selectButton.Name = "Select"
	selectButton.Image = "http://www.roblox.com/asset/?id=6031068433"
	selectButton.Active = false
	selectButton.BackgroundTransparency = 1
	selectButton.BorderSizePixel = 0
	selectButton.Selectable = false
	selectButton.Size = UDim2.fromOffset(20, 20)
	selectButton.Parent = option1

	local label1 = Instance.new("TextLabel")
	label1.Name = "Label"
	label1.Font = Enum.Font.GothamMedium
	label1.Text = "No"
	label1.TextColor3 = Color3.fromRGB(255, 255, 255)
	label1.TextSize = 14
	label1.TextTruncate = Enum.TextTruncate.AtEnd
	label1.TextXAlignment = Enum.TextXAlignment.Left
	label1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label1.BackgroundTransparency = 1
	label1.Position = UDim2.fromOffset(25, 0)
	label1.Size = UDim2.new(1, -60, 1, 0)
	label1.Parent = option1

	option1.Parent = holder1

	local template = option1:Clone()
	option1:Destroy()

	for _,option in pairs(optionsList) do
		local obj = template:Clone()
		obj.Label.Text = option
		obj.Parent = holder1
		obj.Select.MouseButton1Click:Connect(function()
			callback(option)
		end)
	end

	holder1.Parent = options

	options.Parent = multipleChoicePoll
	return multipleChoicePoll
end

return function(data,callback,close,stopPoll)
	local object = create(data.title,data.image,data.multipleChoice,callback)
	local template = object.Percent.Option:Clone()
	object.Percent.Option:Destroy()
	
	print(data)
	if(data.creator == localId) then
		local stop = createStopButton()
		stop.Parent = object
		stop.MouseButton1Click:Connect(function()
			print("lets request")
			stopPoll()
		end)
	end
	
	return {
		actual = object,
		onVoted = function(new)
			if(object:FindFirstChild("Options")) then
				object.Options:Destroy()
			end
			object.Percent.Visible = true
			object.Close.Visible = true
			object.Close.MouseButton1Click:Connect(function()
				object:Destroy()
				close()
			end)
			local votes = new.votes
			local cast,order = {},{}
			local totalVotes = 0
			for key,choice in pairs(new.multipleChoice) do
				order[choice] = key
				if(votes[choice] ~= nil) then
					local votesForChoice = votes[choice]
					cast[choice] = votes[choice]
					totalVotes += (new.seeWhoVoted and #votes[choice] or votes[choice])
				else
					cast[choice] = new.seeWhoVoted and {} or 0
				end
			end
			for _,child in pairs(object.Percent:GetChildren()) do
				if(child:IsA("Frame")) then
					child:Destroy()
				end
			end
			for name,votes in pairs(cast) do
				local voteCount;
				if(typeof(votes) == "table") then
					voteCount = #votes
				else
					voteCount = votes
				end
				local clone = template:Clone()
				clone.Frame.Label.Text = name
				clone.Parent = object.Percent
				clone.LayoutOrder = order[name]
				clone.Frame.Holder.Percentage.Size = UDim2.fromScale((voteCount / totalVotes),1)
				if(not new.seeWhoVoted) then
					clone.Voters:Destroy()
				else
					clone.Voters.Visible = true
					for _,child in pairs(clone.Voters:GetChildren()) do
						if(child:IsA("ImageLabel")) then
							child:Destroy()
						end
					end
					for _,id in pairs(votes) do
						createVoterHeadshot(id).Parent = clone.Voters
					end
				end
			end
		end,
	}
end