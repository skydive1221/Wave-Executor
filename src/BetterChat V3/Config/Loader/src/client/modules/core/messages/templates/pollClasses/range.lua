-- Author: @Jumpathy
-- Name: range.lua
-- Description: Range poll creator

local create = function(titleText,imageId)
	local hasHeader = titleText ~= "" or imageId

	local rangePoll = Instance.new("Frame")
	rangePoll.Name = "RangePoll"
	rangePoll.AutomaticSize = Enum.AutomaticSize.Y
	rangePoll.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	rangePoll.BackgroundTransparency = 0.5
	rangePoll.BorderColor3 = Color3.fromRGB(27, 42, 53)
	rangePoll.Size = UDim2.fromScale(1, 0)

	local title = Instance.new("TextLabel")
	title.Name = titleText
	title.Font = Enum.Font.GothamBold
	title.Text = "Testing"
	title.TextColor3 = Color3.fromRGB(230, 230, 230)
	title.TextSize = 16
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1
	title.Position = UDim2.fromOffset(0, 5)
	title.Size = UDim2.new(1, 0, 0, 25)
	title.Parent = rangePoll

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.Parent = rangePoll

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 10)
	uIPadding.Parent = rangePoll

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
	
	local uICorner1 = Instance.new("UICorner")
	uICorner1.Name = "UICorner"
	uICorner1.Parent = image

	image.Parent = options

	local holder = Instance.new("Frame")
	holder.Name = "Holder"
	holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	holder.BorderSizePixel = 0
	holder.Position = UDim2.fromOffset(0, (hasHeader and 35 or 5))
	holder.Size = UDim2.fromScale(1, 0)

	local uIListLayout = Instance.new("UIListLayout")
	uIListLayout.Name = "UIListLayout"
	uIListLayout.Padding = UDim.new(0, 5)
	uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.Parent = holder

	local option = Instance.new("Frame")
	option.Name = "Option"
	option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	option.BackgroundTransparency = 1
	option.Size = UDim2.new(1, -10, 0, 20)

	local selectButton = Instance.new("ImageButton")
	selectButton.Name = "Select"
	selectButton.Image = "http://www.roblox.com/asset/?id=6031068433"
	selectButton.Active = false
	selectButton.BackgroundTransparency = 1
	selectButton.BorderSizePixel = 0
	selectButton.Selectable = false
	selectButton.Size = UDim2.fromOffset(20, 20)
	selectButton.Parent = option

	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Font = Enum.Font.GothamMedium
	label.Text = "1"
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 14
	label.TextTruncate = Enum.TextTruncate.AtEnd
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.Position = UDim2.fromOffset(25, 0)
	label.Size = UDim2.new(1, -60, 1, 0)
	label.Parent = option

	option.Parent = holder

	holder.Parent = options

	options.Parent = rangePoll

	local percent = Instance.new("Frame")
	percent.Name = "Percent"
	percent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	percent.BorderSizePixel = 0
	percent.Position = UDim2.fromOffset(0, (hasHeader and 35 or 5))
	percent.Size = UDim2.fromScale(1, 0)
	percent.Visible = false

	local uIListLayout1 = Instance.new("UIListLayout")
	uIListLayout1.Name = "UIListLayout"
	uIListLayout1.Padding = UDim.new(0, 10)
	uIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout1.Parent = percent

	local option1 = Instance.new("TextLabel")
	option1.Name = "Option"
	option1.Font = Enum.Font.GothamMedium
	option1.RichText = true
	option1.Text = "<font color=\"rgb(200,200,200)\">Average:</font> 200"
	option1.TextColor3 = Color3.fromRGB(255, 255, 255)
	option1.TextSize = 15
	option1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	option1.BackgroundTransparency = 1
	option1.LayoutOrder = 1
	option1.Size = UDim2.new(1, -10, 0, 20)
	option1.ZIndex = 2
	option1.Parent = percent

	percent.Parent = rangePoll
	return rangePoll
end

return function(data,callback)
	local object = create(data.title,data.image)
	local raw = object.Options.Holder.Option
	local holder = raw.Parent
	local template = raw:Clone()
	
	raw:Destroy()
	for _,option in pairs(data.rangeChoices) do
		local clone = template:Clone()
		clone.Parent = holder
		clone.Label.Text = tostring(option)
		clone:FindFirstChild("Select").MouseButton1Click:Connect(function()
			callback(option)
		end)
	end
	
	local round = function(num,places)
		local mult = 10 ^ (places or 0)
		return math.floor(num * mult + 0.5)/mult
	end
		
	return {
		actual = object,
		onVoted = function(new)
			local votes = new.votes
			if(object:FindFirstChild("Options")) then
				object.Options:Destroy()
			end
			object.Percent.Visible = true
			local sum,totalVotes = 0,0
			for key,votes in pairs(new.votes) do
				totalVotes += votes
				sum += (key * votes)
			end
			local avg = round(sum/totalVotes,3)
			object.Percent.Option.Text = ("<font color=\"rgb(200,200,200)\">Average:</font> %s"):format(tostring(avg))
		end,
	}
end