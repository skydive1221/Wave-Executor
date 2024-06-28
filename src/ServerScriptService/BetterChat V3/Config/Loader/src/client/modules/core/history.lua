-- Author: @Jumpathy
-- Name: history.lua
-- Description: Ctrl+Y / Ctrl+Z support
-- Credit: @boatbomber for TextBox+'s undo/redo system base

return function(box,api)
	-------- Services: --------

	local userInput = game:GetService("UserInputService")
	local runService = game:GetService("RunService")

	-------- Variables: --------

	local lastChange,lastSnap,lastText = tick(),tick(),""
	local holdingCtrl,held,controller,ignores,stacks = false,{},{},{},{
		undo = {},
		redo = {}
	}

	-------- Functions: --------

	local apply = function(waypoint)
		for property,value in pairs(waypoint) do
			box[property] = (property == "Text" and api:CalculateText(value) or value)
		end
	end

	-------- History controller: --------

	function controller:snap()
		table.insert(stacks.undo,{
			Text = api:GetText(),
			CursorPosition = box.CursorPosition,
			SelectionStart = box.SelectionStart
		})
		if(#stacks.redo > 0) then
			stacks.redo = {}
		end
		while(#stacks.undo > 30) do
			table.remove(stacks.undo,1)
		end
	end

	controller[Enum.KeyCode.Z] = function()
		if(#stacks.undo > 1) then
			local waypoint = stacks.undo[#stacks.undo - 1]
			apply(waypoint)
			ignores[box] = true
			table.insert(stacks.redo,stacks.undo[#stacks.undo])
			table.remove(stacks.undo,#stacks.undo)
		end
	end

	controller[Enum.KeyCode.Y] = function()
		if(#stacks.redo > 0) then
			local waypoint = stacks.redo[#stacks.redo]
			apply(waypoint)
			ignores[box] = true
			table.insert(stacks.undo,waypoint)
			table.remove(stacks.redo,#stacks.redo)
		end
	end

	-------- Connections: --------

	userInput.InputBegan:Connect(function(input)
		if(box:IsFocused()) then
			if(input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl) then
				if(not holdingCtrl) then
					holdingCtrl = true
					local signal
					signal = input.Changed:Connect(function()
						if(input.UserInputState == Enum.UserInputState.End) then
							signal:Disconnect()
							holdingCtrl = false
						end
					end)
				end
			elseif(input.KeyCode == Enum.KeyCode.Y or input.KeyCode == Enum.KeyCode.Z) then
				if(holdingCtrl and not held[input.KeyCode]) then
					local signal
					held[input] = true
					held[input.KeyCode] = true
					signal = input.Changed:Connect(function()
						if(input.UserInputState == Enum.UserInputState.End) then
							signal:Disconnect()
							held[input] = false
							held[input.KeyCode] = false
						end
					end)
					local began = tick()
					while(held[input]) do
						local elapsed = tick() - began
						controller[input.KeyCode]()
						task.wait(math.clamp((0.5 - (elapsed / 8)),0.1,math.huge))
					end
				end
			end
		end
	end)

	box:GetPropertyChangedSignal("Text"):Connect(function()
		lastChange = tick()
	end)

	runService.Heartbeat:Connect(function()
		if(lastText == box.Text) then
			return
		end
		if(ignores[box]) then
			ignores[box] = nil
			lastText = box.Text
			return
		end
		if(tick() - lastChange > 0.5) or (tick() - lastSnap > 2) or (math.abs(#lastText - #box.Text) > 10) then
			lastSnap = tick()
			lastText = box.Text
			controller:snap()
		end
	end)

	controller:snap()
end