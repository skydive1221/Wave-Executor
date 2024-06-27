-- Author: @Jumpathy
-- Name: extract.lua
-- Description: Extract humanoid description to a table

local propertiesToExtract = {
	"Archivable",
	"BackAccessory",
	"BodyTypeScale",
	"ClimbAnimation",
	"DepthScale",
	"Face",
	"FaceAccessory",
	"FallAnimation",
	"FrontAccessory",
	"GraphicTShirt",
	"HairAccessory",
	"HatAccessory",
	"Head",
	"HeadColor",
	"HeadScale",
	"HeightScale",
	"IdleAnimation",
	"JumpAnimation",
	"LeftArm",
	"LeftArmColor",
	"LeftLeg",
	"LeftLegColor",
	"NeckAccessory",
	"Pants",
	"ProportionScale",
	"RightArm",
	"RightArmColor",
	"RightLeg",
	"RightLegColor",
	"RunAnimation",
	"Shirt",
	"ShouldersAccessory",
	"SwimAnimation",
	"Torso",
	"TorsoColor",
	"WaistAccessory",
	"WalkAnimation",
	"WidthScale"
}

return function(description)
	local extracted = {}
	for _,property in pairs(propertiesToExtract) do
		extracted[property] = description[property]
	end
	return extracted
end