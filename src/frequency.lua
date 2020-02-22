local Class = require("lib.middleclass")

local Frequency = Class("Frequency")

function Frequency:initialize(r, g, b, frequency)
	self.r = r
	self.g = g
	self.b = b
	self.frequency = frequency
end

return Frequency
