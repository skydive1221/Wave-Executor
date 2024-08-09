-- Author: @Jumpathy
-- Name: prompt.lua
-- Description: Message context menu prompt

local customOptions = {}
local localPlayer = game:GetService("Players").LocalPlayer

local editPrompt = function(environment,data)
	local editPrompt = Instance.new("Frame")
	editPrompt.Name = "EditPrompt"
	editPrompt.AutomaticSize = Enum.AutomaticSize.XY
	editPrompt.BackgroundColor3 = Color3.fromRGB(40,40,40)
	editPrompt.BackgroundTransparency = 0
	editPrompt.BorderSizePixel = 0
	editPrompt.Position = UDim2.fromOffset(500, 50)
	editPrompt.Size = UDim2.fromOffset(100, 0)
	editPrompt.Visible = false
	editPrompt.ZIndex = 3

	local uIListLayout = Instance.new("UIListLayout")
	uIListLayout.Name = "UIListLayout"
	uIListLayout.Padding = UDim.new(0, 3)
	uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	uIListLayout.Parent = editPrompt
	
	local uiPadding = Instance.new("UIPadding")
	uiPadding.Parent = editPrompt
	uiPadding.PaddingLeft = UDim.new(0,5)
	uiPadding.PaddingRight = UDim.new(0,5)
	uiPadding.PaddingTop = UDim.new(0,5)
	uiPadding.PaddingBottom = UDim.new(0,5)

	local reply = Instance.new("TextButton")
	reply.Name = "Reply"
	reply.Font = Enum.Font.GothamMedium
	reply.Text = "Reply"
	reply.TextColor3 = Color3.fromRGB(255, 255, 255)
	reply.TextSize = 14
	reply.TextXAlignment = Enum.TextXAlignment.Left
	reply.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	reply.BackgroundTransparency = 0
	reply.BorderSizePixel = 0
	reply.Size = UDim2.new(1,0,0,25)
	reply.ZIndex = 5
	reply.BackgroundColor3 = Color3.fromRGB(20,20,20)

	local roundness = Instance.new("UICorner")
	roundness.Parent = reply
	roundness.CornerRadius = UDim.new(0,environment.config.UI.Rounding)

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 2)
	uIPadding.PaddingLeft = UDim.new(0, 5)
	uIPadding.PaddingRight = UDim.new(0, 5)
	uIPadding.PaddingTop = UDim.new(0, 2)
	uIPadding.Parent = reply
	
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "ImageLabel"
	imageLabel.Image = "rbxassetid://8595302757"
	imageLabel.AnchorPoint = Vector2.new(1, 0.5)
	imageLabel.BackgroundTransparency = 1
	imageLabel.BorderSizePixel = 0
	imageLabel.Position = UDim2.fromScale(1, 0.5)
	imageLabel.Size = UDim2.fromOffset(20, 20)
	imageLabel.ZIndex = 5
	imageLabel.Parent = reply

	reply.Parent = editPrompt

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 2)
	uIPadding.PaddingLeft = UDim.new(0, 10)
	uIPadding.PaddingRight = UDim.new(0, 10)
	uIPadding.PaddingTop = UDim.new(0, 2)
	uIPadding.Parent = editPrompt
	
	local roundness = Instance.new("UICorner")
	roundness.Parent = editPrompt
	roundness.CornerRadius = UDim.new(0,environment.config.UI.Rounding)

	local edit = Instance.new("TextButton")
	edit.Name = "Edit"
	edit.Font = Enum.Font.GothamMedium
	edit.Text = "Edit"
	edit.TextColor3 = Color3.fromRGB(255, 255, 255)
	edit.TextSize = 14
	edit.TextXAlignment = Enum.TextXAlignment.Left
	edit.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	edit.BackgroundTransparency = 0
	edit.BorderSizePixel = 0
	edit.LayoutOrder = 1
	edit.Size = UDim2.new(1,0,0,25)
	edit.Visible = false
	edit.ZIndex = 5
	edit.BackgroundColor3 = Color3.fromRGB(20,20,20)

	local roundness = Instance.new("UICorner")
	roundness.Parent = edit
	roundness.CornerRadius = UDim.new(0,environment.config.UI.Rounding)
	
	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 2)
	uIPadding.PaddingLeft = UDim.new(0, 5)
	uIPadding.PaddingRight = UDim.new(0, 5)
	uIPadding.PaddingTop = UDim.new(0, 2)
	uIPadding.Parent = edit

	local imageLabel1 = Instance.new("ImageLabel")
	imageLabel1.Name = "ImageLabel"
	imageLabel1.Image = "rbxassetid://8603600017"
	imageLabel1.AnchorPoint = Vector2.new(1, 0.5)
	imageLabel1.BackgroundTransparency = 1
	imageLabel1.BorderSizePixel = 0
	imageLabel1.Position = UDim2.fromScale(1, 0.5)
	imageLabel1.Size = UDim2.fromOffset(20, 20)
	imageLabel1.ZIndex = 5
	imageLabel1.Parent = edit

	edit.Parent = editPrompt

	local quickChat = Instance.new("TextButton")
	quickChat.Name = "QuickChat"
	quickChat.Font = Enum.Font.GothamMedium
	quickChat.Text = "Add"
	quickChat.TextColor3 = Color3.fromRGB(255, 255, 255)
	quickChat.TextSize = 14
	quickChat.TextXAlignment = Enum.TextXAlignment.Left
	quickChat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	quickChat.BackgroundTransparency = 0
	quickChat.BorderSizePixel = 0
	quickChat.LayoutOrder = 2
	quickChat.Size = UDim2.new(1,0,0,25)
	quickChat.ZIndex = 5
	quickChat.BackgroundColor3 = Color3.fromRGB(20,20,20)

	local roundness = Instance.new("UICorner")
	roundness.Parent = quickChat
	roundness.CornerRadius = UDim.new(0,environment.config.UI.Rounding)
	
	
	local imageLabel2 = Instance.new("ImageLabel")
	imageLabel2.Name = "ImageLabel"
	imageLabel2.Image = "rbxassetid://6031243319"
	imageLabel2.AnchorPoint = Vector2.new(1, 0.5)
	imageLabel2.BackgroundTransparency = 1
	imageLabel2.BorderSizePixel = 0
	imageLabel2.Position = UDim2.fromScale(1, 0.5)
	imageLabel2.Size = UDim2.fromOffset(20, 20)
	imageLabel2.ZIndex = 5
	imageLabel2.Parent = quickChat
	
	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 2)
	uIPadding.PaddingLeft = UDim.new(0, 5)
	uIPadding.PaddingRight = UDim.new(0, 5)
	uIPadding.PaddingTop = UDim.new(0, 2)
	uIPadding.Parent = quickChat
	
	local delete = Instance.new("TextButton")
	delete.Name = "Delete"
	delete.Font = Enum.Font.GothamMedium
	delete.Text = "Unsend"
	delete.TextColor3 = Color3.fromRGB(255, 255, 255)
	delete.TextSize = 14
	delete.TextXAlignment = Enum.TextXAlignment.Left
	delete.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	delete.BackgroundTransparency = 0
	delete.BorderSizePixel = 0
	delete.LayoutOrder = 2
	delete.Size = UDim2.new(1,0,0,25)
	delete.ZIndex = 5
	delete.BackgroundColor3 = Color3.fromRGB(20,20,20)

	local roundness = Instance.new("UICorner")
	roundness.Parent = delete
	roundness.CornerRadius = UDim.new(0,environment.config.UI.Rounding)

	local imageLabel2 = Instance.new("ImageLabel")
	imageLabel2.Name = "ImageLabel"
	imageLabel2.Image = "rbxassetid://6022668885"
	imageLabel2.AnchorPoint = Vector2.new(1, 0.5)
	imageLabel2.BackgroundTransparency = 1
	imageLabel2.BorderSizePixel = 0
	imageLabel2.Position = UDim2.fromScale(1, 0.5)
	imageLabel2.Size = UDim2.fromOffset(20, 20)
	imageLabel2.ZIndex = 5
	imageLabel2.Parent = delete

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 2)
	uIPadding.PaddingLeft = UDim.new(0, 5)
	uIPadding.PaddingRight = UDim.new(0, 5)
	uIPadding.PaddingTop = UDim.new(0, 2)
	uIPadding.Parent = delete
	
	quickChat.Parent = editPrompt
	delete.Parent = editPrompt
	
	for _,option in pairs(customOptions) do
		local createObject = true
		
		if not option.selfCanSee then
			if data.isPlayer and data.senderId == localPlayer.UserId then
				createObject = false
			end
		end
		
		local create = function()
			local customButton = Instance.new("TextButton")
			customButton.Name = option.text
			customButton.Font = Enum.Font.GothamMedium
			customButton.Text = option.text
			customButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			customButton.TextSize = 14
			customButton.TextXAlignment = Enum.TextXAlignment.Left
			customButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			customButton.BackgroundTransparency = 0
			customButton.BorderSizePixel = 0
			customButton.LayoutOrder = 2
			customButton.Size = UDim2.new(1,0,0,25)
			customButton.ZIndex = 5
			customButton.BackgroundColor3 = Color3.fromRGB(20,20,20)

			local roundness = Instance.new("UICorner")
			roundness.Parent = customButton
			roundness.CornerRadius = UDim.new(0,environment.config.UI.Rounding)

			local imageLabel2 = Instance.new("ImageLabel")
			imageLabel2.Name = "ImageLabel"
			imageLabel2.Image = option.icon
			imageLabel2.AnchorPoint = Vector2.new(1, 0.5)
			imageLabel2.BackgroundTransparency = 1
			imageLabel2.BorderSizePixel = 0
			imageLabel2.Position = UDim2.fromScale(1, 0.5)
			imageLabel2.Size = UDim2.fromOffset(20, 20)
			imageLabel2.ZIndex = 5
			imageLabel2.Parent = customButton

			local uIPadding = Instance.new("UIPadding")
			uIPadding.Name = "UIPadding"
			uIPadding.PaddingBottom = UDim.new(0, 2)
			uIPadding.PaddingLeft = UDim.new(0, 5)
			uIPadding.PaddingRight = UDim.new(0, 5)
			uIPadding.PaddingTop = UDim.new(0, 2)
			uIPadding.Parent = customButton

			customButton.Parent = editPrompt
		end
		
		if createObject then
			create()
		end
	end

	return editPrompt
end

return function(environment,functions)
	local quickChatEnabled = environment.config.Messages.QuickChat
	
	local options = {}
	local lastPrompt;
	
	function environment:addPromptOption(text,icon,visibleBySelf,callback)
		table.insert(customOptions,{
			text = text,
			icon = icon,
			callback = callback,
			selfCanSee = visibleBySelf
		})
	end
	
	return {open = function(self,object,data,collector,edit)
		for _,obj in pairs(environment.gui:GetChildren()) do
			if(obj.Name == "EditPrompt") then
				obj:Destroy()
			end
		end
		
		local prompt = editPrompt(environment,data)
		prompt.Parent = environment.gui
		prompt.Visible = true
		
		prompt.Edit.Visible = options[object]["canEdit"]
		prompt.Reply.Visible = options[object]["canReply"]
		prompt.QuickChat.Visible = (data.senderId == localPlayer.UserId) and quickChatEnabled
		prompt.Delete.Visible = (data.senderId == localPlayer.UserId) and data.deletingEnabled

		for _,obj in pairs(prompt:GetChildren()) do
			if(obj:IsA("TextButton")) then
				obj.MouseButton1Down:Connect(function()
					if(obj.Name == "Reply") then
						functions:initReply(data)
					elseif(obj.Name == "Edit") then
						edit:CaptureFocus()
					elseif(obj.Name == "Delete") then
						environment:deleteMessage(data)
					elseif(obj.Name == "QuickChat") then
						environment:openSaveChat(data.unfiltered)
					else
						for _,option in pairs(customOptions) do
							if(option.text == obj.Name) then
								task.spawn(option.callback,data)
							end
						end
					end
					lastPrompt:Destroy()
					lastPrompt = nil
				end)
			end
		end

		collector:add(object.Changed:Connect(function()
			if(lastPrompt == prompt) then
				prompt.Position = UDim2.fromOffset(
					object.AbsolutePosition.X,object.AbsolutePosition.Y + object.AbsoluteSize.Y
				)
			end
		end))

		lastPrompt = prompt
		object.ZIndex += 1
		object.ZIndex -= 1
		return prompt
	end,set = function(self,object,canEdit,canReply)
		options[object] = {
			canEdit = canEdit,
			canReply = canReply
		}
	end,removeData = function(self,object)
		options[object] = nil
	end}
end