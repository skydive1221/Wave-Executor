-- Author: @Jumpathy
-- Name: richText.lua
-- Description: Rich text formatting

return function(config,getAllowedEmojisFor)
	local richText = {}
	local f = math.floor
	local runService = game:GetService("RunService")
	local isServer = runService:IsServer()
	local httpService = game:GetService("HttpService")
	local guid = httpService:GenerateGUID()
	
	local fromXml = require(script.Parent.Parent.xml)

	function richText:escape(text) -- like one of the most important functions lol
		return text:gsub(".",{
			["<"] = "&lt;",
			[">"] = "&gt;",
			["\""] = "&quot;",
			["'"] = "&apos;",
			["&"] = "&amp;"
		})
	end

	function richText:unescape(text)
		local tbl = {
			["&lt;"] = "<",
			["&gt;"] = ">",
			["&quot;"] = "\"",
			["&apos;"] = "'",
			["&amp;"] = "&"
		}
		for pattern, replacement in pairs(tbl) do
			text = text:gsub(pattern, replacement)
		end
		return text
	end

	function richText:getId()
		return guid
	end

	function richText:colorize(text,rgb)
		return("<font color=\"rgb(%s)\">%s</font>"):format(richText:tostringRgb(rgb),richText:escape(text))
	end

	local parse = function(hex,...)
		local packed = {}
		for _,pos in pairs({...}) do
			table.insert(packed,tonumber(("0x%s"):format(hex:sub(unpack(pos)))))
		end
		return unpack(packed)
	end

	function richText:tostringRgb(rgb)
		return("%s,%s,%s"):format(f(rgb.R * 255),f(rgb.G * 255),f(rgb.B * 255))
	end

	function richText:hexToRgb(hex)
		return Color3.fromRGB(parse(hex:gsub("#",""),{1,2},{3,4},{5,6}))
	end

	local markdown = require(script.Parent:WaitForChild("markdown"))(richText,config)

	function richText:markdown(text,bypass)
		if isServer or bypass then
			if text:sub(1,1) == [[\]] then
				return text:sub(2,#text)
			end
			return markdown:format(text)
		else
			-- new update has server process rich text
			return text
		end
	end

	function richText:mark(text)
		return markdown:format(text)
	end

	local stripXMLTags = function(text)
		return (text:gsub("<.->",""))
	end

	function richText:strip(message)
		return stripXMLTags(message)
	end

	local restoreTags = function(original,filtered)
		local result = ""
		local originalIndex = 1
		local filteredIndex = 1

		while originalIndex <= #original do
			local char = original:sub(originalIndex,originalIndex)
			if char == "<" then
				local tagEnd = original:find(">",originalIndex)
				result = result .. original:sub(originalIndex,tagEnd)
				originalIndex = tagEnd + 1
			else
				result = result .. filtered:sub(filteredIndex,filteredIndex)
				filteredIndex = filteredIndex + 1
				originalIndex = originalIndex + 1
			end
		end

		return result
	end

	local getIndex = function(dict)
		if(dict[1]) then
			return 1
		end
		for k,v in pairs(dict) do
			if(k ~= "_attr") then
				return k
			end
		end
	end

	local recurse;
	recurse = function(tag,index,depth,base)
		depth += 1
		local idx = getIndex(tag)
		if not base then
			base = tag
		end
		if(typeof(tag[idx]) == "table") then
			if(depth < 100) then
				local indexed = index or {}
				table.insert(indexed,idx)
				return recurse(tag[idx],indexed,depth,base)
			end
		else
			local indexed = index or {}
			table.insert(indexed,idx)
			return indexed
		end
	end

	local allTags = function(tags)
		return recurse(tags,nil,0)
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

	local byLetter = function(inputString,callback)
		for idx,codepoint in utf8.codes(inputString) do
			callback(utf8.char(codepoint),idx)
		end
	end

	richText.splitXmlAndText = function(input)
		local result = {}
		local stack = {}
		local lastIndex = 1

		-- Helper function to add text segments to the result
		local function addText(start, stop)
			if start <= stop then
				local text = input:sub(start, stop)
				if text:find("%S") then -- Check if there's any non-whitespace character
					table.insert(result, {["type"] = "text", content = text})
				end
			end
		end

		while true do
			local tagStart, tagEnd = input:find("</?[%w:][^>]*>", lastIndex)
			if not tagStart then
				addText(lastIndex, #input)
				break
			end

			if #stack == 0 then
				addText(lastIndex, tagStart - 1)
			end

			local tag = input:sub(tagStart, tagEnd)
			if tag:match("^</") then -- Closing tag
				if #stack > 0 then
					local openTagStart = table.remove(stack)
					if #stack == 0 then
						table.insert(result, {["type"] = "xml", content = (input:sub(openTagStart, tagEnd))})
					end
				end
			else
				table.insert(stack, tagStart)
			end

			lastIndex = tagEnd + 1
		end

		return result
	end

	local getIndex = function(dict)
		if(dict[1]) then
			return 1
		end
		for k,v in pairs(dict) do
			if(k ~= "_attr") then
				return k
			end
		end
	end
	
	local generateTag = function(id,inner)
		return `<image id="{id}">{inner or "custom_emoji"}</image>`
	end

	function richText:processForFilter(message,player)
		local customEmojis = {}
		local count = 0
		local list = getAllowedEmojisFor(player)

		local getFrom = function(id)
			for k,v in pairs(list) do
				if typeof(v) == "table" and v.Image == id then
					return k
				elseif(v == id) then
					return k
				end
			end
		end
		
		local data = {}
		for emojiName,emojiContent in pairs(list) do
			if typeof(emojiContent) == "table" then
				data[emojiName] = emojiContent
				emojiContent = emojiContent.Image
			end
			local imgTag = generateTag(emojiContent)
			local old = message
			message = message:gsub(escapePattern(`:{emojiName}:`),imgTag)
		end

		local split = richText.splitXmlAndText(message)
		
		for _,v in pairs(split) do
			if(v["type"] == "xml") then
				local parsed = fromXml(v["content"])
				for _,tag in pairs(allTags(parsed)) do
					if(tag == "image") then
						local imgId = parsed[tag]["_attr"]["id"]
						local imgTag = generateTag(imgId,"::")
						local imgTag2 = generateTag(imgId,`:{getFrom(imgId)}:`)
						table.insert(customEmojis,{
							imgTag,
							imgId,
							v["content"],
							imgTag2,
							data[getFrom(imgId)]
						})
					end
					parsed = parsed[tag]
				end
			end
		end
		
		for _,emoji in pairs(customEmojis) do
			message = message:gsub(escapePattern(emoji[3]),emoji[1])
		end
			
		local strippedText = stripXMLTags(message)	
		return strippedText,function(filteredText)
			local restored = restoreTags(message,filteredText)
			-- this will filter out the custom emojis to prevent smart bypasses lol
			for _,data in pairs(customEmojis) do
				local toReplace = data[1]
				local replaceWith = data[4]
				restored = restored:gsub(toReplace,replaceWith)
				data[1] = replaceWith
				data[4] = toReplace
			end
			return restored
		end,customEmojis
	end

	return richText
end