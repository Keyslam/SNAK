local Map = require("src.map")

local Game = {}

function Game:enter()
	Map.setup(10, 10)
end

function Game:update(dt)
end

function Game:draw(dt)
	love.graphics.print("Gamestate: Game", 0, 0)
end

return Game