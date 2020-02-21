local Util = {}

function Util.gridToScreen(x, y)
	local sx = (x - 1) * 32 + 1
	local sy = (y - 1) * 32 + 1

	return sx, sy, 30, 30
end

return Util