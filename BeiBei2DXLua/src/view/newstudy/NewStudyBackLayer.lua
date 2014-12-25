require("cocos.init")
require("common.global")

local ProgressBar       = require("view.newstudy.NewStudyProgressBar")

local BackLayer = class("BackLayer", function()
    return cc.Layer:create()
end)

function BackLayer.create(offset)   -- offset is 97 or 45 or 0
    local bigWidth = s_DESIGN_WIDTH + 2*s_DESIGN_OFFSET_WIDTH
    local backColor = cc.LayerColor:create(cc.c4b(168,239,255,255), bigWidth, s_DESIGN_HEIGHT)  

    local back_head = cc.Sprite:create("image/newstudy/back_head.png")
    back_head:setAnchorPoint(0.5, 1)
    back_head:setPosition(bigWidth/2, s_DESIGN_HEIGHT + offset)
    backColor:addChild(back_head)

    local back_tail = cc.Sprite:create("image/newstudy/back_tail.png")
    back_tail:setAnchorPoint(0.5, 0)
    back_tail:setPosition(bigWidth/2, 0)
    backColor:addChild(back_tail)

    local button_pause_clicked = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            -- button sound
            playSound(s_sound_buttonEffect)        
        elseif eventType == ccui.TouchEventType.ended then            
            s_CorePlayManager.recordStudyStateIntoDB()
            s_CorePlayManager.enterLevelLayer()
        end
    end

    local button_pause = ccui.Button:create("image/newstudy/zanting_chapter1.png","image/newstudy/zanting_chapter1.png","")
    button_pause:setPosition(bigWidth/2-276, 1099)
    button_pause:addTouchEventListener(button_pause_clicked)
    backColor:addChild(button_pause)

    local progressBar
    if s_CorePlayManager.isStudyModel() then
        progressBar = ProgressBar.create(s_CorePlayManager.maxWrongWordCount, s_CorePlayManager.wrongWordNum, "yellow")
    else
        progressBar = ProgressBar.create(s_CorePlayManager.maxWrongWordCount, s_CorePlayManager.maxWrongWordCount-s_CorePlayManager.candidateNum, "yellow")
    end
    progressBar:setPosition(bigWidth/2+44, 1099)
    backColor:addChild(progressBar)

    return backColor
end


return BackLayer






