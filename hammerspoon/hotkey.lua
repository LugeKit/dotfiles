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

-- dismiss lark when cmd+w
M.cmdWWatcher = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()

    -- Fast return if not cmd+w
    if keyCode ~= hs.keycodes.map["w"] or not flags:containExactly({ "cmd" }) then
        return false
    end

    local win = hs.window.focusedWindow()
    if not win then
        return false
    end

    local app = win:application()
    if not app then
        return false
    end

    local appName = app:name()
    if appName ~= "飞书" and appName ~= "Lark" then
        return false
    end

    app:hide()
    return true
end):start()

return M
