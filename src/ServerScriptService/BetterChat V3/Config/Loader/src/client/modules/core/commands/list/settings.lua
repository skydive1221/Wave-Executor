-- Author: @Jumpathy
-- Name: settings.lua
-- Description: Open settings menu

local starterGui = game:GetService("StarterGui");
local command = {};
command.name = "settings";
command.aliases = {"s"};
command.security = "internal"
command.call = function(_,environment)
	pcall(function()
		if(environment.config.SettingsMenu.Enabled and (not environment.config.SettingsMenu.ApiEnabledAndUIDisabled)) then
			environment:openSettingsMenu()
		end
	end)
end

return command;