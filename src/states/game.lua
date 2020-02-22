local Frequencies = require("src.frequencies")
local Map = require("src.map")
local Snake = require("src.snake")
local Pellet = require("src.pellet")

local Game = {}

function Game.enter()
	Map.setup(20, 20)

	Game.snake = Snake(Frequencies[1])
	Game.pellets = {}

	for i = 1, 20 do
		local pellet = Pellet(love.math.random(1, 20), love.math.random(1, 20))
		table.insert(Game.pellets, pellet)
	end
end

function Game:update(dt)
	Game.snake:update(dt)
end

function Game:draw(dt)
	Game.snake:draw()

	for _, pellet in ipairs(Game.pellets) do
		pellet:draw()
	end

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
