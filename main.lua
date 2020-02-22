local Gamestate = require("lib.gamestate")

local Game = require("src.states.game")

function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(Game, 'intersect')
end

function love.keypressed(key)
	if key == 'escape' then love.event.quit() end
	if key == 'r' and love.keyboard.isDown 'lctrl' then
		love.event.quit 'restart'
	end
end
