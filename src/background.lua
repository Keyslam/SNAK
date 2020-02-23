local Background = {
	phase = 0,
}

function Background.update(dt)
	Background.phase = Background.phase + .01 * dt
	while Background.phase >= 1 do
		Background.phase = Background.phase - 1
	end
end

function Background.draw()
	love.graphics.push 'all'
	love.graphics.setColor(115/255, 185/255, 196/255, .025)
	love.graphics.setLineWidth(4)
	local points = {}
	local phase = 0
	for x = love.graphics.getWidth(), 0, -1 do
		phase = phase + .29 + .07 * math.sin(x / 10) + .03 * math.sin(x / 19)
		while phase >= 1 do
			phase = phase - 1
		end
		local y = love.graphics.getHeight()/2 + 300 * math.sin((phase - Background.phase) * 2 * math.pi)
		table.insert(points, x)
		table.insert(points, y)
	end
	love.graphics.line(points)
	love.graphics.pop()
end

return Background
