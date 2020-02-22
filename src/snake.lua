local Vector = require("lib.vector")
local Class  = require("lib.middleclass")

local Util = require("src.util")
local Map = require("src.map")
local Pellet = require("src.pellet")

local Segment = Class("SnakeSegment")

function Segment:initialize(x, y, frequency)
	self.position  = Vector(x, y)
	self.frequency = frequency

	Map.add(self, self.position.x, self.position.y)
end

function Segment:setFrequency(frequency)
	self.frequency = frequency
end

function Segment:moveTo(x, y)
	if (self.position.x ~= x or self.position.y ~= y) then
		Map.remove(self, self.position.x, self.position.y)

		self.position.x = x
		self.position.y = y

		Map.add(self, self.position.x, self.position.y)
	end
end

local Snake = Class("Snake")

function Snake:initialize(x, y, initalFrequency)
	self.head     = Segment(x, y, initalFrequency)
	self.segments = {}

	self.frequency = initalFrequency

	for _ = 1, 10 do
		table.insert(self.segments, Segment(x, y, initalFrequency))
	end
end

function Snake:setFrequency(frequency)
	self.frequency = frequency
	self.head:setFrequency(frequency)
end

function Snake:moveX(dx)
	self:move(dx, 0)
end

function Snake:moveY(dy)
	self:move(0, dy)
end

function Snake:move(dx, dy)
	local newX = self.head.position.x + dx
	local newY = self.head.position.y + dy

	if (not Map.inBounds(newX, newY)) then
		return false
	end

	-- Collision
	do
		local objs = Map.get(newX, newY)
		for _, obj in ipairs(objs.objects) do
			if (obj.isInstanceOf and obj:isInstanceOf(Segment)) then
				-- Object can't be segment of same frequency
				if (obj.frequency == self.head.frequency) then
					return false
				end

				-- Object can't be first segment
				if (self.segments[1]) then
					if (obj == self.segments[1]) then
						return false
					end
				end
			end
		end
	end

	-- Move segments to next segment
	for i = #self.segments, 2, -1 do
		local segment = self.segments[i]
		local nextSegment = self.segments[i - 1]

		segment:moveTo(nextSegment.position.x, nextSegment.position.y)
		segment:setFrequency(nextSegment.frequency)
	end

	-- Move first segment to head
	if (self.segments[1]) then
		self.segments[1]:moveTo(self.head.position.x, self.head.position.y)
		self.segments[1]:setFrequency(self.head.frequency)
	end

	-- Move head
	self.head:moveTo(newX, newY)

	-- eat pellets
	do
		local objs = Map.get(newX, newY)
		for _, obj in ipairs(objs.objects) do
			if (obj.isInstanceOf and obj:isInstanceOf(Pellet)) then
				obj:consume(self)
			end
		end
	end

	return true
end

function Snake:draw()
	love.graphics.push("all")

	do
		local f = self.head.frequency
		love.graphics.setColor(f.r, f.g, f.b, 1)

		local x, y, w, h = Util.gridToScreenTile(self.head.position.x, self.head.position.y)
		love.graphics.rectangle("fill", x, y, w, h)
	end

	do
		love.graphics.setColor(1, 1, 1, 0.5)

		for i, segment in ipairs(self.segments) do
			local a = 1 - (i / (#self.segments + 1))
			local f = segment.frequency
			love.graphics.setColor(f.r, f.g, f.b, a)

			local x, y, w, h = Util.gridToScreenTile(segment.position.x, segment.position.y)
			love.graphics.rectangle("fill", x, y, w, h)
		end
	end

	love.graphics.pop()
end

return Snake
