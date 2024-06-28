-- Author: @Jumpathy
-- Name: settingsMenu.lua
-- Description: Settings menu for the GUI controller

local constructors = {}
local folder = script.Parent:WaitForChild("constructors")
local starterGui = game:GetService("StarterGui")
local topbar = require(script.Parent:WaitForChild("topbarPlus"):WaitForChild("icons"))
local localPlayer = game:GetService("Players").LocalPlayer
local chatService = game:GetService("Chat")

constructors.dropdown = require(folder:WaitForChild("dropdown"))
constructors.toggle = require(folder:WaitForChild("toggle"))
constructors.slider = require(folder:WaitForChild("slider"))
constructors.quickChatDropdown = require(folder:WaitForChild("quickChatDropdown"))

return function(environment)
	local quickChatEnabled = environment.config.Messages.QuickChat

	local ui = environment.gui:WaitForChild("Settings")
	local config = environment.config
	local state = false

	environment.settingChanged = environment.signal.new()

	function environment:toggleSettingsMenu()
		state = not state
		environment.container.Visible = not state
		local position = state and UDim2.new(0.5,0,0.5,0) or UDim2.new(0.5,0,-1.5,0)
		ui:TweenPosition(position,Enum.EasingDirection.Out,Enum.EasingStyle.Linear,0.16,true)
		environment:setChatLocked(state)
	end

	local pages = {"UI","BubbleChat","QuickChat"}
	if(not quickChatEnabled) then
		table.remove(pages,3)
	end

	local pageContainer = ui:WaitForChild("Pages")
	local navigation = pageContainer:WaitForChild("Navigation")
	local args = {Enum.EasingDirection.In,Enum.EasingStyle.Quad,0.16,true}
	local outPosition = UDim2.fromScale(-1,0)
	local inPosition = UDim2.fromScale(0,0)

	local selectPage = function(page)
		navigation:TweenPosition(outPosition,unpack(args))
		page.Position = UDim2.fromScale(1,0)
		page:TweenPosition(inPosition,unpack(args))
	end

	local back = function(page)
		navigation:TweenPosition(inPosition,unpack(args))
		page:TweenPosition(UDim2.fromScale(1,0),unpack(args))
	end

	for _,pageName in pairs(pages) do
		local button = navigation:WaitForChild("Content"):WaitForChild(pageName)
		button.MouseButton1Click:Connect(function()
			selectPage(pageContainer[pageName])
		end)
		pageContainer:WaitForChild(pageName):WaitForChild("Title"):WaitForChild("Back").MouseButton1Click:Connect(function()
			back(pageContainer[pageName])
		end)
	end

	local getTableFromIdx = function(tbl,idx)
		local ret = {}
		for _,option in pairs(tbl) do
			table.insert(ret,option[idx])
		end
		return ret
	end

	local getFontsList = function(priority)
		local list = Enum.Font:GetEnumItems()
		local key = table.find(list,priority)
		table.remove(list,key)
		table.insert(list,1,priority)
		local ret = {}
		for k,v in pairs(list) do
			ret[k] = v.Name
		end
		return ret
	end

	local animationStyles = {}
	for _,style in pairs(Enum.EasingStyle:GetEnumItems()) do
		table.insert(animationStyles,{style.Name,style})
	end
	environment.bubbleChatAnimationStyle = environment.config.BubbleChat.Config.EasingStyle

	local userConfig = environment.network:invoke("fetchUserConfig")

	local getConfig = function(path,name)
		local idx = userConfig[path] or {}
		return idx[name]
	end
	local apis = {["UI"] = {},["BubbleChat"] = {}}
	environment.apis = apis

	local newSetting = function(class,path,...)
		local changed = environment.signal.new()
		local setting

		if(class == "slider") then
			local limit,api,value = unpack({...})
			setting = {
				value = value,
				["type"] = "number",
				["limits"] = limit,
				changed = changed
			} 

			function setting:set(new)
				api:set(new)
			end
		elseif(class == "toggle") then
			local api,value = unpack({...})
			setting = {
				value = value,
				["type"] = "boolean",
				changed = changed
			}

			function setting:set(new)
				api:set(new)
			end
		elseif(class == "dropdown") then
			local api,value,list = unpack({...})
			setting = {
				value = value,
				["type"] = "string",
				changed = changed,
				options = list
			}

			function setting:set(new)
				api:set(new)
			end
		end

		environment.settingChanged:Connect(function(a,b,new)
			if(path[1] == a and (path[2] == b)) then
				if(setting.value ~= new) then
					setting.value = new
					changed:Fire(new)
				end
			end
		end)

		return setting
	end

	local guiOptions = { -- I'm so sorry for what happened below
		UI = {
			Resizable = function(object)
				local default = config.UI.Resizable
				local last = getConfig("UI","Resizable")
				if(typeof(last) ~= "boolean") then
					last = default
				end

				local button = environment.resizeButton
				local api = constructors.toggle.new(object,last,function(new)
					button.Visible = new
					environment.settingChanged:Fire("UI","Resizable",new)
					environment.network:invoke("writeConfig","UI","Resizable",new)
				end)

				if(last) then
					button.Visible = true
				end

				apis["UI"]["Resizable"] = newSetting("toggle",{"UI","Resizable"},api,last)
			end,
			Roundness = function(object)
				local default = config.UI.Rounding
				local last = getConfig("UI","Roundness") or default
				if(typeof(last) ~= "number") then
					last = default
				end

				local api = constructors.slider.new(object,0,12,last,function(new)
					if(environment.refreshRounding) then
						config.UI.Rounding = new
						environment:refreshRounding()
						environment.settingChanged:Fire("UI","Roundness",new)
						environment.network:invoke("writeConfig","UI","Roundness",new)
					end
				end)

				apis["UI"]["Roundness"] = newSetting("slider",{"UI","Roundness"},{0,12},api,last)
			end,
			TextSize = function(object)
				local default = config.UI.BaseTextSize
				local last = getConfig("UI","TextSize") or default
				if(typeof(last) ~= "number") then
					last = default
				end

				local api = constructors.slider.new(object,10,20,math.clamp(last,10,20),function(new)
					if(environment.setTextSize) then
						config.UI.BaseTextSize = new
						environment:setTextSize(new)
						environment.settingChanged:Fire("UI","TextSize",new)
						environment.network:invoke("writeConfig","UI","TextSize",new)
					end
				end)

				apis["UI"]["TextSize"] = newSetting("slider",{"UI","TextSize"},{10,20},api,last)
			end
		},
		BubbleChat = {
			Enabled = function(object)
				local chatDefault = (config.BubbleChat.Enabled or game:GetService("Chat").BubbleChatEnabled)
				local defaultUser = getConfig("BubbleChat","Enabled")
				local default
				if(defaultUser == nil) then
					default = chatDefault
				else
					default = defaultUser
				end

				environment.bubbleChatEnabled = default
				local api = constructors.toggle.new(object,default,function(new)
					environment.bubbleChatEnabled = new
					if(environment.bubbleChatContainer) then
						environment.bubbleChatContainer.Enabled = new
					end
					environment.settingChanged:Fire("BubbleChat","Enabled",new)
					environment.network:invoke("writeConfig","BubbleChat","Enabled",new)
				end)

				api:set(default)
				apis["BubbleChat"]["Resizable"] = newSetting("toggle",{"BubbleChat","Enabled"},api,default)
			end,
			AnimationStyle = function(object)
				local dropdownOptions = getTableFromIdx(animationStyles,1)
				local dropdownTranslations = getTableFromIdx(animationStyles,2)
				local from = function(optionName)
					return dropdownTranslations[table.find(dropdownOptions,optionName)]
				end
				local default = getConfig("BubbleChat","AnimationStyle")

				local api = constructors.dropdown.new(object,dropdownOptions,function(picked)
					local selection = from(picked)
					environment.bubbleChatAnimationStyle = selection
					environment.network:invoke("writeConfig","BubbleChat","AnimationStyle",picked)
				end)
				if(default ~= nil) then
					environment.bubbleChatAnimationStyle = from(default)
					api:set(default)
				end
				apis["BubbleChat"]["AnimationStyle"] = newSetting("dropdown",{"BubbleChat","AnimationStyle"},api,default,dropdownOptions)
			end,
			FadeoutTime = function(object)
				local default
				default = getConfig("BubbleChat","FadeoutTime")
				if(default == nil) then
					default = environment.config.BubbleChat.Config.FadeoutTime
				else
					environment.config.BubbleChat.Config.FadeoutTime = default	
				end

				local api = constructors.slider.new(object,3,25,default,function(new)
					environment.config.BubbleChat.Config.FadeoutTime = new	
					environment.settingChanged:Fire("BubbleChat","FadeoutTime",new)
					environment.network:invoke("writeConfig","BubbleChat","FadeoutTime",new)
				end)

				apis["BubbleChat"]["FadeoutTime"] = newSetting("slider",{"UI","FadeoutTime"},{3,25},api,default)
			end,
			["Font"] = function(object)
				local default
				default = getConfig("BubbleChat","Font")
				if(default == nil) then
					default = environment.config.BubbleChat.Config.BubbleFont
				else
					default = Enum.Font[default]
				end

				localPlayer:SetAttribute("BubbleFont",default.Name)

				local fonts = getFontsList(default)
				local api = constructors.dropdown.new(object,fonts,function(picked)
					local currentFont = Enum.Font[picked]
					environment.config.BubbleChat.Config.BubbleFont = currentFont
					localPlayer:SetAttribute("BubbleFont",currentFont.Name)
					environment.settingChanged:Fire("BubbleChat","Font",picked)
					environment.network:invoke("writeConfig","BubbleChat","Font",picked)
				end,function(object)
					object.Font = Enum.Font[object.text]
				end)

				apis["BubbleChat"]["Font"] = newSetting("dropdown",{"BubbleChat","Font"},api,fonts[1],fonts)
			end,
		},
		QuickChat = {}
	}

	if(not quickChatEnabled) then
		guiOptions["QuickChat"] = nil
		navigation:WaitForChild("Content"):WaitForChild("QuickChat"):Destroy()
	end

	if(not config.BubbleChat.Enabled and (not chatService.BubbleChatEnabled)) then
		guiOptions["BubbleChat"] = nil
		navigation:WaitForChild("Content"):WaitForChild("BubbleChat"):Destroy()
	end

	for pageName,opts in pairs(guiOptions) do
		local page = pageContainer:WaitForChild(pageName)
		local scroller = page:WaitForChild("Scroller")
		for optionName,callback in pairs(opts) do
			task.spawn(callback,scroller:WaitForChild(optionName))
		end
		local listLayout = scroller:FindFirstChildOfClass("UIListLayout")
		if(listLayout) then
			local rescale = function()
				scroller.CanvasSize = UDim2.fromOffset(0,listLayout.AbsoluteContentSize.Y)
			end
			listLayout.Changed:Connect(rescale)
			rescale()
		end
	end

	task.spawn(topbar,environment)

	navigation:WaitForChild("Title"):WaitForChild("Close").MouseButton1Click:Connect(function()
		environment.settingIcon:deselect()
	end)

	if(quickChatEnabled) then
		local slots = {}
		local apis = {}

		for i = 1,20 do
			local text = (getConfig("QuickChats",i) or "")
			slots[i] = text

			local callback = function(option,api)
				if(option == "Save") then
					local new = environment.network:invoke("writeConfig","QuickChats",i,api:getText())
					slots[i] = new
					api:setText(new)
				elseif(option == "Delete") then
					slots[i] = ""
					api:setText(environment.network:invoke("writeConfig","QuickChats",i,""))
				end
			end
			local api = constructors.quickChatDropdown.new(text,tostring(i),callback)

			apis[i] = function(text)
				api:setText(text)
				callback("Save",api)
			end

			api:reparent(pageContainer:WaitForChild("QuickChat"):WaitForChild("Scroller"))
			environment.utility:clampTextLimit(api:getBox(),config.Messages.MaximumLength)
		end

		function environment:getQuickChatSlot(i)
			return slots[i]
		end

		function environment:saveToSlot(i,text)
			apis[i](text)
		end
	end
end