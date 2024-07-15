-- Author: @Jumpathy
-- Name: dance.lua
-- Description: Emote support

local command = {}
command.name = "e"
command.aliases = {"emote"}
command.call = function(message)
	local defaultEmotes = {
		wave = true,point = true,dance = true,
		dance2 = true,dance3 = true,laugh = true,
		cheer = true
	}

	local function getEmoteName()
		if(string.sub(message,1,3) == "/e ") then
			return message:sub(4,#message)
		elseif(string.sub(message,1,7) == "/emote ") then
			return message:sub(8,#message)
		end
		return nil
	end

	local systemMessage = function(message)
		--print("system message",message)
	end

	local emoteName = getEmoteName()
	if(defaultEmotes[emoteName]) then
		return
	end

	local character = game:GetService("Players").LocalPlayer.Character
	if(not character) then
		systemMessage("You can't use emotes right now.")
		return
	end

	local animateScript = character:FindFirstChild("Animate")
	if(not animateScript) then
		systemMessage("You can't use emotes here.")
		return
	end

	local playEmoteBindable = animateScript:FindFirstChild("PlayEmote")
	if(not playEmoteBindable) then
		systemMessage("You can't use emotes here.")
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if(not humanoid) then
		systemMessage("You can't use emotes right now.")
		return
	end

	if(humanoid.RigType ~= Enum.HumanoidRigType.R15) then
		systemMessage("Only R15 avatars can use emotes.")
		return
	end

	local humanoidDescription = humanoid:FindFirstChildOfClass("HumanoidDescription")
	if(not humanoidDescription) then
		systemMessage("You can't use emotes here.")
		return true
	end

	local index = {}
	for name,value in pairs(humanoidDescription:GetEmotes()) do
		index[string.lower(name)] = name
	end

	local slot = tonumber(emoteName)
	if(slot) then
		for _,information in pairs(humanoidDescription:GetEquippedEmotes()) do
			if(information.Slot == slot) then
				emoteName = information.Name
			end
		end
	end

	emoteName = index[emoteName:lower()]
	if(not emoteName) then
		systemMessage("You can't use that emote.")
		return
	end

	coroutine.wrap(function()
		local ok,didPlay = pcall(function() 
			return humanoid:PlayEmote(emoteName)
		end)

		if(not ok) then
			systemMessage("You can't use emotes here.")
		elseif(not didPlay) then
			systemMessage("You can't use emotes right now.")
		end
	end)()
end

return command