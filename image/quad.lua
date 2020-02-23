local image = require 'image'

local sw, sh = image.tileset:getDimensions()
return {
	snakeBody = love.graphics.newQuad(4*64, 0, 64, 64, sw, sh),
	snakeHead = love.graphics.newQuad(4*64, 64, 64, 64, sw, sh),
	pellet = love.graphics.newQuad(3*64, 2*64, 64, 64, sw, sh),
}
