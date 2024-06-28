-- Author: @Jumpathy
-- Name: team.lua
-- Description: Team channel system

return function(config)
	if(not config.Teams.TeamChat) then
		return
	end
	
	local players = game:GetService("Players")
	local localPlayer = players.LocalPlayer

	local autofill = {}
	local env
	autofill.beginsWith = ""
	autofill.endsWith = nil
	autofill.security = "internal"

	autofill.onCapture = function(matches,environment)
		if(not env) then
			env = environment
		end
		
		local gsub,fill,callback = {},{},nil
		if(matches:sub(1,1) == "/") then
			local commandName = matches:split("/")[2]
			if(commandName:find(" ")) then
				commandName = commandName:split(" ")[1]
				if(commandName == "t" or commandName == "team") then
					if(localPlayer.Team ~= nil and (not localPlayer.Neutral)) then
						gsub["/" .. commandName .. " "] = ""
						callback = function()
							local teamPrefix = environment.localization:getMessagePrefix("Team")
							environment:setChannel(teamPrefix,false,nil,{team = localPlayer.Team})
						end
					end
				end
			end
		end
		if(#fill == 0) then
			fill = nil
		end
		return gsub,fill,callback
	end

	localPlayer.Changed:Connect(function()
		if(localPlayer.Team == nil and localPlayer.Neutral) then
			if(env and env:getExtraData()) then
				if(env:getExtraData().team) then
					env:setChannel(nil)
				end
			end
		end
	end)

	return autofill
end