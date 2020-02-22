local Frequency = require("src.frequency")

local Frequencies = {
	Frequency(1, 0, 0, 432),
	Frequency(0, 1, 0, 432*2),
	Frequency(0, 0, 1, 432/2),
}

return Frequencies
