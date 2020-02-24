local Background = require("src.background")
local Cartographer = require("lib.cartographer")
local Frequencies = require("src.frequencies")
local Gamestate = require("lib.gamestate")
local Level = require("level")
local Map = require("src.map")
local Moonshine = require("lib.moonshine")
local Pellet = require("src.pellet")
local Snake = require("src.snake")
local Timer = require("lib.timer")
local Wall = require("src.wall")

local Game = {}

Game.blur = Moonshine(Moonshine.effects.fastgaussianblur)
Game.blur.parameters = {
	fastgaussianblur = {
		taps = 35,
	},
}
Game.blurCanvas = love.graphics.newCanvas()
Game.postEffect = Moonshine(Moonshine.effects.filmgrain)
	.chain(Moonshine.effects.vignette)
Game.postEffect.parameters = {
	filmgrain = {
		opacity = 1,
	},
	vignette = {
		radius = 1,
		softness = 1,
		opacity = .15,
	},
}

function Game:enter(previous)
	self.level = Cartographer.load("level/" .. Level[currentLevel] .. ".lua")

	Map.setup(self.level.width, self.level.height)
	Game.pellets      = {}
	Game.walls        = {}
	Game.levelCleared = false

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

	-- cosmetic
	Game.levelEnterAnimationProgress = 0
	Game.levelClearAnimationCanvas   = love.graphics.newCanvas(10, 10)
	Game.levelClearAnimationProgress = 0
	Game.levelClearAnimationCanvas:setFilter 'nearest'
	Timer.tween(1, self, {levelEnterAnimationProgress = 1})
end

function Game:areAllPelletsEaten()
	for _, pellet in ipairs(self.pellets) do
		if not pellet.dead then return false end
	end
	return true
end

function Game:update(dt)
	Background.update(dt)
	for _, pellet in ipairs(Game.pellets) do
		pellet:update(dt)
	end
	if not self.levelCleared then
		if self:areAllPelletsEaten() then
			currentLevel = currentLevel + 1
			self.levelCleared = true
			Timer.tween(2, self, {levelClearAnimationProgress = 1}, 'linear', function()
				Gamestate.switch(self)
			end)
		end
	end
end

function Game:leave()
	Map.clear()
end

local function RenderLevelClearAnimation()
	love.graphics.push 'all'
	love.graphics.setCanvas(Game.levelClearAnimationCanvas)
	love.graphics.clear()
	love.graphics.circle('fill', 5, 5, Game.levelClearAnimationProgress * 8, 64)
	love.graphics.pop()
end

local function DrawScene()
	Background:draw()
	Game.snake:draw()
	Game.level.layers.tiles:draw()
	for _, pellet in ipairs(Game.pellets) do
		pellet:draw()
	end
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Game.levelClearAnimationCanvas, 0, 0, 0, 64, 64)
	love.graphics.setColor(1, 1, 1, 1 - Game.levelEnterAnimationProgress)
	love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

local function DrawPost()
	DrawScene()
	love.graphics.push 'all'
	love.graphics.setBlendMode 'add'
	love.graphics.setColor(1, 1, 1, .25)
	love.graphics.draw(Game.blurCanvas)
	love.graphics.pop()
end

function Game:draw()
	RenderLevelClearAnimation()
	love.graphics.push 'all'
	love.graphics.setCanvas(Game.blurCanvas)
	love.graphics.clear()
	Game.blur.draw(DrawScene)
	love.graphics.pop()
	Game.postEffect.draw(DrawPost)
end

function Game:keypressed(key)
	if not self.levelCleared then
		if (key == "w") then Game.snake:moveY(-1) end
		if (key == "a") then Game.snake:moveX(-1) end
		if (key == "s") then Game.snake:moveY( 1) end
		if (key == "d") then Game.snake:moveX( 1) end
	end

	if key == 'r' then
		Gamestate.switch(self)
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
