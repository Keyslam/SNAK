local Util = {}

function Util.gridToScreen(x, y)
	local sx = (x - 1) * 32
	local sy = (y - 1) * 32

	return sx, sy, 32, 32
end

function Util.gridToScreenTile(x, y)
	local sx = (x - 1) * 32 + 2
	local sy = (y - 1) * 32 + 2

	return sx, sy, 28, 28
end

return Util