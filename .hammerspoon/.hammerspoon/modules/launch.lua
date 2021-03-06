local hotkey = require 'hs.hotkey'
local window = require 'hs.window'
local application = require 'hs.application'

local key2App = {
    a = 'Appcleaner',
    d = 'Dictionary',
    e = 'Evernote',
    f = 'Finder',
    g = 'Google Chrome',
    h = 'Hipchat',
    i = 'Iterm',
    k = 'Keyboard Maestro',
    m = 'Mail',
    n = 'NeteaseMusic',
    p = 'System Preferences', 
    q = 'QQ',
    s = 'skim', 
    t = 'teamviewer',
    v = 'Macvim',
    x = 'OmniFocus'
}

for key, app in pairs(key2App) do
    hotkey.bind(hyper, key, function()
        toggle_application(app)
    end)
end

-- Toggle an application between being the frontmost app, and being hidden
function toggle_application(_app)
    -- finds a running applications
    local app = application.find(_app)

    if not app then
        -- application not running, launch app
        application.launchOrFocus(_app)
        return
    end

    -- application running, toggle hide/unhide
    local mainwin = app:mainWindow()
    if mainwin then
        if true == app:isFrontmost() then
            mainwin:application():hide()
        else
            mainwin:application():activate(true)
            mainwin:application():unhide()
            mainwin:focus()
        end
    else
    -- no windows, maybe hide
        if true == app:hide() then
            -- focus app
            application.launchOrFocus(_app)
        else
            -- nothing to do
        end
    end
end
