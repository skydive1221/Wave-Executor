-- Author: @Jumpathy
-- Name: functions.lua
-- Descriptions: Function serving for messages

return function(environment)
	local players = game:GetService("Players")
	local textService = game:GetService("TextService")
	local httpService = game:GetService("HttpService")

	local playerGui = players.LocalPlayer.PlayerGui

	local lineDetector = require(script.Parent.lineDetector)(
		require(environment.betterchat_shared.xml),
		environment.gui
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
					color = systemPrefixColor,
					specialTag = true
				})
			end
		elseif(data.isTeam) then
			local found = false;
			for k,v in pairs(tagsList) do
				if(v.teamTag) then
					found = true;
					break
				end
			end
			if not found then
				table.insert(tagsList,1,{
					text = environment.localization:getMessagePrefix("Team"),
					color = systemPrefixColor,
					teamTag = true
				})
			end
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

	local placeEmoji = function(object,customEmojis,id,num)
		local emoji = object:FindFirstChild(tostring(id)) or Instance.new("ImageLabel")
		emoji.Size = UDim2.fromOffset(object.TextSize,object.TextSize)
		emoji:SetAttribute("IsEmoji",true)
		emoji.Parent = object
		emoji.Name = tostring(id)
		emoji.Image = customEmojis[id][2]
		emoji.BorderSizePixel = 0
		emoji.BackgroundTransparency = 1
		emoji.ScaleType = environment.config.Messages.CustomEmojis.ScaleType
		emoji.LayoutOrder = num
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
	
	local split = function(str, delimiter)
		local result = {}
		local pattern = string.format("(.-)()" .. delimiter .. "()")
		local lastEnd = 1

		for part, partEnd, splitStart in str:gmatch(pattern) do
			if part ~= "" then
				table.insert(result, part)
			end
			table.insert(result, str:sub(partEnd, splitStart - 1))
			lastEnd = splitStart
		end

		if lastEnd <= #str then
			table.insert(result, str:sub(lastEnd))
		end

		return result
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
				lineClone.Text = ""
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
				
				local layout = Instance.new("UIListLayout")
				layout.Parent = lineClone
				layout.FillDirection = Enum.FillDirection.Horizontal
				layout.SortOrder = Enum.SortOrder.LayoutOrder
				
				if(object.Name == "Label") then
					layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				end
				
				table.insert(wrappedObject[object],lineClone)
				local prevEndPos = 0
				local order = 0
				
				local createText = function(text)
					local label = lineClone:Clone()
					label:ClearAllChildren()
					label.Parent = lineClone
					label.Text = text
					label.AutomaticSize = Enum.AutomaticSize.X
					label.Size = UDim2.new(0,0,0,label.TextSize)
					label:SetAttribute("IsMessagePart",true)
					order += 1
					label.LayoutOrder = order
				end
				
				for _,tag in pairs(lineDetector:splitXml(line)) do
					for _,text in pairs(split(tag.content,spacing)) do
						if(text == spacing) then
							emojiNumber += 1
							order += 1
							placeEmoji(lineClone,customEmojis,emojiNumber,order)
						else
							createText(text)
						end
					end
				end
			end
		end
	end

	functions.lineDetector = lineDetector

	return functions
end