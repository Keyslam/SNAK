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
			Map.data[x][y] = nil
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
	return Map[x][y] == nil
end

function Map.isTaken(x, y)
	return Map[x][y] ~= nil
end

function Map.set(obj, x, y)
	Map[x][y] = obj
end

function Map.get(x, y)
	return Map[x][y]
end

function Map.clear()
	Map.width  = 0
	Map.height = 0

	Map.data = {}
end

return Map