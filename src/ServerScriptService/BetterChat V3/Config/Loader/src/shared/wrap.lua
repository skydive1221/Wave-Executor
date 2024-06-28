-- Author: @Jumpathy
-- Name: wrap.lua
-- Description: Wraps a table so different cases like 'SNAKE_CASE' can be used to make developers feel comfortable

local splitFunctionName = function(text)
	return string.sub(string.gsub(text,"(%u)"," %1"),1,-1):split(string.char(32))
end

local constructFunctionNames = function(original)
	local split = splitFunctionName(original)
	return {
		original, -- camelCase
		split[1]:sub(1,1):upper() .. split[1]:sub(2,#split[1]) .. (#split >= 2 and  table.concat({unpack(split,2,#split)},"") or ""), -- PascalCase
		table.concat(split,"_"):upper(), -- SNAKE_CASE
		table.concat(split,"_"):lower() -- snake_case
	}
end

local cache = {}
local reference = {}
local cachedWrappers = {}

wrap = function(api)
	local main = cachedWrappers[tostring(api)] or {}
	cachedWrappers[tostring(api)] = main

	if(not getmetatable(main)) then
		setmetatable(main,{
			__index = function(_,idx)
				for name,value in pairs(api) do
					cache[name] = cache[name] or constructFunctionNames(name)
					for _,newName in pairs(cache[name]) do
						reference[newName] = name
					end
				end
				if(reference[idx]) then
					local name = reference[idx]
					if(typeof(api[name]) == "table") then
						if api[name]["SigId"] then
							return api[name]
						end
						return wrap(api[name])
					end
					return api[name]
				end
			end,
		})
	end
	
	function main:getOriginal()
		return api
	end

	return main
end

return wrap