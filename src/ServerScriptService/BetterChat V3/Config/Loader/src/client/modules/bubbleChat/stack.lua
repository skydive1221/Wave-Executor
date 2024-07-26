-- Author: @Jumpathy
-- Name: stack.lua
-- Description: Bubble chat 'stacks'

return function(environment)
	local stack = {}
	local tweenService = game:GetService("TweenService")

	local tween = function(object,properties,config)
		local isCustom = config.Custom
		local tweenInfo;
		if isCustom then
			tweenInfo = TweenInfo.new(0.1,config.EasingStyle,Enum.EasingDirection.Out)
		else
			tweenInfo = TweenInfo.new(0.1,(environment.bubbleChatAnimationStyle or environment.config.BubbleChat.Config.EasingStyle),Enum.EasingDirection.Out)
		end
		tweenService:Create(object,tweenInfo,properties):Play()
	end

	local fade = function(object,config)
		if(object:IsA("Frame")) then
			tween(object,{
				["BackgroundTransparency"] = 1
			},config)
		elseif(object:IsA("ImageLabel")) then
			tween(object,{
				["ImageTransparency"] = 1
			},config)
		elseif(object:IsA("TextLabel")) then
			tween(object,{
				["TextTransparency"] = 1
			},config)
		end
	end

	function stack.init(c)
		local configuration = c.Config
		local constructor = {}

		function constructor.new(gui,conf)
			local config = conf or configuration
			if conf then
				config.Custom = true
			end
			local stack = {
				queue = {}
			}

			function stack:update()
				local basePosition,yHeight = UDim2.fromScale(0.5,0.9),0
				for key,object in pairs(stack.queue) do
					environment.tweenPosition(object,basePosition - UDim2.fromOffset(0,yHeight),Enum.EasingDirection.Out,config.EasingStyle,config.Length,true)
					object.caret.Visible = (key == 1)
					yHeight += (object.AbsoluteSize.Y + 4)
				end
			end

			function stack:remove(ui,internal)
				local key = table.find(stack.queue,ui)
				if(key) then
					table.remove(stack.queue,key)
					local newQueue = {}
					for _,v in pairs(stack.queue) do
						table.insert(newQueue,v)
					end
					stack.queue = newQueue
					stack:update()
					if not internal then
						for guid,obj in pairs(environment.betterchatv3bubbles) do
							if(obj == ui) then
								environment.betterchatv3bubbles[guid] = nil
								environment.stacks[guid] = nil
							end
						end
					end
				end
			end

			function stack:fade(ui,len)
				for _,obj in pairs(ui:GetDescendants()) do
					fade(obj,config)
				end
				fade(ui,config)
				task.delay(len or 0.15,function()
					ui:Destroy()
				end)
			end

			function stack:push(ui,exception)
				table.insert(stack.queue,1,ui)
				stack:update()
				if(#stack.queue > config.MaxMessages) then
					while(#stack.queue > config.MaxMessages) do
						local gui = stack.queue[#stack.queue]
						stack:fade(gui)
						stack:remove(gui)
					end
				end
				if(not exception) then
					task.delay(config.FadeoutTime,function()
						if(ui:GetFullName() ~= ui.Name) then
							stack:fade(ui)
							stack:remove(ui)
						end
					end)
				end
			end

			function stack:Destroy()
				for _,obj in pairs(stack.queue) do
					obj:Destroy()
				end
				for k,v in pairs(stack) do
					stack[k] = nil
				end
				stack = nil
			end
			
			return stack
		end

		return constructor
	end

	return stack
end