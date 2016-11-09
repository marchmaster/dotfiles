require "hs.application"

local hotkey = require 'hs.hotkey'
local window = require 'hs.window'
local layout = require 'hs.layout'
local alert = require 'hs.alert'
local hints = require 'hs.hints'
local grid = require 'hs.grid'
local geometry = require 'hs.geometry'

---- hyper [ for left one half window
hotkey.bind(hyper, '[', function() window.focusedWindow():moveToUnit(layout.left50) end)

-- hyper ] for right one half window
hotkey.bind(hyper, ']', function() window.focusedWindow():moveToUnit(layout.right50) end)

-- super n for Left Monitor
hs.hotkey.bind(hyper, 'o', function() 
    local w = hs.window.focusedWindow()
    if not w then 
        return
    end
    local s = w:screen():toWest()
    if s then
        w:moveToScreen(s)
    end
end)

-- super p for Right Monitor
hs.hotkey.bind(hyper, 'p', function() 
    local w = hs.window.focusedWindow()
    if not w then 
        return
    end
    local s = w:screen():toEast()
    if s then
        w:moveToScreen(s)
    end
end)

-- hyper tab for fullscreen
--hotkey.bind(hyper, 'tab', function() window.focusedWindow():toggleFullScreen() end)
--hotkey.bind(hyper, 'tab', function()
    --if window.focusedWindow() then
        --local win = window.focusedWindow()
        --local f = win:frame()
        --local screen = win:screen()
        --local max = screen:frame()

        --f.x = max.x
        --f.y = max.y
        --f.w = max.w
        --f.h = max.h
        --win:setFrame(f)
    --else
        --alert.show("No active window")
    --end
--end)

hotkey.bind(hyper, '\\', function() toggle_window_maximized() end)
-- Defines for window maximize toggler
local frameCache = {}
-- Toggle a window between its normal size, and being maximized
function toggle_window_maximized()
    local win = window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:maximize()
    end
end

------------- Multiple Monitor Management --------------- {{{
-- Defines for window grid
--grid.GRIDWIDTH = 3
--grid.GRIDHEIGHT = 3
--grid.MARGINX = 0
--grid.MARGINY = 0
-- Hotkeys to interact with the window grid
hotkey.bind(hyper, '1', grid.show)
hotkey.bind(hyper, '2', grid.pushWindowLeft)
hotkey.bind(hyper, '3', grid.pushWindowRight)
hotkey.bind(hyper, '4', grid.pushWindowUp)
hotkey.bind(hyper, '5', grid.pushWindowDown)

------------- Mouse Hightlight --------------- {{{
hotkey.bind(hyper, '0', function() mouseHighlight() end)
-- draw a bright red circle around the mouse pointer for a few seconds
function mouseHighlight()
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    mousepoint = hs.mouse.getAbsolutePosition()
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:bringToFront(true)
    mouseCircle:show(0.5)

    mouseCircleTimer = hs.timer.doAfter(3, function()
        mouseCircle:hide(0.5)
        hs.timer.doAfter(0.6, function() mouseCircle:delete() end)
    end)
end
--}}}
