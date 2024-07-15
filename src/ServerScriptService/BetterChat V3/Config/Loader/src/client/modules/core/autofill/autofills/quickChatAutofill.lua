-- Author: @Jumpathy
-- Name: quickChatAutofill.lua
-- Description: Quick chat autofill system

return function(config)
	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer

	local autofill = {}
	autofill.beginsWith = "/"
	autofill.endsWith = nil
	autofill.security = "internal"

	autofill.onCapture = function(matches,environment)
		local fill,gsub,callback = {},{},nil
		local text = matches[1]["text"]
		local placeAt = nil
		if text and text ~= "" and tonumber(text) then
			local number = tonumber(text)
			if(environment.config.Messages.QuickChat and number < 20) then
				local slot = environment:getQuickChatSlot(number)
				if slot and slot ~= "" then
					gsub["/" .. text] = slot
					placeAt = #slot + 1
				end
			end
		end
		return gsub,fill,callback,placeAt
	end

	return autofill
end