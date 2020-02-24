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
	self.animationPhase = love.math.random()
	self.animationSpeed = Util.lerp(1/3, 1, love.math.random())

	Map.add(self, self.position.x, self.position.y)
end

function Pellet:consume(snake)
	if (self.frequency) then
		snake:setFrequency(self.frequency)
	end

	Map.remove(self, self.position.x, self.position.y)

	self.dead = true
end

function Pellet:update(dt)
	self.animationPhase = self.animationPhase + self.animationSpeed * dt
	while self.animationPhase >= 1 do
		self.animationPhase = self.animationPhase - 1
	end
end

function Pellet:draw()
	if (self.dead) then -- TEMP
		return
	end

	love.graphics.push("all")
	local x, y = Util.gridToScreen(self.position:unpack())

	if (self.frequency) then
		love.graphics.setColor(self.frequency.r, self.frequency.g, self.frequency.b)
	else
		love.graphics.setColor(1, 1, 1, 1)
	end
	love.graphics.draw(Image.tileset, Quad.pellet, x, y + 4 * math.sin(self.animationPhase * 2 * math.pi))
	love.graphics.pop()
end

return Pellet
