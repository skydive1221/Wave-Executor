-- Author: @Jumpathy
-- Name: api.lua
-- Description: Better chat server API

return function(constructors,wrap)
	local api = {}

	api.channel = constructors.channel
	api.speaker = constructors.speaker
	api.network = constructors.network
	api.network:newEvent("systemMessage")

	function api:systemMessage(text)
		api.network:fireClients("systemMessage","all",text)
		
	end
	return wrap(api)
end