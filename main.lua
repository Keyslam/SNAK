local Gamestate = require("lib.gamestate")

local Game = require("src.states.game")

Gamestate.registerEvents()
Gamestate.switch(Game, '3')
