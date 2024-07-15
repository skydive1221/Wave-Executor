-- Author: @Jumpathy
-- Name: functions.lua
-- Descriptions: Function serving for messages

return function(environment)
	local players = game:GetService("Players")
	local textService = game:GetService("TextService")
	local httpService = game:GetService("HttpService")

	local playerGui = players.LocalPlayer.PlayerGui

	local lineDetector = require(script.Parent.lineDetector)(
		require(environment.betterchat_shared.xml)
	)
	
	local spritesheetManager = require(script.Parent.spritesheet)

	local rich = environment.richText
	local systemPrefixColor = environment.config.UI.Colors.SystemPrefixColor
	local font = environment.config.UI.Fonts.TextFont
	local localPlayer = players.LocalPlayer

	local functions = {}
	local c = "\u{200A}" .. " "

	local fs = function()
		return environment.config.UI.BaseTextSize
	end

	local _gsub_escape_table = {
		["\000"] = "%z", ["("] = "%(", [")"] = "%)", ["."] = "%.",
		["%"] = "%%", ["+"] = "%+", ["-"] = "%-", ["*"] = "%*",
		["?"] = "%?", ["["] = "%[", ["]"] = "%]", ["^"] = "%^",
		["$"] = "%$",
	}

	local escapePattern = function(str)
		return str:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", _gsub_escape_table)
	end

	local generateSpaces = function(px)
		local a,i = 0,0
		repeat
			i += 1
			a = textService:GetTextSize(string.rep(c,i),fs(),font,Vector2.new(math.huge,fs()))
		until(a.X >= px)
		return string.rep(c,i)
	end

	function functions:hasImages(tagList)
		for _,obj in pairs(tagList) do
			if obj.image then
				return true
			end
		end
	end

	local getById = function(id)
		for _,plr in pairs(players:GetPlayers()) do
			if(math.abs(plr.UserId) == math.abs(id)) then
				return plr
			end
		end
	end

	functions.getTags = function(data)
		local tagsList = data.tags or {}
		if(data.isWhisper) then
			data.tags = {}
			tagsList = data.tags
			local sender = data.player
			local from = getById(sender==localPlayer and data.to_user or data.to_user)
			local opposite = getById(data.ids[1]==localPlayer.UserId and data.ids[2] or data.ids[1])
			if(from ~= nil) then
				local prefix = environment.localization:getMessagePrefix(sender == localPlayer and "To" or "From")
				table.insert(tagsList,1,{
					text = ("%s %s"):format(prefix,opposite:GetAttribute("DisplayName")),
					color = systemPrefixColor
				})
			end
		elseif(data.isTeam) then
			table.insert(tagsList,1,{
				text = environment.localization:getMessagePrefix("Team"),
				color = systemPrefixColor
			})
		end
		local tags = ""
		local padded = false
		local totalImages = 0;
		for _,tag in pairs(tagsList) do
			if tag.image and not padded then
				tags = tags .. generateSpaces(5)
				padded = true
			elseif tag.image then
				totalImages += 1
			end
			tag = tag.image and generateSpaces(fs()) or rich:colorize(("[TEXTHERE]"):format(tag.text),tag.color):gsub("TEXTHERE",rich:markdown(tag.text))
			tags = tags .. tag .. " "
		end
		if totalImages > 1 then
			tags = tags .. generateSpaces(5*(totalImages-1))
		end
		return tags
	end

	function functions:getUserThumbnail(userId)
		return("rbxthumb://type=AvatarHeadShot&id=%s&w=150&h=150"):format(userId)
	end

	function functions.createCollector(object,onEnd)
		local collector = {signals = {}}

		function collector:add(signal)
			if (collector) then
				table.insert(collector.signals,signal)
			end
		end

		local changed;
		changed = object.Changed:Connect(function()
			if(object:GetFullName() == object.Name) then
				changed:Disconnect()
				for _,signal in pairs(collector.signals) do
					signal:Disconnect()
				end
				collector.signals = nil
				collector = nil
				pcall(onEnd or function() end)
			end
		end)

		return collector
	end

	function functions:initReply(data)
		environment:setChannel(environment:generateReplyCode(data.id),true)
	end

	function functions:initWhisper(player)
		if(player and environment.config.Messages.Private.WhispersEnabled) then
			environment:whisper(player)
		end
	end

	function functions:getLines(object,text,spacing)
		return lineDetector:splitLines(object,text,spacing)
	end

	local guid = httpService:GenerateGUID()

	local getSize = function(object,text)
		return lineDetector:getTextSize(object,text)
	end

	local placeEmoji = function(object,customEmojis,id,toPlaceAt,anchorPoint)
		local emoji = object:FindFirstChild(tostring(id)) or Instance.new("ImageLabel")
		emoji.Size = UDim2.fromOffset(object.TextSize,object.TextSize)
		emoji:SetAttribute("IsEmoji",true)
		emoji.Parent = object
		emoji.Position = toPlaceAt
		emoji.Name = tostring(id)
		emoji.Image = customEmojis[id][2]
		emoji.BorderSizePixel = 0
		emoji.BackgroundTransparency = 1
		emoji.AnchorPoint = anchorPoint
		emoji.ScaleType = environment.config.Messages.CustomEmojis.ScaleType
		if customEmojis[id][5] then
			functions.animate(emoji,customEmojis[id][5])
		end
		environment.onEmoji:Fire(emoji)
	end

	local defaultTransformation = function(pos) 
		return pos 
	end

	local validify = function(cb)
		return typeof(cb) == "function" and cb or nil
	end
	
	local wrappedObject = {}
	
	function functions.animate(object,data)
		object.ImageRectSize = data.ImageRectSize
		spritesheetManager.new(object,data.Columns,data.Rows,data.Frames,data.FPS)
	end
	
	environment.animateCustomEmoji = functions.animate
	
	function functions:attachCustomEmojis(object, text, customEmojis, spacing , cb, editedStamp)
		local transformFunction = validify(cb) or defaultTransformation
		if(customEmojis and #customEmojis > 0) then
			object.TextTransparency = 1
			local currentlyEditing = object:GetAttribute("CurrentlyEditing")
			if wrappedObject[object] then
				for _,wrappedLine in pairs(wrappedObject[object]) do
					wrappedLine:Destroy()
				end
			end
			wrappedObject[object] = {}
			local emojiNumber = 0
			local lines = functions:getLines(object,spacing)
			for idx,line in pairs(lines) do
				if editedStamp then
					line = line:gsub(editedStamp,"")
				end
				local lineClone = object:Clone()
				lineClone.Size = UDim2.new(1,0,0,object.TextSize)
				lineClone.TextTransparency = currentlyEditing and 1 or 0
				lineClone.Parent = object
				lineClone.Position = UDim2.fromOffset(0,(idx - 1) * object.TextSize)
				lineClone.Text = line
				lineClone.Parent = object
				lineClone.Name = "WrappedLine"
				if(object.Name ~= "Label") then
					lineClone.AnchorPoint = Vector2.new(0,0)
				else
					lineClone.AnchorPoint = Vector2.new(0.5,0.5)
					lineClone.Position = UDim2.new(0.5,0,0,(idx) * object.TextSize)
				end
				lineClone.TextWrapped = false
				lineClone.ClipsDescendants = true
				lineClone:ClearAllChildren()
				table.insert(wrappedObject[object],lineClone)
				local prevEndPos = 0
				for match in string.gmatch(line,spacing) do
					local startPos, endPos = string.find(line, match, prevEndPos + 1, true)
					local previousText = line:sub(1,startPos-1)
					local previousTextSize = lineDetector:getTextSize2(lineClone,previousText,true)
					local diff = 0
					
					local toPlaceAt = transformFunction(UDim2.fromOffset(previousTextSize.X - diff,0))
					local anchorPoint = Vector2.new(0,0)
					if(object.Name == "Label") then
						toPlaceAt = UDim2.new(
							toPlaceAt.X.Scale,
							toPlaceAt.X.Offset + object.TextSize/2,
							0,
							0
						)
						anchorPoint = Vector2.new(0.5,0)
					end
					emojiNumber += 1
					placeEmoji(lineClone,customEmojis,emojiNumber,toPlaceAt,anchorPoint)
					prevEndPos = endPos
				end
			end
		end
	end

	functions.lineDetector = lineDetector

	return functions
end