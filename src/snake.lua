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

Snake.waveformResolution = 100
Snake.animationSpeed = .5

function Snake:initialize(initalFrequency)
	self.head     = Segment(1, 1, initalFrequency)
	self.segments = {}

	self.frequency = initalFrequency

	for _ = 1, 10 do
		table.insert(self.segments, Segment(1, 1, initalFrequency))
	end

	self.animationPhase = 0
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
			elseif (obj.isInstanceOf and obj:isInstanceOf(Pellet)) then
				-- Consume pellet
				obj:consume(self)
			else
				-- Object can't be anything else
				return false
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

	return true
end

function Snake:update(dt)
	self.animationPhase = self.animationPhase + self.animationSpeed * dt
	while self.animationPhase > 1 do
		self.animationPhase = self.animationPhase - 1
	end
end

function Snake:draw()
	love.graphics.push 'all'
	local phase = 0
	-- iterate through each segment
	for i = 0, #self.segments - 1 do
		local points = {}
		-- workaround: segment 0 is the head
		local segmentA = self.segments[i] or self.head
		local segmentB = self.segments[i + 1]
		-- get the line segment formed by each segment's center
		local pointA = Vector(Util.gridToScreenTile((segmentA.position + Vector(.5, .5)):unpack()))
		local pointB = Vector(Util.gridToScreenTile((segmentB.position + Vector(.5, .5)):unpack()))
		-- get the normal vector of the line segment. this is the axis on which the line
		-- will be made Wavy
		local normalVector = (pointB - pointA):perpendicular():normalized()
		for fraction = 0, 1, 1 / self.waveformResolution do
			-- update the phase
			phase = phase + segmentA.frequency.frequency / self.waveformResolution
			while phase > 1 do phase = phase - 1 end
			local point = Util.lerp(pointA, pointB, fraction)
			point = point + normalVector * 8 * math.sin((phase + self.animationPhase) * 2 * math.pi)
			table.insert(points, point.x)
			table.insert(points, point.y)
		end
		love.graphics.setColor(segmentA.frequency.r, segmentA.frequency.g, segmentA.frequency.b)
		love.graphics.line(points)
	end
	love.graphics.pop()
end

return Snake
