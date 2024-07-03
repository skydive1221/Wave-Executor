-- Author: @Jumpathy
-- Name: loader.lua
-- Description: Better chat loader

local configuration = require(script.Parent)
local toRequire = script:WaitForChild("src")
local addons = script.Parent.Parent:WaitForChild("Addons")

require(toRequire)(configuration,addons)