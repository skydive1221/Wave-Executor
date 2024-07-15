-- Author: @Jumpathy
-- Name: bubbleChat.lua
-- Description: Bubble chat bc yes

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local playerGui = localPlayer.PlayerGui

local bubbleChat = {}
local billboard = require(script.Parent:WaitForChild("billboard"))

function bubbleChat.init(config,network,environment)
	billboard.init(config,network,environment)
	local newBillboard = function(player)
		billboard:holster(player)
	end
	players.PlayerAdded:Connect(newBillboard)
	for _,player in pairs(players:GetPlayers()) do
		task.spawn(newBillboard,player)
	end
	
	environment.billboard = billboard
end

return bubbleChat