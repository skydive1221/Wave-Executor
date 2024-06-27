	-- Author: @Jumpathy
-- Name: loader.lua
-- Description: Better chat loader

local configuration = require(script.Parent)
local addons = script.Parent.Parent:WaitForChild("Addons")
local toRequire = script:WaitForChild("src")

require(toRequire)(configuration,addons)