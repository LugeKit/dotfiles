local M = {}

--------------------------------- hotkey ---------------------------------
--- hotkey for Ghostty
hs.hotkey.bind({ "option" }, "z", function()
    local term = hs.application.get("Ghostty")
    if term and term:isFrontmost() then
        term:hide()
        return
    end
    hs.application.launchOrFocus("Ghostty")
end)

-- hotkey for dismiss Lark
local dismissLarkHotkey = hs.hotkey.new({ "cmd" }, "w", function()
    local app = hs.window.focusedWindow():application()
    if not app then
        return
    end

    app:hide()
end)

local function hotkeyChangeForLark(appName)
    -- lark will not lose focus when cmd+w close it window
    -- so force it to hide
    if appName == "飞书" then
        dismissLarkHotkey:enable()
    else
        dismissLarkHotkey:disable()
    end
end


------------------- app change listener -------------------
local appWatcher = hs.application.watcher.new(function(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        hotkeyChangeForLark(appName)
    end
end)
appWatcher:start()
