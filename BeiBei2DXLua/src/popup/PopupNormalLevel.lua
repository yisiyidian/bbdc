


local PopupNormalLevel = class("PopupNormalLevel", function()
    return cc.Layer:create()
end)

function PopupNormalLevel.create(levelTag)
    local layer = PopupNormalLevel.new(levelTag)
    return layer
end

function PopupNormalLevel:plotStar(node, starCount)
    local star1, star2, star3
    if starCount == 0 then
        star1 = cc.Sprite:create('image/chapter_level/greyStar.png')
        star2 = cc.Sprite:create('image/chapter_level/greyStar.png')
        star3 = cc.Sprite:create('image/chapter_level/greyStar.png')
        
    end
    
    star1:setPosition(node:getContentSize().width/3, node:getContentSize().height*0.75)
    node:addChild(star1)
end

function PopupNormalLevel:ctor(levelTag)
    self.ccbPopupNormalLevel = {}
    self.ccbPopupNormalLevel['onCloseButtonClicked'] = self.onCloseButtonClicked
    self.ccbPopupNormalLevel['onStudyButtonClicked'] = self.onStudyButtonClicked
    self.ccbPopupNormalLevel['onTestButtonClicked'] = self.onTestButtonClicked

    self.ccb = {}
    self.ccb['popup_normal_level'] = self.ccbPopupNormalLevel

    local proxy = cc.CCBProxy:create()
    local node = CCBReaderLoad('res/ccb/popup_normal_level.ccbi', proxy, self.ccbPopupNormalLevel, self.ccb)
    node:setPosition(0,200)
    
    -- plot stars
    local levelData = s_CURRENT_USER:getUserLevelData('Chapter'..s_CURRENT_USER.currentChapterIndex,'level'..levelTag)
    print(levelData.hearts)
    self:plotStar(node, levelData.hearts)
    -- run action --
    local action1 = cc.MoveTo:create(0.3, cc.p(0,0))
    local action2 = cc.EaseBackOut:create(action1)
    node:runAction(action2)
    
    -- add girl hello animation
    local girl_hello = sp.SkeletonAnimation:create('spine/bb_hello_public.json', 'spine/bb_hello_public.atlas',1)
    girl_hello:setPosition(node:getContentSize().width/3, node:getContentSize().height/3)
    girl_hello:addAnimation(0, 'animation', true)
    node:addChild(girl_hello, 5)
    
    self:addChild(node)
end

function PopupNormalLevel:onCloseButtonClicked()
    s_logd('on close button clicked')
    s_SCENE:removeAllPopups()
end

function PopupNormalLevel:onStudyButtonClicked()
    s_logd('on study button clicked')
end

function PopupNormalLevel:onTestButtonClicked()
    s_logd('on test button clicked')
end

return PopupNormalLevel