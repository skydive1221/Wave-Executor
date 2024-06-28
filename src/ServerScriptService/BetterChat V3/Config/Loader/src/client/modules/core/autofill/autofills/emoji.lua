-- Author: @Jumpathy
-- Name: emoji.lua
-- Description: Emoji autofill system

local list = require(script.Parent.Parent.Parent:WaitForChild("lists"):WaitForChild("emojiList"))
local autofill = {}
autofill.beginsWith = ":"
autofill.endsWith = ":"

autofill.onCapture = function(matches)
	local gsub = {}
	local fill = {}
	for _,match in pairs(matches) do
		if(match.hasClosing) then
			local replacement = list:findDirect(match.text)
			if(replacement) then
				gsub[(":%s:"):format(match.text)] = replacement
			end
		else
			for _,emojiMatch in pairs(list.search(match.text)) do
				table.insert(fill,{
					text = (":%s: %s"):format(unpack(emojiMatch)),
					autofillBar = match.before .. ":" .. emojiMatch[1] .. ":",
					gsub = {(":%s"):format(match.text),emojiMatch[2].." "}
				})
			end
		end
	end
	return gsub,fill
end

return autofill