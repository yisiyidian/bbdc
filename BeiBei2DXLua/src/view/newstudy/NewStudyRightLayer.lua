require("cocos.init")
require("common.global")

local BackLayer         = require("view.newstudy.NewStudyBackLayer")
local SoundMark         = require("view.newstudy.NewStudySoundMark")
local SmallDetailInfo   = require("view.newstudy.NewStudySmallDetailInfo")

local  NewStudyRightLayer = class("NewStudyRightLayer", function ()
    return cc.Layer:create()
end)

function NewStudyRightLayer.create()
    -- word info
    local currentWordName   = s_CorePlayManager.NewStudyLayerWordList[s_CorePlayManager.currentIndex]
    local currentWord       = s_WordPool[currentWordName]
    local wordname          = currentWord.wordName
    local wordSoundMarkEn   = currentWord.wordSoundMarkEn
    local wordSoundMarkAm   = currentWord.wordSoundMarkAm
    local wordMeaningSmall  = currentWord.wordMeaningSmall
    local wordMeaning       = currentWord.wordMeaning
    local sentenceEn        = currentWord.sentenceEn
    local sentenceCn        = currentWord.sentenceCn
    local sentenceEn2       = currentWord.sentenceEn2
    local sentenceCn2       = currentWord.sentenceCn2

    -- ui 
    local bigWidth = s_DESIGN_WIDTH + 2*s_DESIGN_OFFSET_WIDTH
    local layer = NewStudyRightLayer.new()

    local backColor = BackLayer.create(45) 
    backColor:setAnchorPoint(0.5,0.5)
    backColor:ignoreAnchorPointForPosition(false)
    backColor:setPosition(s_DESIGN_WIDTH/2,s_DESIGN_HEIGHT/2)
    layer:addChild(backColor)

    local soundMark = SoundMark.create(wordname, wordSoundMarkEn, wordSoundMarkAm)
    soundMark:setPosition(bigWidth/2, 960)  
    backColor:addChild(soundMark)

    local smallDetailInfo = SmallDetailInfo.create(currentWord)
    smallDetailInfo:setPosition(backColor:getContentSize().width *0.5, 0)  
    backColor:addChild(smallDetailInfo)
    
    local click_study_button = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            -- button sound
            playSound(s_sound_buttonEffect)        
        elseif eventType == ccui.TouchEventType.ended then
            s_CorePlayManager.enterNewStudyWrongLayer()
        end
    end

    local choose_study_button = ccui.Button:create("image/newstudy/button_twobutton_size.png","image/newstudy/button_twobutton_size_pressed.png","")
    choose_study_button:setPosition(bigWidth/2-151, 153)
    choose_study_button:setTitleText("依然复习")
    choose_study_button:setTitleColor(cc.c4b(255,255,255,255))
    choose_study_button:setTitleFontSize(32)
    choose_study_button:addTouchEventListener(click_study_button)
    backColor:addChild(choose_study_button)
    
    local click_next_button = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            -- button sound
            playSound(s_sound_buttonEffect)        
        elseif eventType == ccui.TouchEventType.ended then
            s_CorePlayManager.updateRightWordList(wordname)
            s_CorePlayManager.updateCurrentIndex()
            s_CorePlayManager.enterNewStudyChooseLayer()
        end
    end

    local choose_next_button = ccui.Button:create("image/newstudy/button_twobutton_size.png","image/newstudy/button_twobutton_size_pressed.png","")
    choose_next_button:setPosition(bigWidth/2+151, 153)
    choose_next_button:setTitleText("下一个")
    choose_next_button:setTitleColor(cc.c4b(255,255,255,255))
    choose_next_button:setTitleFontSize(32)
    choose_next_button:addTouchEventListener(click_next_button)
    backColor:addChild(choose_next_button)
    
    return layer
end

return NewStudyRightLayer