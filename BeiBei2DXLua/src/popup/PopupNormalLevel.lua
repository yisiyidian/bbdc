


local PopupNormalLevel = class("PopupNormalLevel", function()
    return cc.Layer:create()
end)

function PopupNormalLevel.create(levelKey)
    local layer = PopupNormalLevel.new(levelKey)
    return layer
end

function PopupNormalLevel:plotStar(node, starCount)
    local star1, star2, star3
    if starCount == 0 then
        star1 = cc.Sprite:create('image/chapter_level/greyStar.png')
        star2 = cc.Sprite:create('image/chapter_level/greyStar.png')
        star3 = cc.Sprite:create('image/chapter_level/greyStar.png')
    elseif starCount == 1 then
        star1 = cc.Sprite:create('image/chapter_level/yellowStar.png')
        star2 = cc.Sprite:create('image/chapter_level/greyStar.png')
        star3 = cc.Sprite:create('image/chapter_level/greyStar.png')
    elseif starCount == 2 then
        star1 = cc.Sprite:create('image/chapter_level/yellowStar.png')
        star2 = cc.Sprite:create('image/chapter_level/yellowStar.png')
        star3 = cc.Sprite:create('image/chapter_level/greyStar.png')
    elseif starCount == 3 then
        star1 = cc.Sprite:create('image/chapter_level/yellowStar.png')
        star2 = cc.Sprite:create('image/chapter_level/yellowStar.png')
        star3 = cc.Sprite:create('image/chapter_level/yellowStar.png')
    end
    
    
    star1:setPosition(node:getContentSize().width*0.3, node:getContentSize().height*0.67)
    star2:setPosition(node:getContentSize().width*0.5, node:getContentSize().height*0.71)
    star3:setPosition(node:getContentSize().width*0.7, node:getContentSize().height*0.67)
    node:addChild(star1)
    node:addChild(star2)
    node:addChild(star3)
end

function PopupNormalLevel:ctor(levelKey)
    self.ccbPopupNormalLevel = {}
    self.ccbPopupNormalLevel['onCloseButtonClicked'] = function()
        self:onCloseButtonClicked()
    end
    self.ccbPopupNormalLevel['onStudyButtonClicked'] = function()
        self:onStudyButtonClicked(levelKey)
    end
    self.ccbPopupNormalLevel['onTestButtonClicked'] = function()
        self:onTestButtonClicked()
    end

    self.ccb = {}
    self.ccb['popup_normal_level'] = self.ccbPopupNormalLevel
    local proxy = cc.CCBProxy:create()
    local node = CCBReaderLoad('res/ccb/popup_normal_level.ccbi', proxy, self.ccbPopupNormalLevel, self.ccb)
    node:setPosition(0,200)
    
    -- plot stars
    local levelData = s_CURRENT_USER:getUserLevelData(s_CURRENT_USER.currentChapterKey,levelKey)
    
    print('!!!----!!!')
    print_lua_table(s_CURRENT_USER.levels)
    print('chapteKey:'..s_CURRENT_USER.currentChapterKey..','..levelKey)
    self:plotStar(node, levelData.stars)
    
    -- plot word count
    local levelConfig = s_DATA_MANAGER.getLevelConfig(s_CURRENT_USER.bookKey,s_CURRENT_USER.currentChapterKey,levelKey)
    self.ccbPopupNormalLevel['_wordCount']:setString(levelConfig['word_num'])
    -- run action --
    local action1 = cc.MoveTo:create(0.3, cc.p(0,0))
    local action2 = cc.EaseBackOut:create(action1)
    node:runAction(action2)
    
    -- add girl hello animation
    local girl_hello = sp.SkeletonAnimation:create('spine/bb_hello_public.json', 'spine/bb_hello_public.atlas',1)
    girl_hello:setPosition(node:getContentSize().width/3, node:getContentSize().height*0.28)
    girl_hello:addAnimation(0, 'animation', true)
    node:addChild(girl_hello, 5)
    
    self:addChild(node)
end

function PopupNormalLevel:onCloseButtonClicked()
    s_logd('on close button clicked')
    s_SCENE:removeAllPopups()
end

function PopupNormalLevel:onStudyButtonClicked(levelKey)
    self:onCloseButtonClicked()
    s_logd('on study button clicked')
    
    local levelConfig = s_DATA_MANAGER.getLevelConfig(s_CURRENT_USER.bookKey,s_CURRENT_USER.currentChapterKey,levelKey)
    print(levelConfig.word_content)
    
    s_CorePlayManager.wordList = split(levelConfig.word_content, "|")

    s_CorePlayManager.enterStudyLayer()
end

function PopupNormalLevel:onTestButtonClicked()
    self:onCloseButtonClicked()
    s_logd('on test button clicked')
    
    
end

return PopupNormalLevel