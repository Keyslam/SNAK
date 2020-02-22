local Moonshine = require("lib.moonshine")

local Background = {}
Background.canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
Background.shader = love.graphics.newShader("src/backgroundShader.glsl")
Background.time = 0

function Background.update(dt)
	Background.time = Background.time + dt / 10
end

function Background.draw()
	love.graphics.setColor(176 / 255, 66 / 255, 1, 1)

	love.graphics.setCanvas(Background.canvas)

	love.graphics.rectangle("fill", 0, love.graphics.getHeight() / 2 - 200, love.graphics.getWidth(), 50)
	love.graphics.rectangle("fill", 0, love.graphics.getHeight() / 2 - 50, love.graphics.getWidth(), 100)
	love.graphics.rectangle("fill", 0, love.graphics.getHeight() / 2 + 150, love.graphics.getWidth(), 25)

	love.graphics.setCanvas()

	love.graphics.setShader(Background.shader)
	Background.shader:send("time", Background.time)

	love.graphics.draw(Background.canvas)

	love.graphics.setShader()

	love.graphics.setColor(1, 1, 1, 1)
end

return Background