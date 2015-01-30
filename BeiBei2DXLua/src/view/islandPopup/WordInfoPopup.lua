local WordInfoPopup = class ("WordInfoPopup",function ()
    return cc.Layer:create()
end)

local DetailInfo        = require("view.newreviewboss.NewReviewBossWordInfo")
local SoundMark         = require("view.newstudy.NewStudySoundMark")

function WordInfoPopup.create()
    local layer = WordInfoPopup.new()
    layer:createInfo()
    return layer
end

local function creatWordLayout(word)
    local currentWord       = s_WordPool[word]
    local wordname          = currentWord.wordName
    local wordSoundMarkEn   = currentWord.wordSoundMarkEn
    local wordSoundMarkAm   = currentWord.wordSoundMarkAm
    local wordMeaningSmall  = currentWord.wordMeaningSmall
    local wordMeaning       = currentWord.wordMeaning
    local sentenceEn        = currentWord.sentenceEn
    local sentenceCn        = currentWord.sentenceCn
    local sentenceEn2       = currentWord.sentenceEn2
    local sentenceCn2       = currentWord.sentenceCn2

    local layout = ccui.Layout:create()
    layout:setContentSize(cc.size(545, 683))

    local soundMark = SoundMark.create(wordname, wordSoundMarkEn, wordSoundMarkAm)
    soundMark:setPosition(cc.p(layout:getContentSize().width / 2, layout:getContentSize().height * 0.8))
    layout:addChild(soundMark)
    soundMark.setSwallowTouches(false)

    local detailInfo = DetailInfo.create(currentWord)
    detailInfo:setAnchorPoint(0.5,0.5)
    detailInfo:ignoreAnchorPointForPosition(false)
    detailInfo:setPosition(cc.p(layout:getContentSize().width / 2, layout:getContentSize().height * 0.25))
    layout:addChild(detailInfo)

    return layout
end

function WordInfoPopup:ctor()

    self.current_index = 1
    self.total_index = 6
    
    local backPopup = cc.Sprite:create("image/islandPopup/backforinfo.png")
    backPopup:setPosition(s_DESIGN_WIDTH / 2,s_DESIGN_HEIGHT / 2)
    self:addChild(backPopup)
    
    local button_close_clicked = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            playSound(s_sound_buttonEffect)
        elseif eventType == ccui.TouchEventType.ended then
            s_SCENE:removeAllPopups()
        end
    end

    local button_close = ccui.Button:create("image/friend/close.png","","")
    button_close:setScale9Enabled(true)
    button_close:setPosition(backPopup:getContentSize().width - 30 , backPopup:getContentSize().height - 30 )
    button_close:addTouchEventListener(button_close_clicked)
    backPopup:addChild(button_close,10)
    
    local button_back_clicked = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            playSound(s_sound_buttonEffect)
        elseif eventType == ccui.TouchEventType.ended then
            s_SCENE:removeAllPopups()
        end
    end

    local button_back = ccui.Button:create("image/islandPopup/backtolibrary.png","","")
    button_back:setScale9Enabled(true)
    button_back:setPosition(80, backPopup:getContentSize().height * 0.94)
    button_back:addTouchEventListener(button_back_clicked)
    backPopup:addChild(button_back,10)

    local bottom_sprite = cc.Sprite:create("image/islandPopup/bottom.png")
    bottom_sprite:setPosition(backPopup:getContentSize().width * 0.5,backPopup:getContentSize().height * 0.05)
    bottom_sprite:ignoreAnchorPointForPosition(false)
    bottom_sprite:setAnchorPoint(0.5,0.5)
    backPopup:addChild(bottom_sprite)

    local progress_sprite = cc.Sprite:create("image/islandPopup/progress.png")
    progress_sprite:setPosition(bottom_sprite:getContentSize().width * 0.5,bottom_sprite:getContentSize().height * 0.5)
    progress_sprite:ignoreAnchorPointForPosition(false)
    progress_sprite:setAnchorPoint(0.5,0.5)
    bottom_sprite:addChild(progress_sprite)

    self.progress_label = cc.Label:createWithSystemFont(self.current_index.."/"..self.total_index,"",30)
    self.progress_label:setPosition(progress_sprite:getContentSize().width * 0.5,progress_sprite:getContentSize().height * 0.5)
    progress_sprite:addChild(self.progress_label)
    
    local last_button_clicked = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            playSound(s_sound_buttonEffect)
        elseif eventType == ccui.TouchEventType.ended then
            self.changeToPage(false) 
        end
    end

    local last_button = ccui.Button:create("image/islandPopup/lastbegin.png","image/islandPopup/lastend.png","")
    last_button:setPosition(progress_sprite:getContentSize().width * 0.1,progress_sprite:getContentSize().height * 0.5)
    last_button:ignoreAnchorPointForPosition(false)
    last_button:setAnchorPoint(0.5,0.5)
    last_button:addTouchEventListener(last_button_clicked)
    progress_sprite:addChild(last_button)
    
    local next_button_clicked = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            playSound(s_sound_buttonEffect)
        elseif eventType == ccui.TouchEventType.ended then
            self.changeToPage(true) 
        end
    end

    local next_button = ccui.Button:create("image/islandPopup/nextbegin.png","image/islandPopup/nextend.png","")
    next_button:setPosition(progress_sprite:getContentSize().width * 0.9,progress_sprite:getContentSize().height * 0.5)
    next_button:ignoreAnchorPointForPosition(false)
    next_button:setAnchorPoint(0.5,0.5)
    next_button:addTouchEventListener(next_button_clicked)
    progress_sprite:addChild(next_button)

    
end

function WordInfoPopup:createInfo()
    
    local pageView = ccui.PageView:create()
    pageView:setTouchEnabled(true)
    pageView:setContentSize(cc.size(545, 683))
    local backgroundSize = cc.size(545, 683)
    pageView:setPosition(cc.p((s_DESIGN_WIDTH - backgroundSize.width) / 2 +
        (backgroundSize.width - pageView:getContentSize().width) / 2,
        (s_DESIGN_HEIGHT - backgroundSize.height) / 2 +
        (backgroundSize.height - pageView:getContentSize().height) / 2))
        
    for i = 1 , 3 do
        local layout = creatWordLayout("apple")
        pageView:addPage(layout)
    end 
    -- change to current index
    pageView:scrollToPage(1) 

    self.changeToPage = function (bool)
        if bool == true then
            local target = pageView:getCurPageIndex()
            pageView:scrollToPage(target + 1)
        elseif bool == false then
            local target = pageView:getCurPageIndex()
            pageView:scrollToPage(target - 1)
        end
    end
    
    local function pageViewEvent(sender, eventType)
        if eventType == ccui.PageViewEventType.turning then
            print("index"..pageView:getCurPageIndex() + 1)
            if pageView:getCurPageIndex() + 1 == 1 then
                pageView:removePageAtIndex(2)
            	local newLayout = creatWordLayout("apple")
                pageView:insertPage(newLayout,0)  
                pageView:scrollToPage(1)             
                self:changeNum(false)
            elseif pageView:getCurPageIndex() + 1 == 2 then
            
            elseif pageView:getCurPageIndex() + 1 == 3 then
                pageView:removePageAtIndex(0)
                local newLayout = creatWordLayout("apple")
                pageView:insertPage(newLayout,2)  
                pageView:scrollToPage(1) 
                self:changeNum(true)      
            end
        end
    end 

    pageView:addEventListener(pageViewEvent)

    self:addChild(pageView)
        
        
end

function WordInfoPopup:changeNum(bool)
	if bool == true then
        self.current_index = self.current_index + 1
        if self.current_index > self.total_index then
           self.current_index = 1
        end
        self.progress_label:setString(self.current_index.."/"..self.total_index)
	else 
        self.current_index = self.current_index - 1
        if self.current_index < 1  then
            self.current_index = self.total_index
        end
        self.progress_label:setString(self.current_index.."/"..self.total_index)
	end
end

return WordInfoPopup