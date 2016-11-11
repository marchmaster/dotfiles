local window = require "hs.window"
local hotkey = require "hs.hotkey"
local fnutils = require "hs.fnutils"
local geometry = require "hs.geometry"
local mouse = require "hs.mouse"
local layout = require 'hs.layout'
local alert = require 'hs.alert'

------------- Multiple Screen Layouts --------------- {{{
-- find screen name from (Macbook - System Preferences - Displays - Color - Display profile)

--  Format reminder:
--      {"App name", "Window name", "Display Name", "unitrect", "framerect", "fullframerect"},
--      geometry.rect('X','Y','Width','Height')
--      geometry.unitrect(X%,Y%,Width%,Height%)

-- Macbook window layout
    local laptopScreen = "Color LCD"
    local windowLayout = {
        {"Google Chrome",  nil,   laptopScreen, hs.layout.left50,    nil, nil},
        {"iTerm2",  nil,          laptopScreen, hs.layout.right50,   nil, nil},
        {"iTunes",  "iTunes",     laptopScreen, hs.layout.maximized, nil, nil},
        {"iTunes",  "MiniPlayer", laptopScreen, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
    }

-- Only one screen
hotkey.bind(hyper, '5', function() layout.apply(windowLayout) alert.show("Macbook Layout") end)
-- Multiple screens
--hotkey.bind(hyper, '6', function() layout.apply(layout_multiple) alert.show("U2414H + Macbook Layout") end)
--}}}
