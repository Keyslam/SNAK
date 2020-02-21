local Frequencies = require("src.frequencies")
local Map = require("src.map")
local Snake = require("src.snake")

local Game = {}

function Game.enter()
	Map.setup(10, 10)

	Game.snake = Snake(Frequencies[1])
end

function Game:update(dt)
end

function Game:draw(dt)
	Game.snake:draw()

	love.graphics.print("Gamestate: Game", 0, 0)
end

function Game:keypressed(key)
	if (key == "w") then Game.snake:moveY(-1) end
	if (key == "a") then Game.snake:moveX(-1) end
	if (key == "s") then Game.snake:moveY( 1) end
	if (key == "d") then Game.snake:moveX( 1) end

	if (key == "f") then
		local i = 0
		for _i, f in ipairs(Frequencies) do
			if (Game.snake.frequency == f) then
				i = _i
			end
		end

		i = i + 1
		if (i > #Frequencies) then i = 1 end

		Game.snake:setFrequency(Frequencies[i])
	end
end

return Game