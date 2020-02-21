local List = require("lib.list")

local Map = {
	width  = 0,
	height = 0,

	data = {},
}

function Map.setup(width, height)
	Map.width  = width
	Map.height = height

	for x = 1, width do
		Map.data[x] = {}
		for y = 1, height do
			Map.data[x][y] = List()
		end
	end
end

function Map.inBoundsX(x)
	if (x < 1 or x > Map.width) then
		return false
	end

	return true
end

function Map.inBoundsY(y)
	if (y < 1 or y > Map.height) then
		return false
	end

	return true
end

function Map.inBounds(x, y)
	return Map.inBoundsX(x) and Map.inBoundsY(y)
end

function Map.isFree(x, y)
	return Map.data[x][y].size == 0
end

function Map.isTaken(x, y)
	return Map.data[x][y].size ~= 0
end

function Map.add(obj, x, y)
	Map.data[x][y]:add(obj)
end

function Map.remove(obj, x, y)
	Map.data[x][y]:remove(obj)
end

function Map.get(x, y)
	return Map.data[x][y]
end

function Map.clear()
	Map.width  = 0
	Map.height = 0

	Map.data = {}
end

return Map