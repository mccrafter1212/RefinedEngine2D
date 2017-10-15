-- RefinedEngine
-- By: Giancarlo Forero
--
-- A Love2D Game Engine
--

local engine = {
	version = "1.0.0";
};

local objects = {
	["Rectangles"] = {};
	["Ellipses"]   = {};
	["Circles"]    = {};
	["Lines"]      = {};
	["Images"]     = {};
};

local function getDictionarySize(dictionary)
	dictionary = dictionary or {};
	local size = 0;
	for index, object in pairs(dictionary) do
		size = size + 1;
	end
	return size;
end

function engine:NewRectangle(name, drawModeV, xV, yV, widthV, heightV, colorV)
	name      = name or "Rectangle" .. tostring(getDictionarySize(objects.Rectangles));
	drawModeV = drawModeV or "fill";
	xV        = xV or 0;
	yV        = yV or 0;
	widthV    = widthV or 50;
	heightV   = heightV or 50;
	colorV    = colorV or {255, 255, 255, 255};
	
	objects.Rectangles[name] = {
		drawMode  = drawModeV;
		color     = colorV;
		
		x         = xV;
		y         = yV;
		
		width     = widthV;
		height    = heightV;
		
		isStill   = true;
		xMovement = 0;
		yMovement = 0;
	};
	
	
end

function engine:DrawRectangle(name)
	if (type(name) == "string") then
		local rect = objects.Rectangles[name] or nil;
		if (rect == nil) then
			error("Rectangle " .. name .. " does not exist.");
		else
			love.graphics.setColor(rect.color);
			love.graphics.rectangle(rect.drawMode, rect.x, rect.y, rect.width, rect.height);
		end
	else
		error("Expected string value in DrawRectangle(String name), got " .. type(name));
	end
end

function engine:DefineMovement(shapeType, name, xmove, ymove)
	if (type(shapeType) == "string") then
		if (type(name) == "string") then
			local shape = objects[shapeType][name];
			if (shape == nil) then
				error("Rectangle " .. name .. " does not exist.");
			else
				if (type(xmove) == "number" and type(ymove) == "number") then
					shape.isStill = false;
					shape.xMovement = xmove;
					shape.yMovement = ymove;
				else
					error("Exepected number value in DefineMovement(String shapeType, String name, Number xmove, Number ymove)");
				end
			end
		else
			error("Expected string value in DefineMovement(String shapeType, String name, Number xmove, Number ymove), got " .. type(name));
		end
	else
		error("Expected string value in DefineMovement(String shapeType, String name, Number xmove, Number ymove), got " .. type(shapeType));
	end
end

function engine:Move(shapeType, name, dt)
	if (type(shapeType) == "string") then
		if (type(name) == "string") then
			local shape = objects[shapeType][name];
			if (shape.isStill == false) then
				shape.x = shape.x + shape.xMovement * dt;
				shape.y = shape.y + shape.yMovement * dt;
			end
		else
			error("Expected string value in DefineMovement(String shapeType, String name, Number xmove, Number ymove), got " .. type(name));
		end
	else
		error("Expected string value in DefineMovement(String shapeType, String name, Number xmove, Number ymove), got " .. type(shapeType));
	end
end

function engine:EditRectangle(name, drawModeV, xV, yV, widthV, heightV, colorV)
	local oldRect = objects.Rectangles[name];
	if (oldRect ~= nil) then
		drawModeV = drawModeV or oldRect.drawMode;
		xV        = xV or oldRect.x;
		yV        = yV or oldRect.y;
		widthV    = widthV or oldRect.width;
		heightV   = heightV or oldRect.height;
		colorV    = colorV or oldRect.color;
		
		objects.Rectangles[name] = {
			drawMode  = drawModeV;
			color     = colorV;
			
			x         = xV;
			y         = yV;
			
			width     = widthV;
			height    = heightV;
			
			isStill   = oldRect.isStill;
			xMovement = oldRect.xMovement;
			yMovement = oldRect.yMovement;
		};
	end
end

return engine;