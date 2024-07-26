-- Author: @Jumpathy
-- Name: settingsMenu.lua
-- Description: Settings menu for the GUI controller

local constructors = {}
local folder = script.Parent:WaitForChild("constructors")
local starterGui = game:GetService("StarterGui")
local topbar = require(script.Parent:WaitForChild("topbarPlus"):WaitForChild("icons"))
local localPlayer = game:GetService("Players").LocalPlayer
local chatService = game:GetService("Chat")
local runService = game:GetService("RunService")

constructors.dropdown = require(folder:WaitForChild("dropdown"))
constructors.toggle = require(folder:WaitForChild("toggle"))
constructors.slider = require(folder:WaitForChild("slider"))
constructors.quickChatDropdown = require(folder:WaitForChild("quickChatDropdown"))
constructors.helpDropdown = require(folder:WaitForChild("helpDropdown"))
constructors.colorPicker = require(folder:WaitForChild("colorPicker"))

return function(environment)
	local quickChatEnabled = environment.config.Messages.QuickChat
	constructors.colorPicker = constructors.colorPicker(environment)

	local ui = environment.gui:WaitForChild("Settings")
	local config = environment.config
	local state = false
	
	local sampleToggle = ui.Pages.BubbleChat.Scroller.Enabled:Clone()
	local sampleSlider = ui.Pages.BubbleChat.Scroller.FadeoutTime:Clone()
	local sampleDropdown = ui.Pages.BubbleChat.Scroller.Font:Clone()

	environment.settingChanged = environment.signal.new()

	function environment:toggleSettingsMenu()
		state = not state
		environment.container.Visible = not state
		local position = state and UDim2.new(0.5,0,0.5,0) or UDim2.new(0.5,0,-1.5,0)
		environment.tweenPosition(ui,position,Enum.EasingDirection.Out,Enum.EasingStyle.Linear,0.16,true)
		environment:setChatLocked(state)
	end

	local pages = {"UI","BubbleChat","QuickChat","Help"}
	if(not quickChatEnabled) then
		table.remove(pages,3)
	end

	local pageContainer = ui:WaitForChild("Pages")
	local navigation = pageContainer:WaitForChild("Navigation")
	local args = {Enum.EasingDirection.In,Enum.EasingStyle.Quad,0.16,true}
	local outPosition = UDim2.fromScale(-1,0)
	local inPosition = UDim2.fromScale(0,0)

	local selectPage = function(page)
		environment.tweenPosition(navigation,outPosition,unpack(args))
		page.Position = UDim2.fromScale(1,0)
		environment.tweenPosition(page,inPosition,unpack(args))
	end

	local back = function(page)
		environment.tweenPosition(navigation,inPosition,unpack(args))
		environment.tweenPosition(page,UDim2.fromScale(1,0),unpack(args))
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
				end,environment)

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
			end,
			TextFont = function(object)
				local default
				default = getConfig("UI","TextFont")
				if(default == nil) then
					default = environment.config.UI.Fonts.TextFont
				else
					default = Enum.Font[default]
				end

				environment.config.UI.Fonts.TextFont = default
				environment:updFont(default)

				local fonts = getFontsList(default)
				local api = constructors.dropdown.new(object,fonts,function(picked)
					local currentFont = Enum.Font[picked]
					environment.config.UI.Fonts.TextFont = currentFont
					environment.settingChanged:Fire("UI","TextFont",picked)
					environment.network:invoke("writeConfig","UI","TextFont",picked)
					environment:updFont(currentFont)
				end,function(object)
					object.Font = Enum.Font[object.text]
					environment:updFont(Enum.Font[object.text])
				end,environment)

				apis["UI"]["TextFont"] = newSetting("dropdown",{"UI","Font"},api,fonts[1],fonts)
			end,
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
				end,environment)

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
				end,nil,environment)
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
				environment.config.BubbleChat.Config.BubbleFont = default

				local fonts = getFontsList(default)
				local api = constructors.dropdown.new(object,fonts,function(picked)
					local currentFont = Enum.Font[picked]
					environment.config.BubbleChat.Config.BubbleFont = currentFont
					localPlayer:SetAttribute("BubbleFont",currentFont.Name)
					environment.settingChanged:Fire("BubbleChat","Font",picked)
					environment.network:invoke("writeConfig","BubbleChat","Font",picked)
				end,function(object)
					object.Font = Enum.Font[object.text]
				end,environment)

				apis["BubbleChat"]["Font"] = newSetting("dropdown",{"BubbleChat","Font"},api,fonts[1],fonts)
			end,
		},
		QuickChat = {},
		Help = {
			ColorFormatting = function(object)
				local other = object.Parent.Colorpicker
				other.Size = UDim2.new(1,0,0,30)
				other.Parent = object.Dropdown
				other.LayoutOrder = 10
				
				constructors.helpDropdown.new(object,environment)
				
				local colorpickerControl = function(object)
					constructors.helpDropdown.new(object,environment)

					local menu = object.Dropdown.Colorpicker
					constructors.colorPicker.new(menu.PickerWidget)

					for _,opt in pairs(menu.Options:GetChildren()) do
						if(opt:IsA("TextButton")) then
							opt.AutoLocalize = false
							opt.MouseButton1Click:Connect(function()
								local state = opt.Text == "Color picker"
								menu.PickerWidget.Visible = state
								menu.BrickColors.Visible = not state		
							end)
						end
					end

					local brickScroller = menu.BrickColors.Scroller
					local searchbar = menu.BrickColors.Searchbar.Box

					local template = brickScroller.BrickColor
					template.Parent = script
					-- stop absolute massive lag:
					template.ColorPreview.UICorner.Name = "Ignore"
					template.UICorner.Name = "Ignore"

					local brickColors = {}
					local blank = {}

					local existing = {}
					for i = 1,1032 do -- iirc there's around 1032 brick colors (this gets all of them and adds them to a list)
						local col = BrickColor.new(i)
						if col and not existing[col.Name] then
							existing[col.Name] = true
							local obj = template:Clone()
							obj.ColorPreview.BackgroundColor3 = col.Color
							obj.TextBox.Text = col.Name
							obj.Parent = brickScroller

							obj.TextBox.Focused:Connect(function()
								repeat
									obj.TextBox.SelectionStart = 0
									obj.TextBox.CursorPosition = #col.Name + 1
									task.wait()
								until(obj.TextBox:IsFocused() == false)
							end)

							brickColors[col.Name] = obj
						end
					end

					local setVisible = function(state)
						for _,color in pairs(brickScroller:GetChildren()) do
							if(color:IsA("Frame")) then
								color.Visible = state
							end
						end
					end

					searchbar:GetPropertyChangedSignal("Text"):Connect(function()
						local searchTerm = searchbar.Text:sub(1,50)
						local isBlank = searchTerm:gsub(" ","") == ""
						setVisible(isBlank)
						if not isBlank then
							for name,object in pairs(brickColors) do
								if(name:lower():find(searchTerm:lower())) then
									object.Visible = true
								end
							end
						end
					end)
				end
				
				colorpickerControl(other)
			end,
			GeneralFormatting = function(object)
				constructors.helpDropdown.new(object,environment)
			end,
		}
	}

	if(not quickChatEnabled) then
		guiOptions["QuickChat"] = nil
		navigation:WaitForChild("Content"):WaitForChild("QuickChat"):Destroy()
	end

	if(not config.BubbleChat.Enabled and (not chatService.BubbleChatEnabled)) then
		guiOptions["BubbleChat"] = nil
		navigation:WaitForChild("Content"):WaitForChild("BubbleChat"):Destroy()
	end
	
	function environment:addCustomOption(container,class,options)
		local text = options.Text or "DEFAULT"
		local icon = options.Icon or nil
		
		if(class == "Toggle") then
			local toggleUi = sampleToggle:Clone()
			toggleUi.Parent = pageContainer[container]["Scroller"]
			toggleUi.LayoutOrder = 10
			toggleUi.Title.Label.Text = text
			if icon then
				toggleUi.Title.Icon.Image = icon
			end
			local defaultValue = options.DefaultValue
			return constructors.toggle.new(toggleUi,defaultValue,options.Callback,environment)
		elseif(class == "Slider") then
			local sliderUi = sampleSlider:Clone()
			sliderUi.Parent = pageContainer[container]["Scroller"]
			sliderUi.LayoutOrder = 10
			sliderUi.Center.Title.Label.Text = text
			if icon then
				sliderUi.Center.Title.Icon.Image = icon
			end
			return constructors.slider.new(sliderUi,options.Minimum,options.Maximum,default,options.Callback,new)
		elseif(class == "Dropdown") then
			local dropdownUi = sampleDropdown:Clone()
			dropdownUi.Parent = pageContainer[container]["Scroller"]
			dropdownUi.LayoutOrder = 10
			dropdownUi.Title.Label.Text = text
			if icon then
				dropdownUi.Title.Icon.Image = icon
			end
			return constructors.dropdown.new(dropdownUi,options.Options,options.Callback,nil,environment)
		end
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