local Util = {}

function Util.gridToScreen(x, y)
	local sx = (x - 1) * 64
	local sy = (y - 1) * 64

	return sx, sy, 64, 64
end

function Util.gridToScreenTile(x, y)
	local sx = (x - 1) * 64 + 4
	local sy = (y - 1) * 64 + 4

	return sx, sy, 56, 56
end

return Util