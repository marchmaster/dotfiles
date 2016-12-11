local grid = require 'hs.grid'
local hotkey = require 'hs.hotkey'

------------- Multiple Monitor Management --------------- {{{
-- Defines for window grid
--grid.GRIDWIDTH = 3
--grid.GRIDHEIGHT = 3
--grid.MARGINX = 0
--grid.MARGINY = 0

-- Hotkeys to interact with the window grid
hotkey.bind(hyper, ';', grid.show)
