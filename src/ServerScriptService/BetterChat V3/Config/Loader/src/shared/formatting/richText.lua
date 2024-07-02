-- Author: @Jumpathy
-- Name: richText.lua
-- Description: Rich text formatting

local richText = {}
local f = math.floor
local runService = game:GetService("RunService")
local isServer = runService:IsServer()
local httpService = game:GetService("HttpService")
local guid = httpService:GenerateGUID()

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

local markdown = require(script.Parent:WaitForChild("markdown"))(richText)

function richText:markdown(text)
	if isServer then
		return markdown:format(text)
	else
		-- new update has server process rich text
		return text
	end
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

function richText:processForFilter(message)
	local strippedText = stripXMLTags(message)
	return strippedText,function(filteredText)
		return restoreTags(message,filteredText)
	end
end

return richText