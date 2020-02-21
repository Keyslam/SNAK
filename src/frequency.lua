local Class = require("lib.middleclass")

local Frequency = Class("Frequency")

function Frequency:initialize(r, g, b)
	self.r = r
	self.g = g
	self.b = b
end

return Frequency