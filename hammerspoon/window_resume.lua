local M = {}

local settingsKey = "user_saved_window_layout"

local function saveWindowLayout()
    local layoutMap = {}
    -- Use hs.window.allWindows() instead of hs.window.filter.default:getWindows()
    -- filter.default creates a heavy background watcher that slows down HS event loop
    local windows = hs.window.allWindows()

    for _, win in ipairs(windows) do
        local appName = win:application():name()
        local screen = win:screen()
        local frame = win:frame()

        if appName and screen then
            layoutMap[appName] = {
                appName = appName,
                screenUUID = screen:getUUID(),
                frame = { x = frame.x, y = frame.y, w = frame.w, h = frame.h },
            }
        end
    end

    hs.settings.set(settingsKey, layoutMap)
    hs.alert.show("layout is saved")
end

local function restoreWindowLayout()
    local savedLayout = hs.settings.get(settingsKey)
    if not savedLayout then
        hs.alert.show("window restored skipped for no saved layout")
        return
    end

    local screenCache = {}
    local windows = hs.window.allWindows()
    for _, win in ipairs(windows) do
        local appName = win:application():name()

        local savedWin = savedLayout[appName]
        if savedWin then
            local screenUUID = savedWin.screenUUID
            local targetScreen = screenCache[screenUUID]

            if not targetScreen then
                targetScreen = hs.screen.find(screenUUID)
                screenCache[screenUUID] = targetScreen
            end

            if targetScreen then
                win:move(savedWin.frame, targetScreen, true, 0)
            end
        end
    end

    hs.alert.show("layout is restored")
end

hs.hotkey.bind({ "cmd", "shift" }, "S", saveWindowLayout)
hs.hotkey.bind({ "cmd", "shift" }, "R", restoreWindowLayout)
M.screenWatcher = hs.screen.watcher.new(function()
    hs.timer.doAfter(1, restoreWindowLayout)
end):start()

M.caffeinateWatcher = hs.caffeinate.watcher.new(function(eventType)
    if eventType == hs.caffeinate.watcher.screensDidUnlock then
        hs.timer.doAfter(1, restoreWindowLayout)
    end
end):start()

return M
