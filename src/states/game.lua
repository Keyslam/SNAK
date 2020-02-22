local Cartographer = require("lib.cartographer")
local Frequencies = require("src.frequencies")
local Gamestate = require("lib.gamestate")
local Map = require("src.map")
local Snake = require("src.snake")
local Pellet = require("src.pellet")
local Wall = require("src.wall")

local Game = {}

function Game:enter(previous, levelName)
	self.levelName = levelName
	local level = Cartographer.load("level/" .. levelName .. ".lua")

	Map.setup(level.width, level.height)
	Game.pellets = {}
	Game.walls   = {}

	for _, gid, gridX, gridY in level.layers.tiles:getTiles() do
		local x, y = gridX + 1, gridY + 1
		local type = level:getTileType(gid)
		if type == 'snake' then
			Game.snake = Snake(x, y, Frequencies[1])
		elseif type == 'pellet' then
			local color = level:getTileProperty(gid, 'color')
			table.insert(Game.pellets, Pellet(x, y, Frequencies[color]))
		elseif type == 'wall' then
			local color = level:getTileProperty(gid, 'color')
			table.insert(Game.walls, Wall(x, y, color and Frequencies[color]))
		end
	end
end

function Game:update(dt)
end

function Game:keypressed(key)
	if (key == "w") then Game.snake:moveY(-1) end
	if (key == "a") then Game.snake:moveX(-1) end
	if (key == "s") then Game.snake:moveY( 1) end
	if (key == "d") then Game.snake:moveX( 1) end

	if key == 'r' then
		Gamestate.switch(self, self.levelName)
	end
end

function Game:leave()
	Map.clear()
end

function Game:draw(dt)
	Game.snake:draw()

	for _, pellet in ipairs(Game.pellets) do
		pellet:draw()
	end

	for _, wall in ipairs(Game.walls) do
		wall:draw()
	end
end

return Game
