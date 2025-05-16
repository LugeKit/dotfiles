-- general func
-- send notify
function sendNotify(content, title)
    if title == nil then
        title = "Hammerspoon"
    end
    hs.notify.new({title=title, informativeText=content}):send()
end

local debug = false

alert = function(msg)
    if debug then
        hs.alert.show(msg)
    end
end
bindKey = hs.hotkey.bind

-- auto reload when init.lua is changed
function reloadConfig(files)
    doReload = true
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
configReloadWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/dotfiles/hammerspoon/", reloadConfig)
configReloadWatcher:start()
alert("hs config reloaded")


-- resize window
-- local variables
local frameCache = {}
local operationCache = {}

-- resize func
function moveWindow(direction)
    local win = hs.window.focusedWindow()
    local position
    local id = win:id()

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
        position = {0, 0, 0.5, 1}
    elseif direction == "right" then
        position = {0.5, 0, 0.5, 1}
    elseif direction == "up" then
        position = {0, 0, 1, 0.5}
    elseif direction == "down" then
        position = {0, 0.5, 1, 0.5}
    elseif direction == "up_left" then
        position = {0, 0, 0.5, 0.5}
    elseif direction == "up_right" then
        position = {0.5, 0, 0.5, 0.5}
    elseif direction == "down_left" then
        position = {0, 0.5, 0.5, 0.5}
    elseif direction == "down_right" then
        position = {0.5, 0.5, 0.5, 0.5}
    elseif direction == "max" then
        position = {0, 0, 1, 1}
    end

    win:move(position)
end

bindKey({"ctrl", "shift"}, "Left", hs.fnutils.partial(moveWindow, "left"))
bindKey({"ctrl", "shift"}, "Right", hs.fnutils.partial(moveWindow, "right"))
bindKey({"ctrl", "shift"}, "Up", hs.fnutils.partial(moveWindow, "up"))
bindKey({"ctrl", "shift"}, "Down", hs.fnutils.partial(moveWindow, "down"))
bindKey({"ctrl", "shift"}, "[", hs.fnutils.partial(moveWindow, "up_left"))
bindKey({"ctrl", "shift"}, "]", hs.fnutils.partial(moveWindow, "up_right"))
bindKey({"ctrl", "shift"}, ";", hs.fnutils.partial(moveWindow, "down_left"))
bindKey({"ctrl", "shift"}, "'", hs.fnutils.partial(moveWindow, "down_right"))
bindKey({"ctrl", "shift"}, "\\", hs.fnutils.partial(moveWindow, "max"))

-- auto change input method
local appLanguage = {
    ["飞书"] = "Chinese",
}

local languageIM = {
    ["English"] = "com.apple.keylayout.ABC",
    ["Chinese"] = "com.sogou.inputmethod.sogou.pinyin"
}

dismissLarkHotkey = hs.hotkey.new({"cmd"}, "w", function()
    local app = hs.window.focusedWindow():application()
    app:hide()
end)

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

local lastApp1 = nil
local lastApp2 = nil
bindKey({"alt"}, "`", function()
    if lastApp2 ~= nil then
        if lastApp2 == "飞书" then
            lastApp2 = "Lark"
        end
        hs.application.launchOrFocus(lastApp2)
    end
end)


function onAppChange(appName)
    alert("current app is: " .. appName)
    -- lark will not lose focus when cmd+w close it window
    -- so force it to hide
    if appName == "飞书" then
        dismissLarkHotkey:enable()
    else
        dismissLarkHotkey:disable()
    end

    -- if language is not set spcifically, set it to ABC
    local language = appLanguage[appName] or "English"
    changeIM(language)

    lastApp2 = lastApp1
    lastApp1 = appName
end

appWatcher = hs.application.watcher.new(function(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        onAppChange(appName)
    end
end)
appWatcher:start()

-- terminal
bindKey({"option"}, "z", function()
    local term = hs.application.get("Ghostty")
    if term and term:isFrontmost() then
        term:hide()
        return
    end
    hs.application.launchOrFocus("Ghostty")
end)

-- test
bindKey({"cmd", "ctrl"}, "t", function()
    local app = hs.window.focusedWindow():application():name()
    alert(app)
    alert(hs.keycodes.currentSourceID())
end)

