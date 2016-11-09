local hotkey = require 'hs.hotkey'
local key_lock = 'space'

-- auto lock screen
hotkey.bind(hyper, key_lock, function()
    os.execute("/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -suspend") end)
