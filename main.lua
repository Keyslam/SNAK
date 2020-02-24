currentLevel = 1

local Game = require("src.states.game")
local Gamestate = require("lib.gamestate")
local Timer = require("lib.timer")

function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(Game)
end

function love.update(dt)
	Timer.update(dt)
end

function love.keypressed(key)
	if key == 'escape' then love.event.quit() end
	if key == 'r' and love.keyboard.isDown 'lctrl' then
		love.event.quit 'restart'
	end
end
