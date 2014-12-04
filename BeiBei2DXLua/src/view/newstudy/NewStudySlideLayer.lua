require("Cocos2d")
require("Cocos2dConstants")

require("common.global")

local NewStudyLayer     = require("view.newstudy.NewStudyLayer")

local  NewStudySlideLayer = class("NewStudySlideLayer", function ()
    return cc.Layer:create()
end)

function NewStudySlideLayer.create()

    local bigWidth = s_DESIGN_WIDTH + 2*s_DESIGN_OFFSET_WIDTH

    local layer = NewStudySlideLayer.new()

    local backGround = cc.Sprite:create("image/newstudy/new_study_background.png")
    backGround:setPosition(bigWidth / 2,s_DESIGN_HEIGHT / 2)
    backGround:ignoreAnchorPointForPosition(false)
    backGround:setAnchorPoint(0.5,0.5)
    layer:addChild(backGround)

    local pause_button = ccui.Button:create("image/newstudy/pause_button_begin.png","image/newstudy/pause_button_end.png","")
    pause_button:setPosition(s_LEFT_X + 150, s_DESIGN_HEIGHT - 50 )
    pause_button:ignoreAnchorPointForPosition(false)
    pause_button:setAnchorPoint(0,1)
    backGround:addChild(pause_button)    

    local word_mark 

    for i = 1,8 do
        if i == 1 then 
            word_mark = cc.Sprite:create("image/newstudy/blue_begin.png")
        elseif i == 8 then 
            word_mark = cc.Sprite:create("image/newstudy/blue_end.png")
        else
            word_mark = cc.Sprite:create("image/newstudy/blue_mid.png")
        end

        if word_mark ~= nil then
            word_mark:setPosition(backGround:getContentSize().width * 0.5 + word_mark:getContentSize().width*1.1 * (i - 5),s_DESIGN_HEIGHT * 0.95)
            word_mark:ignoreAnchorPointForPosition(false)
            word_mark:setAnchorPoint(0,0.5)
            backGround:addChild(word_mark)
        end
    end

    local huge_word = cc.Label:createWithSystemFont("这里是自适应的字体","",48)
    huge_word:setPosition(backGround:getContentSize().width / 2,s_DESIGN_HEIGHT * 0.8)
    huge_word:setColor(cc.c4b(0,0,0,255))
    huge_word:ignoreAnchorPointForPosition(false)
    huge_word:setAnchorPoint(0.5,0.5)
    backGround:addChild(huge_word)

    local slide_word_label = cc.Label:createWithSystemFont("回忆并划出刚才的单词","",40)
    slide_word_label:setPosition(backGround:getContentSize().width *0.13,s_DESIGN_HEIGHT * 0.68)
    slide_word_label:setColor(cc.c4b(124,157,208,255))
    slide_word_label:ignoreAnchorPointForPosition(false)
    slide_word_label:setAnchorPoint(0,0.5)
    backGround:addChild(slide_word_label)

    for i = 1 , 4 do
        for k = 1 , 4 do
            local slide_button = ccui.Button:create("image/newstudy/click_undo.png","image/newstudy/click_do.png","")
            slide_button:setPosition(backGround:getContentSize().width * 0.5 + slide_button:getContentSize().width*1.1 * (i - 3),
                backGround:getContentSize().height * 0.5 + slide_button:getContentSize().height * 1.1 * (k - 3))
            slide_button:ignoreAnchorPointForPosition(false)
            slide_button:setAnchorPoint(0,0.5)
            backGround:addChild(slide_button)  
        end
    end

    local click_before_button = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            -- button sound
            playSound(s_sound_buttonEffect)        
        elseif eventType == ccui.TouchEventType.ended then
            local newStudyLayer = NewStudyLayer.create(NewStudyLayer_State_Mission)
            s_SCENE:replaceGameLayer(newStudyLayer)
        end
    end

    local choose_before_button = ccui.Button:create("image/newstudy/brown_begin.png","image/newstudy/brown_end.png","")
    choose_before_button:setPosition(backGround:getContentSize().width /2  , s_DESIGN_HEIGHT * 0.1)
    choose_before_button:ignoreAnchorPointForPosition(false)
    choose_before_button:setAnchorPoint(0.5,0.5)
    choose_before_button:addTouchEventListener(click_before_button)
    backGround:addChild(choose_before_button)  

    local choose_before_text = cc.Label:createWithSystemFont("偷偷看一眼","",32)
    choose_before_text:setPosition(choose_before_button:getContentSize().width * 0.5,choose_before_button:getContentSize().height * 0.5)
    choose_before_text:setColor(cc.c4b(255,255,255,255))
    choose_before_text:ignoreAnchorPointForPosition(false)
    choose_before_text:setAnchorPoint(0.5,0.5)
    choose_before_button:addChild(choose_before_text)


    return layer
end

return NewStudySlideLayer