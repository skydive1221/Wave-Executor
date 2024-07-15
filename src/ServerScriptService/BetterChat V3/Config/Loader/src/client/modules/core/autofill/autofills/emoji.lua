-- Author: @Jumpathy
-- Name: emoji.lua
-- Description: Emoji autofill system

return function(config)
	local list = require(script.Parent.Parent.Parent:WaitForChild("lists"):WaitForChild("emojiList"))
	local autofill = {}
	local allowedEmojis;
	
	autofill.beginsWith = ":"
	autofill.endsWith = ":"
	autofill.security = "internal"

	local network;
	local customEmojis;
	autofill.onCapture = function(matches,environment)
		network = environment.network
		if customEmojis then
			if not allowedEmojis then
				allowedEmojis = network:invoke("getAllowedEmojis")
			end
		end
		local gsub = {}
		local fill = {}
		for _,match in pairs(matches) do
			if(match.hasClosing) then
				local replacement = list:findDirect(match.text)
				if(replacement) then
					local hasCustomEmoji = false
					if allowedEmojis then
						for emojiName,emojiImage in pairs(allowedEmojis) do
							if(emojiName:sub(1,#match.text) == match.text) then
								hasCustomEmoji = true
							end
						end
					end
					if not hasCustomEmoji then
						gsub[(":%s:"):format(match.text)] = replacement
					end
				end
			else
				for _,emojiMatch in pairs(list.search(match.text)) do
					table.insert(fill,{
						text = (":%s: %s"):format(unpack(emojiMatch)),
						autofillBar = match.before .. ":" .. emojiMatch[1] .. ":",
						gsub = {(":%s"):format(match.text),emojiMatch[2].." "}
					})
				end
				if allowedEmojis then
					for emojiName,emojiData in pairs(allowedEmojis) do
						if(emojiName:sub(1,#match.text) == match.text) then
							table.insert(fill,1,{
								text = (":%s: "):format(emojiName),
								autofillBar = match.before .. ":" .. emojiName .. ":",
								gsub = {(":%s"):format(match.text),(":%s:"):format(emojiName)},
								onCreated = function(parent)
									local emojiImage = typeof(emojiData) == "table" and emojiData.Image or emojiData
									local object = parent.Label
									local textBounds = object.TextBounds
									local emoji = Instance.new("ImageLabel")
									emoji.Parent = object
									emoji.Position = UDim2.new(0,textBounds.X,0.5,0)
									emoji.Image = emojiImage
									emoji.BackgroundTransparency = 1
									emoji.AnchorPoint = Vector2.new(0,0.5)
									emoji.Size = UDim2.fromOffset(object.TextSize - 2,object.TextSize - 2)
									emoji.ScaleType = environment.config.Messages.CustomEmojis.ScaleType
									if typeof(emojiData) == "table" then
										environment.animateCustomEmoji(emoji,emojiData)
									end
									environment.onEmoji:Fire(emoji)
								end,
							})
						end
					end
				end
			end
		end
		return gsub,fill
	end

	if config.Messages.CustomEmojis and config.Messages.CustomEmojis.Enabled then
		customEmojis = true
		task.spawn(function()
			while task.wait(10) do
				if network then
					allowedEmojis = network:invoke("getAllowedEmojis")
				end
			end
		end)
	end

	return autofill
end