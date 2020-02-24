function love.conf(t)
	t.version      = "11.3"
	t.console      = true
	t.gammacorrect = true

	t.window.title  = "SNAK'"
	t.window.icon   = nil
	t.window.width  = 640
	t.window.height = 640
	t.window.vsync  = 1
	t.window.msaa   = 4

	t.modules.thread = false
	t.modules.touch  = false
	t.modules.video  = false
end
