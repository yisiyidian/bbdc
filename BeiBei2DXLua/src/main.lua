
require "Cocos2d"

-- cclog
local cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    
    cc.FileUtils:getInstance():addSearchPath("src")
    cc.FileUtils:getInstance():addSearchPath("res")
    cc.Director:getInstance():setDisplayStats(false)

    --------------------------------------------------------------------------------
    require("common.global")
    initApp()
    
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(s_SCENE)
    else
        cc.Director:getInstance():runWithScene(s_SCENE)
    end
    
    -- test
    --local example = require("example.example")
    --test()
    s_level = require('view/LevelLayer.lua')
    layer = s_level.create()
    --layer:setAnchorPoint(0.5,0)
--    layer:setPosition(s_LEFT_X, 0)
    
    s_SCENE:replaceGameLayer(layer)
    --------------------------------------------------------------------------------
--    s_localSqlite = require("model.localData.LocalDatabaseManager")
--    s_localSqlite.open()
--    s_localSqlite.initTables()
--    s_localSqlite.showTables()
    --s_localSqlite.close()
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
