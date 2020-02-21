local Map   = require("src.map")
local Snake = require("src.snake")

local Game = {}

function Game.enter()
	Map.setup(10, 10)

	Game.snake = Snake()
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
end

return Game