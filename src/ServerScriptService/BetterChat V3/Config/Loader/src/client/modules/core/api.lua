-- Author: @Jumpathy
-- Name: api.lua
-- Description: Client api module

return function(environment,wrap)
	local runService = game:GetService("RunService")
	local quickChatEnabled = environment.config.Messages.QuickChat
	local api = {}
	environment.network.onClientEvent("systemMessage",function(message)
		api:systemMessage(message)
	end)
	
	api.network = environment.network
	
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
	
	function api:sendMessage(message)
		environment.message_senders.makeSm(message,true)
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
	
	function api:addPromptOption(...)
		if not environment.addPromptOption then
			repeat
				task.wait()
			until environment.addPromptOption
		end
		environment:addPromptOption(...)
	end
	
	environment.client_api = api
	
	function api:getEnvironment()
		return environment
	end
	
	
	api.bubbleChat = {}
	
	function api.bubbleChat:getForPlayer(player)
		if not environment.holstered[player] then
			repeat
				runService.RenderStepped:Wait()
			until environment.holstered[player]
		end
		return environment.holstered[player]
	end	
	
	function api.bubbleChat.new(object,adornee)
		if not environment.billboard then
			repeat
				runService.RenderStepped:Wait()
			until environment.billboard
		end
		return environment.billboard:create(object,adornee)
	end
	
	function api:interceptMessageData(callback)
		table.insert(environment.interceptions,callback)
	end
	
	if(environment.config.SettingsMenu.Enabled) then
		function api:addCustomSetting(container,class,options)
			if not environment.addCustomOption then
				repeat
					runService.RenderStepped:Wait()
				until environment.addCustomOption
			end
			return environment:addCustomOption(container,class,options)
		end
	end
	
	return wrap(api)
end