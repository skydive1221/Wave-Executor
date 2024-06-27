-- Author: @Jumpathy
-- Name: marketplace.lua
-- Description: Marketplace-ish functions for permission module

return function(module)
	local marketplaceService = game:GetService("MarketplaceService")
	local ownedPasses = {}

	marketplaceService.PromptGamePassPurchaseFinished:Connect(function(player,id,wasPurchased)
		if(wasPurchased) then
			ownedPasses[player.UserId] = ownedPasses[player.UserId] or {}
			ownedPasses[player.UserId][id] = true
			module:get(player.UserId)
		end
	end)

	return function(userId,passId)
		local data = ownedPasses[userId] or {}
		if(not data[passId] and (passId >= 1)) then
			local success,result = pcall(function()
				return marketplaceService:UserOwnsGamePassAsync(userId,passId)
			end)
			if(success) then
				data[passId] = result
				return result
			else
				warn("[Failed to fetch gamepass ownership status,",result,"]")
				return false
			end
		else
			return data[passId]
		end
	end
end