require("cocos.init")
require("common.global")

local BackLayer             = require("view.newstudy.NewStudyBackLayer")
local SoundMark             = require("view.newstudy.NewStudySoundMark")
local ProgressBar           = require("view.newstudy.NewStudyProgressBar")
local LastWordAndTotalNumber= require("view.newstudy.LastWordAndTotalNumberTip") 
local CollectUnfamiliar     = require("view.newstudy.CollectUnfamiliarLayer")
local Button                = require("view.newstudy.BlueButtonInStudyLayer")

local  ChooseCollectWordLayer = class("ChooseCollectWordLayer", function ()
    return cc.Layer:create()
end)

local function createKnow(word,wrongNum, preWordName, preWordNameState)
    local bigWidth = s_DESIGN_WIDTH + 2*s_DESIGN_OFFSET_WIDTH

    local click_know_button = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            playSound(s_sound_buttonEffect)        
        elseif eventType == ccui.TouchEventType.ended then
            -- local CollectUnfamiliarLayer = require("view.newstudy.CollectUnfamiliarLayer")
            -- local collectUnfamiliarLayer = CollectUnfamiliarLayer.create(word, wrongNum, preWordName, preWordNameState)
            -- s_SCENE:replaceGameLayer(collectUnfamiliarLayer)
            s_CorePlayManager.leaveStudyModel(true)
        end
    end

    local choose_know_button = Button.create("太熟悉了")
    choose_know_button:setPosition(bigWidth/2, 500)
    choose_know_button:addTouchEventListener(click_know_button)

    return choose_know_button
end

local function createDontknow(word,wrongNum, preWordName, preWordNameState)
    local bigWidth = s_DESIGN_WIDTH + 2*s_DESIGN_OFFSET_WIDTH

    local click_dontknow_button = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            playSound(s_sound_buttonEffect)        
        elseif eventType == ccui.TouchEventType.ended then
            local ChooseWrongLayer = require("view.newstudy.ChooseWrongLayer")
            local chooseWrongLayer = ChooseWrongLayer.create(word,wrongNum,nil,preWordName, preWordNameState)
            s_SCENE:replaceGameLayer(chooseWrongLayer)          
        end
    end

    local choose_dontknow_button = Button.create("不认识")
    choose_dontknow_button:setPosition(bigWidth/2, 300)
    choose_dontknow_button:addTouchEventListener(click_dontknow_button)

    return choose_dontknow_button
end

function ChooseCollectWordLayer.create(wordName, wrongWordNum, preWordName, preWordNameState)
    local layer = ChooseCollectWordLayer.new(wordName, wrongWordNum, preWordName, preWordNameState)
    s_TOUCH_EVENT_BLOCK_LAYER.unlockTouch()
    cc.SimpleAudioEngine:getInstance():pauseMusic()
    return layer
end

function ChooseCollectWordLayer:ctor(wordName, wrongWordNum, preWordName, preWordNameState)
    local bigWidth = s_DESIGN_WIDTH + 2*s_DESIGN_OFFSET_WIDTH

    local backColor = BackLayer.create(45) 
    backColor:setAnchorPoint(0.5,0.5)
    backColor:ignoreAnchorPointForPosition(false)
    backColor:setPosition(s_DESIGN_WIDTH/2,s_DESIGN_HEIGHT/2)
    self:addChild(backColor)

    self.currentWord = wordName
    self.wordInfo = CollectUnfamiliar:createWordInfo(self.currentWord)

    local progressBar_total_number = getMaxWrongNumEveryLevel()

    local progressBar = ProgressBar.create(progressBar_total_number, wrongWordNum, "blue")
    progressBar:setPosition(bigWidth/2+44, 1049)
    backColor:addChild(progressBar,2)

    self.lastWordAndTotalNumber = LastWordAndTotalNumber.create()
    backColor:addChild(self.lastWordAndTotalNumber,1)
    local todayNumber = LastWordAndTotalNumber:getTodayNum()
    self.lastWordAndTotalNumber.setNumber(todayNumber)
    if preWordName ~= nil then
        self.lastWordAndTotalNumber.setWord(preWordName,preWordNameState)
    end

    local soundMark = SoundMark.create(self.wordInfo[2], self.wordInfo[3], self.wordInfo[4])
    soundMark:setPosition(bigWidth/2, 925)  
    backColor:addChild(soundMark)
    
    self.iknow = createKnow(wordName,wrongWordNum, preWordName, preWordNameState)
    backColor:addChild(self.iknow)

    self.dontknow = createDontknow(wordName,wrongWordNum, preWordName, preWordNameState)
    backColor:addChild(self.dontknow)
end

return ChooseCollectWordLayer