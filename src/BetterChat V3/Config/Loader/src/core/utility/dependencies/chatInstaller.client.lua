-- Author: @Jumpathy
-- Name: chatInstaller.lua
-- Description: Verify chat installation on clientside

local player = game:GetService("Players").LocalPlayer
local holder = game:GetService("StarterPlayer").StarterPlayerScripts
local scripts = player.PlayerScripts

if(not scripts:FindFirstChild("betterChatClient")) then
	holder:WaitForChild("betterChatClient").Parent = scripts
end

task.wait()
script.Parent:Destroy()