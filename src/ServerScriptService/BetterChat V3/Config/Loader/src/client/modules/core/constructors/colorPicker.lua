local controller = function()
	local hsl_to_rgb = function(h,s,L)
		h = h/360
		local m1,m2
		if L<=0.5 then 
			m2 = L*(s+1)
		else 
			m2 = L+s-L*s
		end
		m1 = L*2-m2

		local function _h2rgb(m1,m2,h)
			if h<0 then h = h+1 end
			if h>1 then h = h-1 end
			if h*6<1 then 
				return m1+(m2-m1)*h*6
			elseif h*2<1 then 
				return m2 
			elseif h*3<2 then 
				return m1+(m2-m1)*(2/3-h)*6
			else
				return m1
			end
		end

		return _h2rgb(m1,m2,h+1/3),_h2rgb(m1,m2,h),_h2rgb(m1,m2,h-1/3)
	end

	local rgb_to_hsl = function(r,g,b)
		local min = math.min(r,g,b)
		local max = math.max(r,g,b)
		local delta = max - min

		local h,s,l = 0,0,((min+max)/2)

		if l > 0 and l < 0.5 then s = delta/(max+min) end
		if l >= 0.5 and l < 1 then s = delta/(2-max-min) end

		if delta > 0 then
			if max == r and max ~= g then h = h + (g-b)/delta end
			if max == g and max ~= b then h = h + 2 + (b-r)/delta end
			if max == b and max ~= r then h = h + 4 + (r-g)/delta end
			h = h / 6;
		end

		if h < 0 then h = h + 1 end
		if h > 1 then h = h - 1 end

		return h * 360,s,l
	end

	local gamepads = {};

	for i = 1,8 do 
		gamepads[Enum.UserInputType["Gamepad" .. i]] = true;
	end

	local guiService = game:GetService("GuiService");
	local runService = game:GetService("RunService")

	local inset = guiService:GetGuiInset();
	local useInset = false;
	local controllerOffset = (useInset and -inset or Vector2.new(0,0));

	return function(signalModule)
		-- Authors: @Jumpathy (slider and stuff),morashsPeasant (color wheel)
		-- Name: controller.lua
		-- Description: Color wheel controller

		local atan2,sqrt,min,floor,c3 = math.atan2,math.sqrt,math.min,math.floor,Color3.new
		local sin,cos,pi,toRad,toDeg = math.sin,math.cos,math.pi,(math.pi/180),(180/math.pi)
		local sliderModule = require(script.Parent.util:WaitForChild("slider"));

		return function(frame)
			local module = {}
			local api = {};
			local moveMarkerToColor;

			api.colorChanged = signalModule.new();

			local uis = game:GetService("UserInputService")
			local inset = game:GetService("GuiService"):GetGuiInset();

			local wheel = frame:WaitForChild("Wheel");
			local marker = wheel:WaitForChild("Marker");
			local slider = frame:WaitForChild("Slider");
			local options = frame:WaitForChild("Options");

			local r,g,b = options:WaitForChild("R"),options:WaitForChild("G"),options:WaitForChild("B");
			local opts = {R = r,G = g,B = b};
			local last = Color3.fromRGB(255,255,255);

			local from = function(color)
				return {
					R = math.floor(color.R * 255),
					G = math.floor(color.G * 255),
					B = math.floor(color.B * 255)
				}
			end

			local get = function()
				return Color3.fromRGB(tonumber(r.Text),tonumber(g.Text),tonumber(b.Text))
			end

			local focused = false;
			local handle = function(color)
				local new = from(color);
				if(not focused) then
					for k,v in pairs(new) do
						opts[k].Text = v;
					end
				end
				last = color;
				api.colorChanged:Fire(last);
			end

			local hexValue = options.Parent.Hex.Value

			local gradient = sliderModule(slider,function(col)
				hexValue.Text = "#" .. col:ToHex()
				handle(col);
			end);

			local onColor = function(col)
				gradient.Color = col;
			end

			local getFrom = function(value)
				return math.clamp((tonumber(value.Text) or 0),0,255)
			end

			local move = function()
				local packed = {};
				table.insert(packed,getFrom(opts.R));
				table.insert(packed,getFrom(opts.G));
				table.insert(packed,getFrom(opts.B));
				local newColor = Color3.fromRGB(unpack(packed));
				if(moveMarkerToColor) then
					moveMarkerToColor(newColor);
					hexValue.Text = "#" .. get():ToHex()
				end
			end

			for idx,value in pairs(opts) do
				value:GetPropertyChangedSignal("Text"):Connect(function()
					if(value:IsFocused()) then
						if(#value.Text > 3) then
							value.Text = value.Text:sub(1,3);
						end
					end
				end)
				value.FocusLost:Connect(function()
					focused = false;
					local num = getFrom(value);
					value.Text = tostring(num);
					move();
				end)
				value.Focused:Connect(function()
					focused = true;
				end)
			end

			local fromHex = function(value)
				local success,color = pcall(function()
					return Color3.fromHex(value)
				end)
				return success and color or Color3.fromRGB(255,255,255)
			end

			hexValue:GetPropertyChangedSignal("Text"):Connect(function()
				if #hexValue.Text > 6 and hexValue.Text:sub(1,1) ~= "#" then
					hexValue.Text = hexValue.Text:sub(1,6)
				elseif(#hexValue.Text > 6 and hexValue.Text:sub(1,1) == "#") then
					hexValue.Text = hexValue.Text:sub(1,7)
				end
				if(hexValue:IsFocused()) then
					moveMarkerToColor(fromHex(hexValue.Text))
				end
			end)

			--Constants
			local RADIUS = wheel.AbsoluteSize.X/2
			local MRADIUS = math.max(marker.AbsoluteSize.X/2)
			local cx,cy = wheel.AbsolutePosition.X + RADIUS,wheel.AbsolutePosition.Y + RADIUS

			--Moves marker to a certain color
			moveMarkerToColor = function(color)
				local angle,rad = rgb_to_hsl(color.r,color.g,color.b)
				angle,rad = angle * toRad,rad * RADIUS
				local newX,newY = RADIUS + rad * cos(angle),RADIUS - rad*sin(angle) -- (-y)
				marker.Position = UDim2.new(0,newX - MRADIUS,0,newY - MRADIUS)
				--Change color
				onColor(color);
			end

			module.maxLight = 1
			module.minLight = .5
			module.Light = .5 --white

			module.Light = 1
			module.LightRange = NumberRange.new(0,1)
			module.sliderActive = false

			local lightCheck = function()
				return module.Light --for now
			end

			local updateWheel = function(x,y)

				--Color calculations
				local nx,ny = cx - x,cy - y
				local theta = atan2(ny,nx) + pi --makes it sane
				local dist = sqrt((nx * nx) + (ny * ny)) 
				dist = (dist/RADIUS) > .1 and dist or 0
				local lum = dist ~= 0 and .5 or lightCheck()
				local mag = min(RADIUS,dist)
				local hue,sat = 360 - ((theta) * (180/pi)),mag/RADIUS

				--Marker position calc
				local newX,newY = RADIUS + mag * cos(theta),RADIUS + mag * sin(theta)
				marker.Position = UDim2.new(0,newX - MRADIUS,0,newY - MRADIUS)
				local color = c3(hsl_to_rgb(hue,sat,lum))
				hexValue.Text = "#" .. get():ToHex()
				onColor(color);

				return color
			end

			module.init = function()
				local widget = {}
				cx,cy = wheel.AbsolutePosition.X + RADIUS,wheel.AbsolutePosition.Y + RADIUS
				widget.Color = Color3.fromRGB(255,255,255);
				cx,cy = wheel.AbsolutePosition.X + RADIUS,wheel.AbsolutePosition.Y + RADIUS
				moveMarkerToColor(widget.Color)		

				local oldwidget = widget --Quick switcharoo
				widget = module
				widget.wheelDown = wheel.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						if widget.movingWheel and widget.movingWheel.connected then 
							widget.movingWheel:Disconnect();
						end

						if widget.btnUp and widget.btnUp.connected then 
							widget.btnUp:Disconnect() 
						end

						local usingGamepad = false;
						--UIS bind to detect end of input
						widget.btnUp = input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								widget.movingWheel:Disconnect()
								widget.btnUp:Disconnect()
								local pos = uis:GetMouseLocation() - inset
								local color = updateWheel(pos.X,pos.Y)
								widget.Color = color;
							end
						end)

						--UIS bind to detect mouse 
						local on = function(pos)
							local color = updateWheel(pos.X,pos.Y)
							widget.Color = color; --widget:Changed(color)
						end

						local handle = function(input)
							local inputType = input.UserInputType;
							if(gamepads[inputType]) then
								usingGamepad = true;
								local pos = uis:GetMouseLocation() + controllerOffset;
								on(pos);
								return;
							end

							usingGamepad = false;
							if inputType == Enum.UserInputType.MouseMovement or inputType == Enum.UserInputType.Touch then
								local pos = input.Position
								on(pos);
							end
						end

						widget.movingWheel = uis.InputChanged:Connect(handle);
						handle({UserInputType = Enum.UserInputType.MouseMovement,Position = uis:GetMouseLocation() - inset})
					end
				end)

				runService.RenderStepped:Connect(function()
					cx,cy = wheel.AbsolutePosition.X + RADIUS,wheel.AbsolutePosition.Y + RADIUS
				end)
				widget = oldwidget; oldwidget = nil	

				frame.Visible = true
				widget.Active = true
				gradient.Color = Color3.fromRGB(255,255,255);

				return api
			end

			return module
		end
	end
end

return function(environment)
	return {
		new = function(object)
			local wheel = controller()(environment.signal);
			local colorWheel = wheel(object);
			return colorWheel:init();
		end
	}
end