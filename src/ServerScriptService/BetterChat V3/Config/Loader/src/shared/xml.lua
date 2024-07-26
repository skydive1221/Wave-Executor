-- update has a much more friendly overhead

return function(s)
	local stack = {}
	local top = {}
	table.insert(stack, top)

	local i = 1
	while i <= #s do
		if s:sub(i, i) == "<" then
			if s:sub(i+1, i+1) == "/" then
				-- Closing tag
				table.remove(stack)
				top = stack[#stack]
				local closeIndex = s:find(">", i)
				if closeIndex then
					i = closeIndex + 1
				else
					i = #s + 1
				end
			else
				-- Opening tag
				local j = s:find(">", i)
				if not j then
					j = #s + 1
				end
				local tag = s:sub(i+1, j-1)
				local name, attrs = tag:match("(%w+)(.*)$")
				local node = {}

				-- Parse attributes
				if attrs then
					node._attr = {}
					for k, v in attrs:gmatch('%s(%w+)="([^"]*)"') do
						node._attr[k] = v
					end
				end

				if top[name] then
					if type(top[name]) ~= "table" then
						top[name] = {top[name]}
					end
					table.insert(top[name], node)
				else
					top[name] = node
				end
				top = node
				table.insert(stack, top)
				i = j + 1
			end
		else
			-- Text content
			local j = s:find("<", i) or #s + 1
			local text = s:sub(i, j - 1)
			if text:find("%S") then  -- Only add non-empty text
				if #top == 0 then
					top[1] = text
				else
					table.insert(top, text)
				end
			end
			i = j
		end
	end

	return stack[1]
end