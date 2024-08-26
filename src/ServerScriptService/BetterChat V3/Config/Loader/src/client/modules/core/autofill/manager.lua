-- Author: @Jumpathy
-- Name: manager.lua
-- Description: Autofill manager

local runService = game:GetService("RunService")
local heartbeat = runService.Heartbeat

return function(api,autofills,box,environment)
	local justReplaced
	
	local security = function(fill)
		if(fill.security == "internal") then -- external autofills can also use this, 
			-- I just keep it on the low because it gives them internal API access and it
			-- is unstable if you don't know what you're doing.
			return environment
		end
	end

	local capture = function(text,fill,matches,...)
		local wasReplaced = false
		local gsub,toFill,callback,endAt = fill.onCapture(matches,...)
		if(gsub) then
			for pattern,replace in pairs(gsub) do
				text = text:gsub(pattern,replace)
				wasReplaced = true
			end
			justReplaced = text
			if(wasReplaced) then
				heartbeat:Wait() --> fixes some weird bug on mobile somehow :shrug:
				box.Text = text
			end
		end
		if(toFill) then
			api:fill(toFill)
		end
		if(callback) then
			callback()
		end
		if endAt then
			box.CursorPosition = endAt
		end
	end
	
	box:GetPropertyChangedSignal("Text"):Connect(function()
		api:fill({})
		local length = utf8.len(utf8.nfcnormalize(box.Text))
		if(length <= environment.config.Messages.MaximumLength and (box.Text ~= justReplaced)) then
			local text = box.Text
			for _,fill in pairs(autofills) do
				if(fill.beginsWith ~= "") then
					if(text:find(fill.beginsWith)) then
						if fill.isCommandFill and #text == #fill.beginsWith and text == fill.beginsWith then
							capture(text,fill,{},security(fill))
						else
							local matches = {}
							local found,beginAt = 1,1
							repeat
								local startIdx,endIdx = text:find(fill.beginsWith,beginAt)
								if(endIdx and (endIdx < #text)) then
									local ending = fill.endsWith
									local split = text:sub(endIdx+1,#text):split(((ending ~= "" and ending) or nil))
									local between = split[1]
									if(#between:gsub(" ","") >= 1 or (fill.ignoreSpaces)) then
										table.insert(matches,{
											text = between,
											before = text:sub(1,startIdx-1),
											hasClosing = (#split >= 2)
										})
									end
								end
								found = (endIdx and 1 or 0)
								beginAt = (endIdx and endIdx + 1 or beginAt)
							until(found == 0)
							if(#matches >= 1) then
								capture(text,fill,matches,security(fill))
							end
						end
					end
				else
					capture(text,fill,text,security(fill))
				end
			end
		end
	end)
end