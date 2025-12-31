package.path = package.path .. ";" .. os.getenv("HOME") .. "/dotfiles/hammerspoon/?.lua"

-- enable intellicence for hammerspoon
hs.loadSpoon('EmmyLua')

-- window management
require("window_resume")

-- ime management
require("hotkey")
