local Class  = require("lib.middleclass")
local Vector = require("lib.vector")

local Frequencies = require("src.frequencies")
local Util = require("src.util")
local Map = require("src.map")

local Pellet = Class("Pellet")

function Pellet:initialize(x, y)
	self.position = Vector(x, y)

	Map.add(self, self.position.x, self.position.y)
end

function Pellet:consume(snake)
	snake:setFrequency(Frequencies[love.math.random(1, #Frequencies)])

	Map.remove(self, self.position.x, self.position.y)

	self.dead = true
end

function Pellet:draw()
	if (self.dead) then -- TEMP
		return
	end

	do
		local x, y, w, h = Util.gridToScreen(self.position.x, self.position.y)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.rectangle("fill", x, y, w, h)
	end

	do
		local x, y, w, h = Util.gridToScreenTile(self.position.x, self.position.y)
		love.graphics.setColor(0.62, 0.30, 0.71, 1)
		love.graphics.rectangle("fill", x, y, w, h)
	end
end

return Pellet