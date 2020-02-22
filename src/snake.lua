local Vector = require("lib.vector")
local Class  = require("lib.middleclass")

local Util = require("src.util")
local Map = require("src.map")
local Pellet = require("src.pellet")
local Wall = require("src.wall")

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
end

function Snake:setFrequency(frequency)
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
	local atePellet = false
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
			elseif (obj.isInstanceOf and obj:isInstanceOf(Wall)) then
				-- Wall doesn't have frequency, is solid
				if (not obj.frequency) then
					return false
				end

				-- Can only go through different frequencies
				if (obj.frequency == self.head.frequency) then
					return false
				end
			elseif (obj.isInstanceOf and obj:isInstanceOf(Pellet)) then
				atePellet = obj
			end
		end
	end

	local tail = self.segments[#self.segments] or self.head
	local previousTailX, previousTailY = tail.position:unpack()
	local previousTailFrequency = tail.frequency

	-- Move segments to next segment
	for i = #self.segments, 2, -1 do
		local segment = self.segments[i]
		local nextSegment = self.segments[i - 1]

		segment:moveTo(nextSegment.position.x, nextSegment.position.y)
		if atePellet then segment:setFrequency(nextSegment.frequency) end
	end

	-- Move first segment to head
	if (self.segments[1]) then
		self.segments[1]:moveTo(self.head.position.x, self.head.position.y)
		if atePellet then self.segments[1]:setFrequency(self.head.frequency) end
	end

	-- Move head
	self.head:moveTo(newX, newY)

	-- if we collided with a pellet...
	if atePellet then
		atePellet:consume(self) -- eat the pellet
		table.insert(self.segments, Segment(previousTailX, previousTailY, previousTailFrequency))
	end

	return true
end

function Snake:draw()
	love.graphics.push("all")

	
	do
		love.graphics.setColor(1, 1, 1, 0.5)

		for i = #self.segments, 1, -1 do
			local segment = self.segments[i]
			
			local a = 1 - (i / (#self.segments + 1))
			a = 1 -- TEMP
			local f = segment.frequency
			love.graphics.setColor(f.r, f.g, f.b, a)

			local x, y, w, h = Util.gridToScreenTile(segment.position.x, segment.position.y)
			love.graphics.rectangle("fill", x, y, w, h)
		end
	end

	do
		local f = self.head.frequency
		love.graphics.setColor(f.r, f.g, f.b, 1)

		local x, y, w, h = Util.gridToScreenTile(self.head.position.x, self.head.position.y)
		love.graphics.rectangle("fill", x, y, w, h)
	end


	love.graphics.pop()
end

return Snake
