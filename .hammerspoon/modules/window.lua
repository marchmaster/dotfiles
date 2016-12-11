require "hs.application"

local hotkey = require 'hs.hotkey'
local window = require 'hs.window'
local layout = require 'hs.layout'
local alert = require 'hs.alert'
local grid = require 'hs.grid'
local geometry = require 'hs.geometry'

---- hyper [ for left one half window
hotkey.bind(hyper, '[', function() window.focusedWindow():moveToUnit(layout.left50) end)

-- hyper ] for right one half window
hotkey.bind(hyper, ']', function() window.focusedWindow():moveToUnit(layout.right50) end)

-- hyper \ for maxium windows
hotkey.bind(hyper, '\\', function() window.focusedWindow():toggleFullScreen() end)

-- hyper - for upper half window
hs.hotkey.bind(hyper,"-", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w 
  f.h = max.h / 2
  win:setFrame(f)
end)

-- hyper = for lower half window
hs.hotkey.bind(hyper,"=", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x 
  f.y = max.y + (max.h / 2)
  f.w = max.w 
  f.h = max.h / 2
  win:setFrame(f)
end)
