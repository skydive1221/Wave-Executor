-- Author: @Jumpathy
-- Name: spritesheet.lua
-- Description: Spritesheet manager

local goToFrame = function(image,frame,rowCount)
	local totalFrames = rowCount.X * rowCount.Y
	local offsetSize = image.ImageRectSize

	frame = math.clamp(frame,1,totalFrames)
	local row = math.ceil((frame / totalFrames)*rowCount.Y)
	local column = (frame - (rowCount.X * (row - 1))) 

	local xPos = (offsetSize.X * (-1 + column))
	local yPos = (offsetSize.Y * (-1 + row))
	image.ImageRectOffset = Vector2.new(xPos,yPos)
end

local manager = {}

function manager.new(imageLabel,columns,rows,totalFrames,fps)
	local rowCount = Vector2.new(columns,rows)
	goToFrame(imageLabel,1,rowCount)

	local atFrame = 0;
	task.spawn(function()
		while(imageLabel and imageLabel:GetFullName() ~= imageLabel.Name) do
			atFrame = (atFrame + 1 > totalFrames and 1 or atFrame + 1)
			goToFrame(imageLabel,atFrame,rowCount)
			task.wait(1/(fps))
		end
	end)
end

return manager