-- Author: @Jumpathy
-- Name: color.lua
-- Description: Color functions
-- Credit: @Blockzez - hex stuff lol

local brickColors = {}
local blank = {}

for i = 1,1032 do -- iirc there's around 1032 brick colors (this gets all of them and adds them to a list)
	local col = BrickColor.new(i)
	local n = col.Name
	local s = n:sub(1,1):lower()
	-- the list is ordered by first character (to prevent it from running ~= 1,032 checks every time this is parsed)
	brickColors[s] = brickColors[s] or {}
	brickColors[s][n] = col.Color
end

local rgb_to_hex = function(color)
	return string.format("#%02X%02X%02X",color.R * 0xFF,color.G * 0xFF,color.B * 0xFF)
end

local hex_to_rgb = function(hex) -- hex to rgb
	local r,g,b = string.match(hex,"^#?(%w%w)(%w%w)(%w%w)$")
	return Color3.fromRGB(tonumber(r,16),tonumber(g,16),tonumber(b,16))
end

local matchBrickcolor = function(toMatch)
	local defaultColor = Color3.fromRGB(0,0,0)
	if(string.len(toMatch) >= 1) then
		for name,col in pairs(brickColors[toMatch:sub(1,1):lower()] or blank) do
			if(name:gsub(string.char(32),""):sub(1,#toMatch):lower() == toMatch:lower()) then
				return(col)
			end
		end
	end
	return(defaultColor)
end

return {
	hex_to_rgb = hex_to_rgb,
	rgb_to_hex = rgb_to_hex,
	matchBrickcolor = matchBrickcolor
}