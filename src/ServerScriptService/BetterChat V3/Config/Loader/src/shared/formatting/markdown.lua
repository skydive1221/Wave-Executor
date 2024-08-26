-- Author: @Jumpathy
-- Name: markdown.lua
-- Description: Chat system text formatting system, eg: **bold** --> (imagine this is now bold text)
-- Note: I added a ton of comments to this to try to explain what in the world is my wacky-looking code is even attempting to do
-- Edit like 3 months later: yea thank god I added those comments lol I don't even know what this says AND I WROTE IT

local colorModule = require(script.Parent:WaitForChild("color"))

return function(rich_text,config)
	local guid = rich_text:getId()
	local availableFonts = Enum.Font:GetEnumItems()
	
	local enabled = config.Messages.Markdown or {
		ItalicBold = true,
		Bold = true,
		Italics = true,
		Underlines = true,
		Strikethrough = true,
		Colored = true,
		Outlines = true,
	}
	
	if enabled.Fonts == nil then
		enabled.Fonts = true
	end
	
	local parse_color = function(color)
		color = color:gsub(" ","") -- remove spaces
		local default = Color3.fromRGB(255,255,255)
		if(color:sub(1,1) == "#" and #color >= 7) then -- check if they passed a hex value
			return colorModule.rgb_to_hex(colorModule.hex_to_rgb(color))
		elseif(color:find(",")) then -- check if they passed a RGB value
			local rgb = {}
			for _,num in pairs(string.split(color,",")) do -- R,G,B --> {R,G,B}
				table.insert(rgb,math.clamp((tonumber(num) or 0),0,255))
			end
			return colorModule.rgb_to_hex(Color3.fromRGB(unpack(rgb)))
		else
			return colorModule.rgb_to_hex(colorModule.matchBrickcolor(color))
		end
	end
	
	local parse_font = function(text)
		for _,font in pairs(availableFonts) do
			if(font.Name:lower() == text) then
				return font.Name
			end
		end
	end
	
	local font_tag = function(text,info)
		if info and #info >= 1 then
			local font = parse_font(info:lower():gsub(" ",""))
			if font then
				return ('<font face="%s">%s</font>'):format(font,text)
			end
		end
		return text
	end

	local color_tag = function(text,color) -- place text in a rich text color tag with the specified color
		return ('<font color="%s">%s</font>'):format(parse_color(color),text)
	end
	
	local stroke_tag = function(text,color)
		return ('<stroke thickness = "1" join = "round" color="%s">%s</stroke>'):format(parse_color(color),text)
	end
	
	local main = {}
	
	local regulartag = function(text,tag,format)
		main = {}
		local from = function(t,c) --> generates a XML tag for opening and closing (c -> true = closing): eg: <a> </a>
			if c then
				return ("<%s%s>"):format((c and "/" or ""),t)
			else
				return(`<%s>`):format(t)
			end
		end
		local opening = ""
		local closing = ""
		for i = 1,#tag do
			table.insert(main,1,tag:sub(i,i)) -- insert this in the reversed order of the tags
			-- when using multiple tags, to close it you need to close it with the same tags but backwards (this table manages that)
			-- ex: <i><b>hi</b></i>
			opening = opening .. from(tag:sub(i,i))
		end
		for _,v in pairs(main) do
			closing = closing .. from(v,true)
		end
		return (opening .. (text) .. closing)
	end

	local customcolor = function(b)
		-- color format ex: (255,0,0 / hi)
		local s,e = string.find(b,"/") -- look for the separator as seen in the example
		if(s and e and b:sub(1,1) ~= "<") then -- if it has the separator, then make sure it wasn't also falsified by a closing tag like </i>
			if b and b:find("<i>") then
				if(b:sub(s-1,s+2) == "</i>") then
					return ("(" .. b .. ")")
				end				
			end
			local split = {b:sub(1,e - 1),b:sub(e + 1,#b)} -- don't use string.split because of the other formats like *italics* would throw it off with the closing tags.
			local color = split[1]
			local awaitingClose = (split[2]:sub(1,1) == string.char(32)) -- see if we need to remove spaces at the start from when it's separated by the '/' (so messages arent padded out weirdly)
			local text = split[2]:gsub(".",function(c)
				if(awaitingClose) then
					local is_space = (c == string.char(32))
					awaitingClose = is_space
					return(is_space and "" or c)
				else
					return c
				end
			end)
			return color_tag(text,color) -- actually use this information lol
		else -- if it was a false alarm by someone just using text like "im murderer (im not)" then make sure to return it properly
			return "(" .. b .. ")"
		end
	end
	
	local filter = function(tbl)
		local ret = {}
		for _,v in pairs(tbl) do
			if(v) then
				table.insert(ret,v)
			end
		end
		return ret
	end
	
	local wrap = function(b,start,close,callback)
		local s, e = string.find(b, "/")
		if s and e and b:sub(1, 1) ~= "<" then
			if b and b:find("<i>") then
				if b:sub(s - 1, s + 2) == "</i>" then
					return start .. b .. close
				end				
			end
			local split = {b:sub(1, e - 1), b:sub(e + 1, #b)}
			local color = split[1]
			local text = split[2]:gsub("^%s*(.-)%s*$", "%1") -- trim leading/trailing spaces

			-- Ensure text is not empty or invalid
			if text == "" or text:match("^%-+$") then
				text = "-" -- replace with a placeholder if necessary
			end

			return callback(text, color)
		else
			return start .. b .. close
		end
	end
	
	local customcolor = function(b)
		return wrap(b,"(",")",color_tag)
	end
	
	local outline = function(b)
		return wrap(b,"[","]",stroke_tag)
	end
	
	local font = function(b)
		return wrap(b,"&lt;","&gt;",font_tag)
	end
	
	local formats = filter({
		-- don't change the order of these pls lol
		-- they're priority-based so things like *** would be grabbed before ** etc
		enabled.ItalicBold and {"***","ib",regulartag}, --> ***hello*** means italic and bold
		enabled.Bold and {"**","b",regulartag}, --> **bold** means bold
		enabled.Italics and {"*","i",regulartag}, --> *italics* means italic ofc
		enabled.Underlines and {"__","u",regulartag}, --> __under__ underlines your text
		enabled.Italics and {"_","i",regulartag}, --> _hi_ makes italics
		enabled.Strikethrough and {"~~","s",regulartag}, --> ~~hi~~ makes the text crossed through
		enabled.Colored and {"(","",customcolor,")"}, --> (255,0,0 / red) (#FF0000 / red) (Really red / red) --> red text
		enabled.Outlines and {"[","",outline,"]"},
		enabled.Fonts and {"&lt;","",font,"&gt;"},
	})

	local _gsub_escape_table = {
		["\000"] = "%z", ["("] = "%(", [")"] = "%)", ["."] = "%.",
		["%"] = "%%", ["+"] = "%+", ["-"] = "%-", ["*"] = "%*",
		["?"] = "%?", ["["] = "%[", ["]"] = "%]", ["^"] = "%^",
		["$"] = "%$",
	}

	local escapePattern = function(str)
		return str:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", _gsub_escape_table)
	end
	
	local new = function(p1,p2) -- generates the pattern needed to find text
		return(escapePattern(p1) .. "(.-)" .. escapePattern(p2))
	end

	local markdownFormat
	markdownFormat = function(text,depth,canUseColor)
		if(not depth) then
			--text = rich_text:escape(text)
		end
		local base = text
		local matches = {gsub = {},count = 0}
		for _,info in pairs(formats) do
			text = text:gsub(new(info[1],info[4] or info[1]),function(between)
				-- we found some text between a pattern like '*hi*' and now we reassemble it so that it can be removed later
				-- this whole thing makes sure that: *yo* -> <i>yo</i>
				local matched = info[1] .. between .. (info[4] or info[1])
				-- this checks to make sure that the pattern isn't just something like ________ (in my past system this just removed the whole thing)
				local doContinue = not (matched == string.rep(matched:sub(1,1),#matched))
				if(doContinue) then
					-- at the end all the info in the 'gsub' table will be ran
					table.insert(matches.gsub,{
						escapePattern(matched), -- the text we want to remove
						info[3](between,info[2],info[1]) -- this is the text we'll replace like '<i>hi</i>'
					})
					matches.count += 1 -- later we do recursive checks to make sure that we get all of the patterns and if this never goes above zero then the recursive check ends
					return ""
				end
			end)
		end
		
		-- if anything is passed we'll replace all the text to be formatted properly

		for _,rep in pairs(matches.gsub) do
			base = base:gsub(unpack(rep))
		end

		-- when this function is first called, it won't have the 'depth' argument and it can do another check

		-- since when text is detected like "*__underline but italics__*" it'll only get the italics part but then we run this to make sure it also gets the underline
		if(not depth) then
			local layers = 0
			if(matches.count >= 1) then -- then we'll check again if there ever was some text found like *italics*
				repeat -- repeat this whole code 25 times or until there's no more *special text* found
					layers += 1
					base,matches = markdownFormat(base,layers,canUseColor)
				until(layers >= 25 or matches.count == 0)
			end
		end
		return base,matches
	end

	return {
		format = function(_,text,canUseColor) -- :format("*italics*") --> "<i>italics</i>"
			local formatted,matches = markdownFormat(text,nil,canUseColor)
			return formatted
		end
	}
end