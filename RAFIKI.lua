-- The function get_name() should return a single string that is the name of the puzzle.
--
function get_name()
	return "Favorite Dev"
end

-- The function get_description() should return an array of strings, where each string is
-- a line of description for the puzzle. The text you return from get_description() will 
-- be automatically formatted and wrapped to fit inside the puzzle information box.
--
function get_description()
	return { "Write the name of your favorite game dev." }
end

-- The function get_streams() should return an array of streams. Each stream is described
-- by an array with exactly four values: a STREAM_* value, a name, a position, and an array
-- of integer values between -999 and 999 inclusive.
--
-- STREAM_INPUT: An input stream containing up to 39 numerical values.
-- STREAM_OUTPUT: An output stream containing up to 39 numerical values.
-- STREAM_IMAGE: An image output stream, containing exactly 30*18 numerical values between 0
--               and 4, representing the full set of "pixels" for the target image.
--
-- NOTE: Arrays in Lua are implemented as tables (dictionaries) with integer keys that start
--       at 1 by convention. The sample code below creates an input array of 39 random values
--       and an output array that doubles all of the input values.
--
-- NOTE: To generate random values you should use math.random(). However, you SHOULD NOT seed
--       the random number generator with a new seed value, as that is how TIS-100 ensures that
--       the first test run is consistent for all users, and thus something that allows for the
--       comparison of cycle scores.
--
-- NOTE: Position values for streams should be between 0 and 3, which correspond to the far
--       left and far right of the TIS-100 segment grid. Input streams will be automatically
--       placed on the top, while output and image streams will be placed on the bottom.
--
function get_streams()
    image = {}

    input1 = {}
    input2 = {}
    input3 = {}
    input4 = {}

    line = 1;

    index = 1;

    activeInput = input1;

    for i = 1,30*18 do
            image[i] = 0
    end

    --Line 6
    paintPixel(1, 6, 1);
    paintPixel(2, 6, 1);
    paintPixel(3, 6, 1);
    paintPixel(7, 6, 1);
    paintPixel(8, 6, 1);
    paintPixel(11, 6, 1);
    paintPixel(12, 6, 1);
    paintPixel(13, 6, 1);
    paintPixel(14, 6, 1);
    paintPixel(16, 6, 1);
    paintPixel(17, 6, 1);
    paintPixel(18, 6, 1);
    paintPixel(20, 6, 1);
    paintPixel(23, 6, 1);
    paintPixel(25, 6, 1);
    paintPixel(26, 6, 1);
    paintPixel(27, 6, 1);

    --Line 7
    paintPixel(1, 7, 1);
    paintPixel(4, 7, 1);
    paintPixel(6, 7, 1);
    paintPixel(9, 7, 1);
    paintPixel(11, 7, 1);
    paintPixel(17, 7, 1);
    paintPixel(20, 7, 1);
    paintPixel(22, 7, 1);
    paintPixel(26, 7, 1);

    --Line 8
    paintPixel(1, 8, 1);
    paintPixel(2, 8, 1);
    paintPixel(3, 8, 1);
    paintPixel(6, 8, 1);
    paintPixel(7, 8, 1);
    paintPixel(8, 8, 1);
    paintPixel(9, 8, 1);
    paintPixel(11, 8, 1);
    paintPixel(12, 8, 1);
    paintPixel(13, 8, 1);
    paintPixel(17, 8, 1);
    paintPixel(20, 8, 1);
    paintPixel(21, 8, 1);
    paintPixel(26, 8, 1);


    --Line 9
    paintPixel(1, 9, 1);
    paintPixel(3, 9, 1);
    paintPixel(6, 9, 1);
    paintPixel(9, 9, 1);
    paintPixel(11, 9, 1);
    paintPixel(17, 9, 1);
    paintPixel(20, 9, 1);
    paintPixel(22, 9, 1);
    paintPixel(26, 9, 1);

    --Line 10
    paintPixel(1, 10, 1);
    paintPixel(4, 10, 1);
    paintPixel(6, 10, 1);
    paintPixel(9, 10, 1);
    paintPixel(11, 10, 1);
    paintPixel(16, 10, 1);
    paintPixel(17, 10, 1);
    paintPixel(18, 10, 1);
    paintPixel(20, 10, 1);
    paintPixel(23, 10, 1);
    paintPixel(25, 10, 1);
    paintPixel(26, 10, 1);
    paintPixel(27, 10, 1);

	return {
		{ STREAM_INPUT, "IN.A", 0, input1 },
		{ STREAM_INPUT, "IN.B", 1, input2 },
		--{ STREAM_INPUT, "IN.C", 2, input3 },
		--{ STREAM_INPUT, "IN.D", 3, input4 },
		{STREAM_IMAGE, "IMAGE", 2, image},
	}
end

function paintPixel(x, y, color)
	image[x + 1 + y * 30] = color;
	if y != line then
		line = y;
		activeInput[index] = -1;
		index = index + 1;
		checkEndOfInput();
	end

	activeInput[index] = x;

	index = index +1;

	checkEndOfInput();
end


function checkEndOfInput()
	if index == 38 then
		activeInput[index] = 0;
		index = 1;

		if activeInput == input1 then
			activeInput = input2;
		elseif activeInput == input2 then
			activeInput = input3;
		elseif activeInput == input3 then
			activeInput = input4
		end
	end
end

-- The function get_layout() should return an array of exactly 12 TILE_* values, which
-- describe the layout and type of tiles found in the puzzle.
--
-- TILE_COMPUTE: A basic execution node (node type T21).
-- TILE_MEMORY: A stack memory node (node type T30).
-- TILE_DAMAGED: A damaged execution node, which acts as an obstacle.
--
function get_layout()
	return { 
		TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
		TILE_COMPUTE, 	TILE_COMPUTE,	TILE_COMPUTE, 	TILE_COMPUTE,
	}
end

--[[
    --A
    paintPixel(1, 5, 1);
    paintPixel(1, 4, 1);
    paintPixel(1, 3, 1);
    paintPixel(1, 2, 1);

    paintPixel(4, 5, 1);
    paintPixel(4, 4, 1);
    paintPixel(4, 3, 1);
    paintPixel(4, 2, 1);

    paintPixel(2, 1, 1);
    paintPixel(3, 1, 1);

    paintPixel(2, 3, 1);
    paintPixel(3, 3, 1);

    --L
    paintPixel(6, 5, 1);
    paintPixel(6, 4, 1);
    paintPixel(6, 3, 1);
    paintPixel(6, 2, 1);
    paintPixel(6, 1, 1);

    paintPixel(7, 5, 1);
    paintPixel(8, 5, 1);

    --V
    paintPixel(10, 4, 1);
    paintPixel(10, 3, 1);
    paintPixel(10, 2, 1);
    paintPixel(10, 1, 1);

    paintPixel(13, 4, 1);
    paintPixel(13, 3, 1);
    paintPixel(13, 2, 1);
    paintPixel(13, 1, 1);

    paintPixel(11, 4, 1);
    paintPixel(12, 4, 1);

    paintPixel(11, 5, 1);
    paintPixel(12, 5, 1);

    --A
    paintPixel(15, 5, 1);
    paintPixel(15, 4, 1);
    paintPixel(15, 3, 1);
    paintPixel(15, 2, 1);

    paintPixel(18, 5, 1);
    paintPixel(18, 4, 1);
    paintPixel(18, 3, 1);
    paintPixel(18, 2, 1);

    paintPixel(16, 1, 1);
    paintPixel(17, 1, 1);

    paintPixel(16, 3, 1);
    paintPixel(17, 3, 1);

    --R
    paintPixel(20, 5, 1);
    paintPixel(20, 4, 1);
    paintPixel(20, 3, 1);
    paintPixel(20, 2, 1);
    paintPixel(20, 1, 1);

    paintPixel(21, 1, 1);
    paintPixel(22, 1, 1);

    paintPixel(21, 3, 1);
    paintPixel(22, 3, 1);

    paintPixel(23, 2, 1);

    paintPixel(22, 4, 1);
    paintPixel(23, 5, 1);

    --O
    paintPixel(25, 4, 1);
    paintPixel(25, 3, 1);
    paintPixel(25, 2, 1);

    paintPixel(28, 4, 1);
    paintPixel(28, 3, 1);
    paintPixel(28, 2, 1);

    paintPixel(26, 1, 1);
    paintPixel(27, 1, 1);

    paintPixel(26, 5, 1);
    paintPixel(27, 5, 1);

    --<3
    paintPixel(11, 7, 4);
    paintPixel(12, 7, 4);
    paintPixel(13, 7, 4);
    paintPixel(17, 7, 4);
    paintPixel(18, 7, 4);
    paintPixel(19, 7, 4);

    paintPixel(10, 8, 4);
    paintPixel(14, 8, 4);
    paintPixel(16, 8, 4);
    paintPixel(20, 8, 4);

    paintPixel(15, 9, 4);

    paintPixel(9, 9, 4);
    paintPixel(9, 10, 4);
    paintPixel(9, 11, 4);

    paintPixel(21, 9, 4);
    paintPixel(21, 10, 4);
    paintPixel(21, 11, 4);

    paintPixel(10, 12, 4);
    paintPixel(11, 13, 4);
    paintPixel(12, 14, 4);
    paintPixel(13, 15, 4);
    paintPixel(14, 16, 4);
    paintPixel(15, 17, 4);

    paintPixel(16, 16, 4);
    paintPixel(17, 15, 4);
    paintPixel(18, 14, 4);
    paintPixel(19, 13, 4);
    paintPixel(20, 12, 4);
	
	]]--