local Cartographer = require("lib.cartographer")
local Moonshine = require("lib.moonshine")

local Frequencies = require("src.frequencies")
local Gamestate = require("lib.gamestate")
local Map = require("src.map")
local Snake = require("src.snake")
local Pellet = require("src.pellet")
local Wall = require("src.wall")
local Background = require("src.background")

local Game = {}
Game.effect = Moonshine(Moonshine.effects.glow)
Game.effect.parameters = {
	glow = {
		min_luma = 0,
		strength = 4,
	},
}

function Game:enter(previous, levelName)
	self.levelName = levelName
	self.level = Cartographer.load("level/" .. levelName .. ".lua")

	Map.setup(self.level.width, self.level.height)
	Game.pellets = {}
	Game.walls   = {}

	for _, gid, gridX, gridY in self.level.layers.tiles:getTiles() do
		local x, y = gridX + 1, gridY + 1
		local type = self.level:getTileType(gid)
		if type == 'wall' then
			local color = self.level:getTileProperty(gid, 'color')
			table.insert(Game.walls, Wall(x, y, color and Frequencies[color]))
		end
	end
	for _, gid, gridX, gridY in self.level.layers.entities:getTiles() do
		local x, y = gridX + 1, gridY + 1
		local type = self.level:getTileType(gid)
		if type == 'snake' then
			Game.snake = Snake(x, y, Frequencies[1])
		elseif type == 'pellet' then
			local color = self.level:getTileProperty(gid, 'color')
			table.insert(Game.pellets, Pellet(x, y, Frequencies[color]))
		end
	end
end

function Game:update(dt)
	Background.update(dt)
end

function Game:leave()
	Map.clear()
end

function Game:keypressed(key)
	if (key == "w") then Game.snake:moveY(-1) end
	if (key == "a") then Game.snake:moveX(-1) end
	if (key == "s") then Game.snake:moveY( 1) end
	if (key == "d") then Game.snake:moveX( 1) end
end

local function DrawScene(dt)
	Game.snake:draw()

	Game.level.layers.tiles:draw()

	for _, pellet in ipairs(Game.pellets) do
		pellet:draw()
	end
end

function Game:draw(dt)
	--Background:draw()

	Game.effect.draw(DrawScene)

	love.graphics.print("Gamestate: Game", 0, 0)
end

function Game:keypressed(key)
	if (key == "w") then Game.snake:moveY(-1) end
	if (key == "a") then Game.snake:moveX(-1) end
	if (key == "s") then Game.snake:moveY( 1) end
	if (key == "d") then Game.snake:moveX( 1) end

	if key == 'r' then
		Gamestate.switch(self, self.levelName)
	end

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
