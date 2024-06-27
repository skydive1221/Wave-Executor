-- Author: @Jumpathy
-- Name: api.lua
-- Description: Client api module

return function(environment,wrap)
	local quickChatEnabled = environment.config.Messages.QuickChat
	local api = {}
	environment.network.onClientEvent("systemMessage",function(message)
		api:systemMessage(message)
	end)
	
	function api:getSetting(container,settingName)
		return environment.apis[container][settingName]
	end
	
	function api:getTopbarButton()
		return environment.settingIcon
	end
	
	if(quickChatEnabled) then
		function api:getQuickChatSlot(number)
			return environment:getQuickChatSlot(number)
		end
		
		function api:saveToQuickChatSlot(number,text)
			return environment:saveToSlot(number,text)
		end
	end
	
	function api:systemMessage(message)
		environment.message_senders.makeSm(message)
	end
	
	function api:stopSizeUpdates()
		environment.stopSizing = true
	end
	
	function api:getUi()
		return environment.gui
	end
	
	api.tweening = {}
	
	function api.tweening:setTransparencyState(state)
		environment:setUiTransparency(state)
	end
	
	return wrap(api)
end