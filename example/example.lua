-- RefinedEngine2D
-- By: Giancarlo Forero

local refinedAPI = require("/RefinedEngine");

function love.load()
	love.window.setMode(500, 500);
	love.window.setTitle("RefinedEngine2D Test");
	
	-- Defines a new rectangle which is stored away in a dictionary
	-- refinedAPI:NewRectangle(RectangleName, DrawMode, StartingX, StartingY, Height, Width, Color);
	-- NOTE: If you leave something as nil it will switch to a default value
	refinedAPI:NewRectangle("TestRectangle", "fill", 20, 20, 50, 50, nil);
	
	-- We want this rectangle to move so we'll give it the movement attribute and set it's horizonal and vertical movement to 50
	-- refinedAPI:DefineMovement(ShapeContainer, ShapeName, HorizonalMovementSpeed, VerticalMovementSpeed);
	refinedAPI:DefineMovement("Rectangles", "TestRectangle", 50, 50);
end

function love.update(dt)

	-- Now we'll make the rectangle we made earlier move. It will use the movement attribute we assigned to it earlier to know which directions to move in
	-- We have to pass in dt (delta time) so that no matter the FPS it moves at the same speed for all users
	-- refinedAPI:Move(ShapeContainer, ShapeName, DeltaTime);
	refinedAPI:Move("Rectangles", "TestRectangle", dt);
end

function love.draw()
	-- This will display the rectangle we made earlier onto the screen
	-- It uses all the settings we originally defined for it.
	-- refinedAPI:DrawRectangle(RectangleName);
	refinedAPI:DrawRectangle("TestRectangle");
	
	-- This will edit the rectangle and replace the old settings with the new ones
	-- Never use refinedAPI:NewRectangle(...) to edit an already existing rectangle
	refinedAPI:EditRectangle("TestRectangle", "fill", 50, 50, 25, 25, {100, 100, 100, 255});
end