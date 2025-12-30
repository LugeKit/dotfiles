--------------------------------- general functions ---------------------------------
local debug = false

-- show alert when debug is enabled
local function alert(msg)
    if debug then
        hs.alert.show(msg)
    end
end
local bindKey = hs.hotkey.bind

-- auto reload when init.lua is changed
local function reloadConfig(files)
    local doReload = true
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- change IM helper
local languageIM = {
    ["English"] = "com.apple.keylayout.ABC",
    ["Chinese"] = "com.sogou.inputmethod.sogou.pinyin"
}
local function changeIM(language)
    local currentSourceID = hs.keycodes.currentSourceID()
    local expectedSourceID = languageIM[language]
    if not expectedSourceID then
        alert(expectedSourceID .. " is not found in IM map")
    end

    if currentSourceID ~= expectedSourceID then
        hs.keycodes.currentSourceID(expectedSourceID)
    end
end

local configReloadWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/dotfiles/hammerspoon/", reloadConfig)
configReloadWatcher:start()
alert("hs config reloaded")


--------------------------------- window resize functions ---------------------------------
-- local variables
local frameCache = {}
local operationCache = {}

-- resize func
local function moveWindow(direction)
    local win = hs.window.focusedWindow()
    if not win then
        return
    end

    local id = win:id()
    if not id then
        return
    end

    local position
    if frameCache[id] then
        if operationCache[id] == direction then
            win:setFrame(frameCache[id])
            frameCache[id] = nil
            operationCache[id] = nil
            return
        else
            operationCache[id] = direction
        end
    else
        frameCache[id] = win:frame()
        operationCache[id] = direction
    end

    if direction == "left" then
        position = { 0, 0, 0.5, 1 }
    elseif direction == "right" then
        position = { 0.5, 0, 0.5, 1 }
    elseif direction == "up" then
        position = { 0, 0, 1, 0.5 }
    elseif direction == "down" then
        position = { 0, 0.5, 1, 0.5 }
    elseif direction == "up_left" then
        position = { 0, 0, 0.5, 0.5 }
    elseif direction == "up_right" then
        position = { 0.5, 0, 0.5, 0.5 }
    elseif direction == "down_left" then
        position = { 0, 0.5, 0.5, 0.5 }
    elseif direction == "down_right" then
        position = { 0.5, 0.5, 0.5, 0.5 }
    elseif direction == "max" then
        position = { 0, 0, 1, 1 }
    end

    win:move(position)
end

bindKey({ "ctrl", "shift" }, "Left", hs.fnutils.partial(moveWindow, "left"))
bindKey({ "ctrl", "shift" }, "Right", hs.fnutils.partial(moveWindow, "right"))
bindKey({ "ctrl", "shift" }, "Up", hs.fnutils.partial(moveWindow, "up"))
bindKey({ "ctrl", "shift" }, "Down", hs.fnutils.partial(moveWindow, "down"))
bindKey({ "ctrl", "shift" }, "[", hs.fnutils.partial(moveWindow, "up_left"))
bindKey({ "ctrl", "shift" }, "]", hs.fnutils.partial(moveWindow, "up_right"))
bindKey({ "ctrl", "shift" }, ";", hs.fnutils.partial(moveWindow, "down_left"))
bindKey({ "ctrl", "shift" }, "'", hs.fnutils.partial(moveWindow, "down_right"))
bindKey({ "ctrl", "shift" }, "\\", hs.fnutils.partial(moveWindow, "max"))

--------------------------------- input method functions ---------------------------------
local appLanguage = {
    ["飞书"] = "Chinese",
}

local function imChangeForAppChange(appName)
    alert("current app is: " .. appName)

    -- if language is not set spcifically, set it to ABC
    local language = appLanguage[appName] or "English"
    changeIM(language)
end


--------------------------------- hotkey ---------------------------------
--- hotkey for Ghostty
bindKey({ "option" }, "z", function()
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
    alert("current app is: " .. appName)
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
        imChangeForAppChange(appName)
        hotkeyChangeForLark(appName)
    end
end)
appWatcher:start()

--------------------------------- debug ---------------------------------
bindKey({ "cmd", "ctrl" }, "t", function()
    local app = hs.window.focusedWindow():application():name()
    alert(app)
    alert(hs.keycodes.currentSourceID())
end)


hs.loadSpoon('EmmyLua')
