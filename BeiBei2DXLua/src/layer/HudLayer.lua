require("Cocos2d")
require("Cocos2dConstants")

local SmallAlter = require("view.alter.SmallAlter")


local HudLayer = class("HudLayer", function ()
    return cc.Layer:create()
end)

function HudLayer.create()
    local layer = HudLayer.new()

    
    
    local heartNumber = 1
    local starNumber = 1
    
    
    local label_heart = cc.Label:createWithSystemFont(heartNumber,"",36)
    label_heart:ignoreAnchorPointForPosition(false)
    label_heart:setAnchorPoint(0.5,0)
    label_heart:setColor(cc.c4b(255 , 255, 255 ,255))
    label_heart:setPosition(s_RIGHT_X - 100  , s_DESIGN_HEIGHT - 100 )
    label_heart:setLocalZOrder(1)
    layer:addChild(label_heart)
    
 
    local label_star = cc.Label:createWithSystemFont(heartNumber,"",36)
    label_star:ignoreAnchorPointForPosition(false)
    label_star:setAnchorPoint(0.5,0)
    label_star:setColor(cc.c4b(255 , 255, 255 ,255))
    label_star:setPosition(s_RIGHT_X - 100  , s_DESIGN_HEIGHT - 250 )
    label_star:setLocalZOrder(1)
    layer:addChild(label_star)
    
    --click
    
    local click_start = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
  ----      print(string.format("click_star"))
            s_TIPS_LAYER:showSmall("click_star", affirm)
        end
    end
    
    local click_heart = function(sender, eventType)
       if eventType == ccui.TouchEventType.began then
 ----       print(string.format("click_heart"))
            s_TIPS_LAYER:showSmall("click_heart", affirm)
        end 
    end
    
    local click_word = function(sender, eventType)
       if eventType == ccui.TouchEventType.began then    
 ----       print(string.format("click_word"))
            s_TIPS_LAYER:showSmall("click_word", affirm)
        end
    end
    
    
    local star = ccui.Button:create("image/chapter_level/starEnergy.png", "image/chapter_level/starEnergy.png", "")
    star:addTouchEventListener(click_start)
    star:ignoreAnchorPointForPosition(false)
    star:setAnchorPoint(0.5,1)
    star:setPosition(s_RIGHT_X - 300 , s_DESIGN_HEIGHT - 200 )
    star:setLocalZOrder(1)
    layer:addChild(star)
    
    local heart = ccui.Button:create("image/chapter_level/checkin_heart.png", "image/chapter_level/checkin_heart.png", "")
    heart:addTouchEventListener(click_heart)
    heart:ignoreAnchorPointForPosition(false)
    heart:setAnchorPoint(0.5,1)
    heart:setPosition(s_RIGHT_X - 300  , s_DESIGN_HEIGHT - 50 )
    heart:setLocalZOrder(1)
    layer:addChild(heart)
    
    local wordAday = ccui.Button:create("image/chapter_level/wsy_meiriyici.png", "image/chapter_level/wsy_meiriyici.png", "") 
    wordAday:addTouchEventListener(click_word)
    wordAday:ignoreAnchorPointForPosition(false)
    wordAday:setAnchorPoint(1,1)
    wordAday:setPosition(s_RIGHT_X , s_DESIGN_HEIGHT - 350 )
    wordAday:setLocalZOrder(1)
    layer:addChild(wordAday)
    
    
    
    
--    local onTouchBegan = function(touch, event)
--        local location = layer:convertToNodeSpace(touch:getLocation())
--
--        return true
--    end
--
--    local onTouchMoved = function(touch, event)
--        local location = layer:convertToNodeSpace(touch:getLocation())
--
--    end
--
--    local listener = cc.EventListenerTouchOneByOne:create()
--    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
--    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
--    local eventDispatcher = layer:getEventDispatcher()
--    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
    
    return layer
end

return HudLayer