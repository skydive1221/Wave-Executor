return function(root,chatUi)
	local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
	local textService = game:GetService("TextService")
	
	local fromXml = root

	local byLetter = function(inputString,callback,spacing)
		for idx,codepoint in utf8.codes(inputString) do
			callback(utf8.char(codepoint),idx)
		end
	end

	local splitXmlAndText = function(input,override)
		local result = {}
		local stack = {}
		local lastIndex = 1

		-- Helper function to add text segments to the result
		local function addText(start, stop)
			if start <= stop then
				local text = input:sub(start, stop)
				table.insert(result, {["type"] = "text", content = text})
			end
		end

		while true do
			local tagStart, tagEnd = input:find("</?[%w:][^>]*>%s*", lastIndex)
			if not tagStart then
				addText(lastIndex, #input)
				break
			end

			local spacesStart, spacesEnd = input:find("^%s*", tagEnd + 1)
			if spacesStart then
				tagEnd = spacesEnd
			end

			if #stack == 0 then
				addText(lastIndex, tagStart - 1)
			end

			local tag = input:sub(tagStart, tagEnd)
			if tag:match("^</") then -- Closing tag
				if #stack > 0 then
					local openTagStart = table.remove(stack)
					if #stack == 0 then
						local content = input:sub(openTagStart, tagEnd)
						local toAdd;
						if(content:sub(#content,#content) == " ") then
							toAdd = tagEnd
							content = content:sub(1,#content-1)
						end
						if not override then
							table.insert(result, {["type"] = "xml", content = fromXml(content)})
						else
							table.insert(result, {["type"] = "text", content = content})
						end
						if toAdd then
							addText(tagEnd,tagEnd)
						end
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

	local constructProxy = function()
		local gui = chatUi

		local label = Instance.new("TextLabel")
		label.Parent = gui
		label.TextWrapped = true
		label.AutomaticSize = Enum.AutomaticSize.Y
		label.RichText = true
		label.TextTransparency = 1
		label.BackgroundTransparency = 1
		label.Name = "WrappingLabel"
		
		return label
	end

	local proxyLabel = constructProxy()

	local wrapLabel = function(label)
		proxyLabel.Size = UDim2.fromOffset(label.AbsoluteSize.X,label.TextSize)
		proxyLabel.TextXAlignment = label.TextXAlignment
		proxyLabel.TextYAlignment = label.TextYAlignment
		proxyLabel.Text = label.Text
		proxyLabel.Font = label.Font
		proxyLabel.TextSize = label.TextSize
	end

	local invisibleChars = {
		utf8.char(0x200A)
	}
	
	local testCharSupport = function(char, font, fontSize)
		local success, result = pcall(function()
			return textService:GetTextSize(char, fontSize, font, Vector2.new(1000, 1000)).X > 0
		end)
		return success and result
	end

	local getSpacing = function(font,fontSize,targetWidth,idx)
		local supportedChars = {}
		local charWidths = {}
		local list = invisibleChars
		
		for _, char in ipairs(list) do
			if testCharSupport(char, font, fontSize) then
				table.insert(supportedChars, char)
				charWidths[char] = textService:GetTextSize(char, fontSize, font, Vector2.new(1000, 1000)).X
			end
		end

		table.sort(supportedChars, function(a, b)
			return charWidths[a] < charWidths[b]
		end)

		local result = ""
		local currentWidth = 0

		while currentWidth < targetWidth do
			local bestChar = supportedChars[1]
			local bestDiff = math.huge
			for _, char in ipairs(supportedChars) do
				local newWidth = currentWidth + charWidths[char]
				local diff = math.abs(targetWidth - newWidth)

				if diff < bestDiff and newWidth <= targetWidth then
					bestChar = char
					bestDiff = diff
				end
			end
			result = result .. bestChar
			currentWidth = currentWidth + charWidths[bestChar]
			if currentWidth + charWidths[supportedChars[1]] > targetWidth then
				break
			end
		end

		return result, currentWidth
	end

	local lineDetector = {}
	
	local countChar = function(str, char)
		return select(2, string.gsub(str, char, ""))
	end
	
	function lineDetector:splitLines(object,spacing)
		local text = object.Text
		text = text:gsub(spacing,"<>")
				
		local replacement = getSpacing(object.Font,object.TextSize,object.TextSize,2)		
		local response = ""
		if(object.Text:find("<")) then
			response = splitXmlAndText(text)
		else
			response = {
				{
					["type"] = "text",
					["content"] = text
				}
			}
		end

		local textSize = object.TextSize
		local maxWidth = object.AbsoluteSize.X
		local lines = {{}}

		local format = function(letter,italic,bold,color,stroke)
			if(italic == Enum.FontStyle.Italic) then
				letter = `<i>{letter}</i>`
			end
			if(bold == Enum.FontWeight.Bold) then
				letter = `<b>{letter}</b>`
			end
			if(color) then
				letter = `<font color="{color}">{letter}</font>`
			end
			if(stroke) then
				letter = `<stroke color="{stroke.color}" thickness="{stroke.thickness}" joins = "{stroke.joins}">{letter}</stroke>`
			end
			return letter
		end

		local richText = {}
		local count = 0
		for key, text in pairs(response) do
			text.style = Font.fromEnum(object.Font)
			text.letters = {}
			if text["type"] == "xml" then
				local innerContent = text.content
				for _,tag in pairs(recurse(text.content, nil, 0)) do
					if tag == "i" then
						text.style.Style = Enum.FontStyle.Italic
					elseif tag == "b" then
						text.style.Weight = Enum.FontWeight.Bold
					elseif tag == "font" then
						text.color = innerContent[tag]["_attr"]["color"]
					elseif tag == "stroke" then
						text.stroke = {}
						text.stroke.color = innerContent[tag]["_attr"]["color"]
						text.stroke.joins = innerContent[tag]["_attr"]["joins"]
						text.stroke.thickness = innerContent[tag]["_attr"]["thickness"]
					end
					innerContent = innerContent[tag]
				end
				text.content = innerContent
				local txt = ""
				local idx = 0
				byLetter(text.content,function(letter,i)
					idx += 1
					count += 1
					richText[count] = format(letter,text.style.Style,text.style.Weight,text.color,text.stroke)
					text.letters[idx] = letter
				end)
			else
				local idx = 0
				byLetter(text.content,function(letter,i)
					count += 1
					idx += 1
					text.letters[idx] = letter
				end)
			end
		end
		
		local lines = {}

		wrapLabel(object)

		local current = ""
		local idx = 0
		local lastWhitespace = 0
		local lastStart = 0
		local lineIndexes = {{1}}

		local add = function(idx,loc)
			local last = lineIndexes[#lineIndexes]
			local previous;
			if(#lineIndexes > 1) then
				previous = lineIndexes[#lineIndexes - 1]
			end
			if(#last < 2) then
				table.insert(last,idx)
				if current:sub(last[1],last[1]):match("%s") then
					last[1] += 1
				end
				if previous then
					if(last[1] == previous[2]) then
						last[1] += 1
					end
				end
			else
				lineIndexes[#lineIndexes + 1] = {}
				table.insert(lineIndexes[#lineIndexes],idx)
				if previous then
					if(last[1] == previous[2]) then
						last[1] += 1
					end
				end
			end
		end
		
		for _, tag in pairs(response) do
			for _, letter in pairs(tag.letters) do
				idx += 1
				current ..= letter
				local lastSize = proxyLabel.AbsoluteSize.Y
				proxyLabel.Text = current
				if(letter:match("%s")) then
					lastWhitespace = idx
				end
				local currentSize = proxyLabel.AbsoluteSize.Y
				if(currentSize - lastSize ~= 0 and (idx ~= 1) or letter == "\n") then
					local lastWord = current:sub(lastWhitespace+1,#current)
					proxyLabel.Text = lastWord
					if current:match("%s") then
						local lastWordSizeY = proxyLabel.AbsoluteSize.Y
						local wrapStart = 0
						if(lastWordSizeY > proxyLabel.TextSize) then
							wrapStart = #current
							lastStart = lastStart - 1
						else
							wrapStart = lastWhitespace
						end
						if(lastStart ~= 0) then
							add(lastStart+1,1)
						end
						lastStart = wrapStart
						add(wrapStart-1,2)
					else
						if(lastStart ~= 0) then
							add(lastStart-1)
						end
						lastStart = idx
						add(idx-1)
					end
					proxyLabel.Text = current
				end
			end
		end
		for k,index in pairs(lineIndexes) do
			if(k > 1) then
				local previous = lineIndexes[k - 1]
				local diff = (index[1] - previous[2])-1
				if(diff > 0) then
					index[1] -= diff
				end
			end
			table.insert(lines,current:sub(index[1],index[2]))
		end
		local last = lineIndexes[#lineIndexes]
		if(last[#last] ~= #current and proxyLabel.AbsoluteSize.Y > proxyLabel.TextSize) then
			table.insert(lines,current:sub(last[#last]+1,#current))
		end
		local total = 0
		for k,line in pairs(lines) do
			local reconstructed = ""
			for i = 1,#line do
				total += 1
				if richText[total] then
					reconstructed ..= richText[total]
				else 
					reconstructed ..= line:sub(i,i)
				end
			end
			lines[k] = reconstructed
		end
		
		for k,line in pairs(lines) do
			if(line:sub(1,1):match("%s")) then
				lines[k] = line:sub(2,#line)
			end
		end
		
		for k,line in pairs(lines) do
			local lastChar,nextChar = line:sub(#line,#line),nil
			local nextLine = lines[k + 1]
			if nextLine then
				nextChar = nextLine:sub(1,1)
			end 
			if(lastChar == "<" and nextChar == ">") then
				lines[k] = line:sub(1,#line-1)
				lines[k + 1] = "<" .. nextLine
			end
		end
		
		for k,line in pairs(lines) do
			lines[k] = line:gsub("<>",spacing)
		end
								
		return lines
	end
	
	function lineDetector:splitXml(text)
		return splitXmlAndText(text,true)
	end

	function lineDetector:getSpacingFor(object,spacing)
		return getSpacing(object.Font,object.TextSize,spacing)
	end

	function lineDetector:getTextSize(object,text)
		wrapLabel(object)
		proxyLabel.Text = text
		proxyLabel.AutomaticSize = Enum.AutomaticSize.None
		return proxyLabel.TextBounds
	end

	return lineDetector
end