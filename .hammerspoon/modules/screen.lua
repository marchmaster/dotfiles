local window = require "hs.window"
local hotkey = require "hs.hotkey"
local fnutils = require "hs.fnutils"
local geometry = require "hs.geometry"
local mouse = require "hs.mouse"
local layout = require 'hs.layout'
local alert = require 'hs.alert'
local screen = require 'hs.screen'

-- {{{ Multiple Screen Focus Switch
local SwitchScreenKey = '.';
--One hotkey should just suffice for dual-display setups as it will naturally
--cycle through both.
--A second hotkey to reverse the direction of the focus-shift would be handy
--for setups with 3 or more displays.

--Predicate that checks if a window belongs to a screen
local function isInScreen(sc, win)
    return win:screen() == sc
end

local function moveMouseToScreen(sc)
    local pt = geometry.rectMidPoint(sc:fullFrame())
    mouse.setAbsolutePosition(pt)
end

local function focusScreen(sc, moveMouse)
    --Get windows within screen, ordered from front to back.
    --If no windows exist, bring focus to desktop. Otherwise, set focus on
    --front-most application window.
    if not sc then return end

    local windows = fnutils.filter(
    window.orderedWindows(),
    fnutils.partial(isInScreen, sc))
    local windowToFocus = #windows > 0 and windows[1] or window.desktop()
    windowToFocus:focus()

    if moveMouse then moveMouseToScreen(sc) end
end

--Bring focus to next display/screen
hotkey.bind({'ctrl','cmd'}, SwitchScreenKey, function ()
    local focused = window.focusedWindow()
    if not focused then return end
    local sc = focused:screen()
    if not sc then return end
    focusScreen(window.focusedWindow():screen():next(), true)
end)

--Bring focus to previous display/screen
hotkey.bind({'ctrl','cmd'}, SwitchScreenKey, function()
    local focused = window.focusedWindow()
    if not focused then return end
    local sc = focused:screen()
    if not sc then return end
    focusScreen(window.focusedWindow():screen():previous(), true)
end)

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
