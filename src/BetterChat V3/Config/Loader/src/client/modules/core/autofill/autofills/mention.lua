-- Author: @Jumpathy
-- Name: mention.lua
-- Description: User mention system

local players = game:GetService("Players")
local autofill = {}
autofill.beginsWith = "@"
autofill.endsWith = " "

autofill.onCapture = function(matches)
	local fill = {}
	local match = matches[#matches]
	if(match and (not match.hasClosing)) then
		for _,player in pairs(players:GetPlayers()) do
			if(player.Name:sub(1,#match.text) == match.text) then
				local display = (player.Name ~= player:GetAttribute("DisplayName") and ("(%s)"):format(player:GetAttribute("DisplayName")))
				local username = ("@%s %s"):format(player.Name,display or "")
				table.insert(fill,{
					text = (username),
					autofillBar = match.before .. "@".. player.Name,
					gsub = {"@"..match.text,"@"..player.Name.." "}
				})
			elseif(player:GetAttribute("DisplayName"):sub(1,#match.text) == match.text) then
				local username = ("@%s (%s)"):format(player:GetAttribute("DisplayName"),player.Name)
				table.insert(fill,{
					text = (username),
					autofillBar = match.before .. "@".. player:GetAttribute("DisplayName"),
					gsub = {"@"..match.text,"@"..player.Name.." "}
				})
			end
		end
	end
	if(#fill == 0) then
		fill = nil
	end
	return {},fill
end

return autofill