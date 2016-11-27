local hints = require 'hs.hints'
local hotkey = require 'hs.hotkey'

hs.hints.style='vimperator'
hotkey.bind('ctrl', 'space', function()
    hints.windowHints()
end)
