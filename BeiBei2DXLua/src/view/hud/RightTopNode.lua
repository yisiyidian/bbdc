

local RightTopNode = class("RightTopNode", function()
    return cc.Layer:create()
end)

function RightTopNode.create()
    local layer = RightTopNode.new()

    return layer
end

local introLayer

function RightTopNode:ctor()
    local heartNumber = 2
    local heartShow = ""
    local starNumber = 1

       
    -- heart info     
--    local IntroLayer = require("popup/PopupEnergyInfo")
--    local introLayer = IntroLayer.create()  


    local click_star = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
--            local IntroLayer = require("popup/PopupStarInfo")
--            local introLayer = IntroLayer.create()  
--            s_SCENE:popup(introLayer)
        end
    end

    local click_heart = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            -- click

            local IntroLayer = require("popup/PopupEnergyInfo")
            introLayer = IntroLayer.create()  
            s_SCENE:popup(introLayer)

            local action1 = cc.MoveTo:create(0.3, cc.p(0,-300))          
            introLayer:runAction(action1)
            

        end 
    end

    local click_word = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then    

        end
    end


    local star = ccui.Button:create("image/chapter_level/starEnergyLong.png", "image/chapter_level/starEnergyLong.png", "")
    star:addTouchEventListener(click_star)
    star:ignoreAnchorPointForPosition(false)
    star:setAnchorPoint(1,0.5)
    star:setPosition(s_RIGHT_X - 10 , s_DESIGN_HEIGHT - 150 )
    star:setLocalZOrder(1)
    self:addChild(star)

    local star_back = cc.Sprite:create("image/chapter_level/starBack.png")
    star_back:setPosition(132,42)
    star_back:setLocalZOrder(-1)
    star:addChild(star_back)

    local heart = ccui.Button:create("image/chapter_level/energyHeartLong.png", "image/chapter_level/energyHeartLong.png", "")
    heart:addTouchEventListener(click_heart)
    heart:ignoreAnchorPointForPosition(false)
    heart:setAnchorPoint(1,0.5)
    heart:setPosition(s_RIGHT_X   , s_DESIGN_HEIGHT - 70 )
    heart:setLocalZOrder(1)
    self:addChild(heart)

    local heartExist = cc.Label:createWithSystemFont(heartNumber,"",36)
    heartExist:setPosition(75,38)
    heart:addChild(heartExist)

    local  heart_back = cc.Sprite:create("image/chapter_level/heartBack.png")
    heart_back:setPosition(145,36)
    heart_back:setLocalZOrder(-1)
    heart:addChild(heart_back)

    local wordAday = ccui.Button:create("image/chapter_level/wsy_meiriyici.png", "image/chapter_level/wsy_meiriyici.png", "") 
    wordAday:addTouchEventListener(click_word)
    wordAday:ignoreAnchorPointForPosition(false)
    wordAday:setAnchorPoint(1,0.5)
    wordAday:setPosition(s_RIGHT_X - 15 , s_DESIGN_HEIGHT - 230 )
    wordAday:setLocalZOrder(1)
    wordAday:setScale(0.5);
    self:addChild(wordAday)

    local wordAday_back = cc.Sprite:create("image/chapter_level/checkInGlow.png")
    wordAday_back:setPosition(0.5 * wordAday:getContentSize().width,0.5 * wordAday:getContentSize().height)
    --    wordAday_back:ignoreAnchorPointForPosition(false)
    --    wordAday_back:setAnchorPoint(1,0.5)
    wordAday_back:setScale(0.5);
    wordAday:addChild(wordAday_back,-1)


    local fade_in = cc.FadeIn:create(0.5) 
    local fade_out = cc.FadeOut:create(0.5)
    local action = cc.Sequence:create(fade_in,fade_out)
    wordAday_back:runAction(cc.RepeatForever:create(action))


    if heartNumber >= 4 then
        heartShow = "full"
    end

    local label_heart = cc.Label:createWithSystemFont(heartShow,"",36)
    label_heart:ignoreAnchorPointForPosition(false)
    label_heart:setAnchorPoint(0.5,0.5)
    label_heart:setColor(cc.c4b(255 , 255, 255 ,255))
    label_heart:setPosition(100 , 30 )
    label_heart:setLocalZOrder(1)
    heart_back:addChild(label_heart)


    local label_star = cc.Label:createWithSystemFont(starNumber,"",36)
    label_star:ignoreAnchorPointForPosition(false)
    label_star:setAnchorPoint(0.5,0.5)
    label_star:setColor(cc.c4b(255 , 255, 255 ,255))
    label_star:setPosition(95,30)
    label_star:setLocalZOrder(1)
    star_back:addChild(label_star)

    -- changing number (30 min)
    -- click heart
    local min = 29
    local sec = 59
    local function update(delta)

        if heartNumber < 4 then         
            sec = sec - delta
            heartShow = min..":"..string.format("%d",sec)
            label_heart:setString(heartShow)
            heartExist:setString(heartNumber)
            
            -- update data
            introLayer.ccbPopupEnergyInfo['energyNumber']:setString(string.format(min)..':'..string.format("%d",sec))
            introLayer.ccbPopupEnergyInfo['energy_number'] = heartNumber
            local animation = introLayer.ccbPopupEnergyInfo['popupWindow']:getChildByName("heart_animation")
            local label = animation:getChildByName("energyNumber")
            label:setString(heartNumber)
            



            
            if sec <= 0 then
                sec = 59
                min = min - 1
            end

            if min == -1 then 
                min = 29
                heartNumber = heartNumber + 1
            end
            
        elseif heartNumber >= 4 then
            label_heart:setString("full" )
        end
    end


    self:scheduleUpdateWithPriorityLua(update, 0)  
    
    
    --    -- popupwindow
    --    layer.ccb = {}
    --    ccbPopupWindow['close'] = layer.close
    --    ccbPopupWindow['count'] = layer.count
    --    ccbPopupWindow['total'] = layer.total
    --    ccbPopupWindow['collect'] = layer.collect
    --    ccbPopupWindow['onClose'] = layer.onClose
    ----  ccbPause['Layer'] = self
    --
    --    
    --    layer.ccb['star'] = ccbPopupWindow
    --    
    --    local proxy = cc.CCBProxy:create()    
    --    local node  = CCBReaderLoad("ccb/righttopnode.ccbi", proxy, ccbPopupWindow, layer.ccb)
    --    layer:addChild(node)
    --  
end

return RightTopNode