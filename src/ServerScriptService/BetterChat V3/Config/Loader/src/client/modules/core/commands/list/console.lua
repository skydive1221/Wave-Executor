-- Author: @Jumpathy
-- Name: developerConsole.lua
-- Description: Ability to open developer console via /console

local starterGui = game:GetService("StarterGui")
local command = {}
command.name = "console"
command.aliases = {}
command.call = function()
	local devConsoleVisible = game.StarterGui:GetCore("DevConsoleVisible")
	game:GetService("StarterGui"):SetCore("DevConsoleVisible",not devConsoleVisible)
end

return command