-- Author: @Jumpathy
-- Name: connections.lua
-- Description: Set up core connections for Roblox's chat so I can connect signals like .Chatted etc

local starterGui = game:GetService("StarterGui")

local chatConnectionsList = {}

local createEvents = function(array)
	for name,info in pairs(array) do
		local event = Instance.new(info.class)
		event.Name = name
		chatConnectionsList[info.category] = chatConnectionsList[info.category] or {}
		chatConnectionsList[info.category][name] = event
	end
end

createEvents({
	["ToggleVisibility"] = { -- Fired when CoreGui chat button is pressed
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["SetVisible"] = { -- Fired when CoreGui wants to change if the chat is visible
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["FocusChatBar"] = { -- Fired when CoreGui wants to focus the chat bar
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["TopbarEnabledChanged"] = { -- Fired when topbar visibility changes
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["SpecialKeyPressed"] = { -- Fired when the chat hotkey is pressed
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["CoreGuiEnabled"] = { -- Fired when the developer sets StarterGui:SetCoreGuiEnabled for the chat
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["ChatBarFocusChanged"] = { -- Fire w 'true' when you want to ensure that the chatbar is being focused on
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["VisibilityStateChanged"] = { -- Fire w 'true' when the user shows or hides the chat
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["MessagesChanged"] = { -- Fire this to set the topbar chat button's message counter
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["MessagePosted"] = { 
		-- Fired for the .Chatted event, attempting to forge this can land you with trouble in moderation
		class = "BindableEvent",
		category = "ChatWindow"
	},
	["IsFocused"] = { -- Invoked by CoreGui to determine if the chat is focused
		class = "BindableFunction",
		category = "ChatWindow"
	},
	["ChatMakeSystemMessage"] = { -- https://developer.roblox.com/en-us/api-reference/function/StarterGui/SetCore
		class = "BindableEvent",
		category = "SetCore"
	},
	["ChatWindowPosition"] = { -- https://developer.roblox.com/en-us/api-reference/function/StarterGui/SetCore
		class = "BindableEvent",
		category = "SetCore"
	},
	["ChatWindowSize"] = { -- https://developer.roblox.com/en-us/api-reference/function/StarterGui/SetCore
		class = "BindableEvent",
		category = "SetCore"
	},
	["ChatBarDisabled"] = { -- https://developer.roblox.com/en-us/api-reference/function/StarterGui/SetCore
		class = "BindableEvent",
		category = "SetCore"
	}
})

createEvents({
	["ChatWindowPosition"] = { -- Invoked by :GetCore to return the UDim2 position of the chat window
		class = "BindableFunction",
		category = "GetCore"
	},
	["ChatWindowSize"] = { -- Invoked by :GetCore to determine the chat size of the window with a UDim2 value
		class = "BindableFunction",
		category = "GetCore"
	},
	["ChatBarDisabled"] = { -- Invoked by :GetCore to return a boolean if the chatbar is disabled
		class = "BindableFunction",
		category = "GetCore"
	}
})

local loaded = false
local loadedEvent = Instance.new("BindableEvent")

task.spawn(function()
	local tries = 0
	local maxAttempts = 10
	while(tries < maxAttempts) do
		local success,result = pcall(function()
			starterGui:SetCore("CoreGuiChatConnections",chatConnectionsList)
		end)
		if(success) then
			loaded = true
			loadedEvent:Fire()
			break
		else
			tries += 1
			if(tries == maxAttempts) then
				error("[Better Chat]: Error calling SetCore CoreGuiChatConnections:",result)
			else
				task.wait()
			end
		end
	end
end)

local pending = {}

function pending:Connect(category,name,callback)
	if(not loaded) then
		loadedEvent.Event:Wait()
	end
	local event = chatConnectionsList[category][name]
	if(event:IsA("BindableEvent")) then
		event.Event:Connect(callback)
	else
		event.OnInvoke = callback
	end
end

function pending:Fire(category,name,...)
	if(not loaded) then
		loadedEvent.Event:Wait()
	end
	chatConnectionsList[category][name]:Fire(...)
end

function pending:Invoke(category,name,...)
	if(not loaded) then
		loadedEvent.Event:Wait()
	end
	return chatConnectionsList[category][name]:Invoke(...)
end

return pending