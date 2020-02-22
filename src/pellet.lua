local Class  = require("lib.middleclass")
local Vector = require("lib.vector")

local Util = require("src.util")
local Map = require("src.map")

local Pellet = Class("Pellet")

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
	local x, y = Util.gridToScreen((self.position + Vector(.5, .5)):unpack())
	love.graphics.setColor(self.frequency.r, self.frequency.g, self.frequency.b)
	love.graphics.circle('fill', x, y, 8, 64)
	love.graphics.pop()
end

return Pellet
