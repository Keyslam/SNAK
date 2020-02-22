local Class = require("lib.middleclass")
local Vector = require("lib.vector")

local Util = require("src.util")
local Map = require("src.map")

local Wall = Class("Wall")

function Wall:initialize(x, y, frequency)
	self.position = Vector(x, y)
	self.frequency = frequency

	Map.add(self, self.position.x, self.position.y)
end

function Wall:draw()
	if (self.frequency) then
		love.graphics.setColor(self.frequency.r, self.frequency.g, self.frequency.b, 1)
	else
		love.graphics.setColor(1, 1, 1, 1)
	end

	local x, y, w, h = Util.gridToScreenTile(self.position.x, self.position.y)
	love.graphics.rectangle("fill", x, y, w, h)
end

return Wall