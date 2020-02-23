local Class  = require("lib.middleclass")
local Image = require 'image'
local Map = require("src.map")
local Pellet = Class("Pellet")
local Quad = require 'image.quad'
local Util = require("src.util")
local Vector = require("lib.vector")

function Pellet:initialize(x, y, frequency)
	self.position = Vector(x, y)
	self.frequency = frequency

	Map.add(self, self.position.x, self.position.y)
end

function Pellet:consume(snake)
	snake:setFrequency(self.frequency)

	Map.remove(self, self.position.x, self.position.y)

	self.dead = true
end

function Pellet:draw()
	if (self.dead) then -- TEMP
		return
	end

	love.graphics.push("all")
	local x, y = Util.gridToScreen(self.position:unpack())
	love.graphics.setColor(self.frequency.r, self.frequency.g, self.frequency.b)
	love.graphics.draw(Image.tileset, Quad.pellet, x, y)
	love.graphics.pop()
end

return Pellet
