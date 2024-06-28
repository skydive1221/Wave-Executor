-- Author: @Jumpathy
-- Name: privacy.lua
-- Description: Make sure user privacy settings are kept in check

local privacy = {}
local players = game:GetService("Players")
local guiService = game:GetService("GuiService")
local runService = game:GetService("RunService")
local chatService = game:GetService("Chat")

privacy.isXbox = guiService:IsTenFootInterface()

local success,canClientChat = pcall(function()
	return chatService:CanUserChatAsync(players.LocalPlayer.UserId)
end)
local canChat = success and (runService:IsStudio() or canClientChat)
if(canChat == false) then
	privacy.chatDisabled = true
elseif(privacy.isXbox) then
	privacy.chatDisabled = true
end

return privacy