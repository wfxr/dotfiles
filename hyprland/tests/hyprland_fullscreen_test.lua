local activeWindow
local dispatchedState
local fullscreenCallback

local proxyMetatable = {}

proxyMetatable.__index = function(proxy, key)
    local child = setmetatable({}, proxyMetatable)
    rawset(proxy, key, child)
    return child
end

proxyMetatable.__call = function(proxy)
    return proxy
end

local windowDispatchers = setmetatable({
    fullscreen_state = function(state)
        return state
    end,
}, proxyMetatable)

hl = setmetatable({
    bind = function(keys, dispatcher)
        if keys == "SUPER + F" then
            fullscreenCallback = dispatcher
        end
    end,
    dispatch = function(dispatcher)
        dispatchedState = dispatcher
    end,
    dsp = setmetatable({ window = windowDispatchers }, proxyMetatable),
    get_active_window = function()
        return activeWindow
    end,
    on = function() end,
}, {
    __index = function()
        return function() end
    end,
})

dofile("hypr/hyprland.lua")

assert(type(fullscreenCallback) == "function", "SUPER + F callback was not registered")

activeWindow = {
    fullscreen = 2,
    fullscreen_client = 2,
}

fullscreenCallback()

assert(dispatchedState.internal == 0, "SUPER + F should restore the tiled layout")
assert(dispatchedState.client == 2, "SUPER + F should preserve the client's fullscreen state")

print("SUPER + F preserves client fullscreen while restoring the tiled layout")
