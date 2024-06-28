-- Author: Roblox? (Skidd- I mean rewritten by Jumpathy)
-- Name: localization.lua
-- Description: Manage localization lol

return function()
	local localizationService = game:GetService("LocalizationService")
	local userShouldLocalizeServerMessages = true
	local localizationTable,entries = require(script.Parent:WaitForChild("lists"):WaitForChild("localizationTable"))()
	local userInput = game:GetService("UserInputService")
	local touchEnabled = userInput.TouchEnabled
	
	local fetchEntry = function(key)
		for _,entry in pairs(entries) do 
			if(entry.Key == key) then
				return entry
			end
		end
		return {["en-us"] = "..."}
	end
	
	local getDefault = function(key)
		return fetchEntry(key)["en-us"]
	end
	
	local prefixKeys = {
		["System"] = "InGame.Chat.Label.SystemMessagePrefix",
		["Team"] = "InGame.Chat.Label.TeamMessagePrefix",
		["From"] = "InGame.Chat.Label.From",
		["To"] = "InGame.Chat.Label.To",
		["Welcome"] = "GameChat_ChatCommandsTeller_AllChannelWelcomeMessage"
	}
	
	local standardKeys = {
		["Chatbar"] = touchEnabled and "GameChat_ChatMain_ChatBarTextTouch" or "GameChat_ChatMain_ChatBarText",
		["CannotTalk"] = "Muted"
	}

	local module = {
		internal = {fetchedLocalization = false,translator = nil}		
	}

	function module.internal:fetchTranslator()
		if(not module.internal.translator and not module.internal.fetchedLocalization) then
			module.internal.fetchedLocalization = true
			module.internal.translator = localizationTable:GetTranslator(localizationService.RobloxLocaleId)
			local changedLocaleSignal
			changedLocaleSignal = localizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(function()
				changedLocaleSignal:Disconnect()
				module.internal.fetchedLocalization = false
				module.internal.translator = nil
			end)
		end
		return module.internal.translator
	end
	
	function module:getWelcomeMessage(...)
		return {
			module:localize(prefixKeys.System,getDefault(prefixKeys.System)),
			module:localize(prefixKeys.Welcome,getDefault(prefixKeys.Welcome)),
			...
		}
	end

	function module:produceSystemMessage(message)
		return {
			module:localize(prefixKeys.System,getDefault(prefixKeys.System)),
			message
		}
	end
	
	function module:getChatbarPlaceholder(key)
		local keyToUse = key and standardKeys.CannotTalk or standardKeys.Chatbar
		return module:localize(keyToUse,getDefault(keyToUse))
	end
	
	function module:localizeResponse(key,...)
		return module:localize(key,getDefault(key),{...})
	end
	
	function module:localize(key,default,...)
		local success,returnValue = pcall(function(...)
			local translator = module.internal:fetchTranslator()
			if(translator ~= nil) then
				return translator:FormatByKey(key,...)
			else
				warn("[Better Chat]: Missing internal translator, using default value for key",key)
			end
		end,...)
		if(not success and returnValue) then
			warn(returnValue)
		end
		return(success and returnValue or (default or getDefault(key)))
	end
	
	function module:getMessagePrefix(base)
		return module:localize(prefixKeys[base])
	end
	
	return module
end