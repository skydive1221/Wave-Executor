-- Author: @Jumpathy
-- Name: userAutofill.lua
-- Description: User autofill system

return function(config)
	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer

	local autofill = {}
	autofill.beginsWith = "/"
	autofill.endsWith = nil
	autofill.security = "internal"
	
	local autofillNameCommands = {
		["/mute"] = true,
		["/m"] = true,
		["/unmute"] = true,
		["/unm"] = true
	}
	
	if(config.Messages.Private.WhispersEnabled) then
		autofillNameCommands["/whisper"] = true
		autofillNameCommands["/w"] = true
	end

	autofill.onCapture = function(matches,environment)
		local fill,gsub,callback = {},{},nil
		local match = matches[#matches]
		local detect = function(player,name,base,command,isDisplayName)
			if(player ~= localPlayer) then
				table.insert(fill,{
					text = (isDisplayName and name .. " @"..player.Name or name),
					autofillBar = match.before .. command .. name,
					gsub = { --> replace (eg: /w Jump) with (/w Jumpathy)
						command..base,
						command..player.Name.." "
					}
				})
			end
		end
		if(match) then
			local startIdx = match.text:find(" ")
			if(startIdx) then
				local text = match.text:sub(startIdx + 1,#match.text)
				local command = "/" .. match.text:sub(1,startIdx)
				if(autofillNameCommands[command:gsub(" ","")]) then				
					if(string.len(text) >= 1) then
						for _,player in pairs(players:GetPlayers()) do
							if(player.Name:sub(1,#text) == text) then
								detect(player,player.Name,text,command)
							elseif(player:GetAttribute("DisplayName"):sub(1,#text) == text) then
								detect(player,player:GetAttribute("DisplayName"),text,command,true)
							end
						end
					end
					if(#match.text:split(" ") >= 3) then
						text = text:gsub(" ","")
						if(players:FindFirstChild(text) and command:sub(1,2) == "/w") then
							gsub[command .. text .. " "] = ""
							local target = players[text]
							callback = function()
								environment:whisper(target)
							end
						end
					end
				end
			end
		end
		return gsub,fill,callback
	end

	return autofill
end