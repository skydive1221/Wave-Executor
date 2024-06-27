-- Author: @Jumpathy
-- Name: richText.lua
-- Description: Rich text formatting

local richText = {}
local f = math.floor
local markdown = require(script.Parent:WaitForChild("markdown"))(richText)

function richText:escape(text) -- like one of the most important functions lol
	return text:gsub(".",{
		["<"] = "&lt;",
		[">"] = "&gt;",
		["\""] = "&quot;",
		["'"] = "&apos;",
		["&"] = "&amp;"
	})
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

function richText:markdown(text)
	return markdown:format(text)
end

return richText