require("Cocos2d")
require("Cocos2dConstants")
require("common.global")

local PersonalInfo = class("PersonalInfo", function()
    return cc.Layer:create()
end)

function PersonalInfo.create()
    local layer = PersonalInfo.new()
    return layer
end

function PersonalInfo:ctor()
    self:initHead()
    local currentIndex = 4
    local moved = false
    local start_y = nil
    local colorArray = {cc.c4b(56,182,236,255 ),cc.c4b(238,75,74,255 ),cc.c4b(251,166,24,255 ),cc.c4b(143,197,46,255 )}
    local titleArray = {'单词掌握统计','单词学习增长','登陆贝贝天数','学习效率统计'}
    local intro_array = {}
    for i = 1,4 do
        
        local intro = cc.LayerColor:create(colorArray[5-i], s_RIGHT_X - s_LEFT_X, s_DESIGN_HEIGHT)
        intro:ignoreAnchorPointForPosition(false)
        intro:setAnchorPoint(0.5,0.5)
        if i == 4 then
            intro:setPosition(s_DESIGN_WIDTH/2,s_DESIGN_HEIGHT/2)
        else
            intro:setPosition(s_DESIGN_WIDTH/2,-s_DESIGN_HEIGHT*0.5)
        end     
               
        self:addChild(intro,0,string.format('back%d',i))
        if i > 1 then
            local scrollButton = cc.Sprite:create("image/PersonalInfo/scrollHintButton.png")
            scrollButton:setPosition(s_DESIGN_WIDTH/2  ,s_DESIGN_HEIGHT * 0.08)
            scrollButton:setLocalZOrder(1)
            intro:addChild(scrollButton)
            local move = cc.Sequence:create(cc.MoveBy:create(0.5,cc.p(0,-30)),cc.MoveBy:create(0.5,cc.p(0,30)))
            scrollButton:runAction(cc.RepeatForever:create(move))
        
        end
        local title = cc.Label:createWithSystemFont(titleArray[5-i],'',36)
        title:setPosition(0.5 * s_DESIGN_WIDTH,0.75 * s_DESIGN_HEIGHT)
        title:setColor(cc.c3b(255,255,255))
        intro:addChild(title)
        table.insert(intro_array, intro)
    end
    
    
    
    
    self:PLVM()
    self:login()
    
    local onTouchBegan = function(touch, event)
        local location = self:convertToNodeSpace(touch:getLocation())
        start_y = location.y
        moved = false
        return true
    end
    local onTouchMoved = function(touch, event)
        if moved then
            return
        end
        local location = self:convertToNodeSpace(touch:getLocation())
        local now_y = location.y
        if now_y - 200 > start_y then

            if currentIndex > 1 then
                s_TOUCH_EVENT_BLOCK_LAYER.lockTouch()
                moved = true

                local action1 = cc.MoveTo:create(0.5, cc.p(s_DESIGN_WIDTH/2,s_DESIGN_HEIGHT*1.5))
                intro_array[currentIndex]:runAction(action1)

                local action2 = cc.MoveTo:create(0.5, cc.p(s_DESIGN_WIDTH/2,s_DESIGN_HEIGHT/2))
                local action3 = cc.CallFunc:create(s_TOUCH_EVENT_BLOCK_LAYER.unlockTouch)
                intro_array[currentIndex-1]:runAction(cc.Sequence:create(action2, action3))

                currentIndex = currentIndex - 1 
                
           
            end
        elseif now_y + 200 < start_y then
            if currentIndex < 4 then
                s_TOUCH_EVENT_BLOCK_LAYER.lockTouch()
                moved = true

                local action1 = cc.MoveTo:create(0.5, cc.p(s_DESIGN_WIDTH/2,-s_DESIGN_HEIGHT/2))
                intro_array[currentIndex]:runAction(action1)

                local action2 = cc.MoveTo:create(0.5, cc.p(s_DESIGN_WIDTH/2,s_DESIGN_HEIGHT/2))
                local action3 = cc.CallFunc:create(s_TOUCH_EVENT_BLOCK_LAYER.unlockTouch)
                intro_array[currentIndex+1]:runAction(cc.Sequence:create(action2, action3))

                currentIndex = currentIndex + 1
              
  
            end
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

function PersonalInfo:initHead()
    local back_color = cc.LayerColor:create(cc.c4b(255,255,255,150 ), s_RIGHT_X - s_LEFT_X, 0.2 * s_DESIGN_HEIGHT)
    back_color:ignoreAnchorPointForPosition(false)
    back_color:setAnchorPoint(0.5,1)
    back_color:setPosition(s_DESIGN_WIDTH/2 ,s_DESIGN_HEIGHT)
    back_color:setLocalZOrder(1)
    self:addChild(back_color) 

    --local node = self:getChildByName(string.format('back%d',1))

    local backButton = cc.Sprite:create("image/PersonalInfo/backButtonInPersonalInfo.png")
    backButton:ignoreAnchorPointForPosition(false)
    backButton:setAnchorPoint(0,0.5)
    backButton:setPosition(0 ,0.5 * back_color:getContentSize().height)
    backButton:setLocalZOrder(1)
    back_color:addChild(backButton)

    local girl = cc.Sprite:create("image/PersonalInfo/hj_personal_avatar.png")
    girl:setPosition(0.3 * back_color:getContentSize().width,0.5 * back_color:getContentSize().height)
    girl:setLocalZOrder(1)
    back_color:addChild(girl)

    local label_hint = cc.Label:createWithSystemFont("tester","",36)
    label_hint:ignoreAnchorPointForPosition(false)
    label_hint:setAnchorPoint(0,0)
    label_hint:setColor(cc.c4b(255 , 255, 255 ,255))
    label_hint:setPosition(0.5 * back_color:getContentSize().width,0.5 * back_color:getContentSize().height)
    label_hint:setLocalZOrder(2)
    back_color:addChild(label_hint)

    local label_study = cc.Label:createWithSystemFont("CET4","",36)
    label_study:ignoreAnchorPointForPosition(false)
    label_study:setAnchorPoint(0,1)
    label_study:setColor(cc.c4b(255 , 255, 255 ,255))
    label_study:setPosition(0.5 * back_color:getContentSize().width,0.5 * back_color:getContentSize().height)
    label_study:setLocalZOrder(2)
    back_color:addChild(label_study)

    --    local back_Button = cc.MenuItemImage("image/PersonalInfo/backButtonInPersonalInfo.png",
    --        "image/PersonalInfo/backButtonInPersonalInfo.png","image/PersonalInfo/backButtonInPersonalInfo.png")
    --    back_Button:setPosition(0,0)
    --    back_Button:setLocalZOrder(1)
    --    
    --    local menu = cc.Menu:create()
    --    menu:addChild(back_Button)
    --    
    --    local s = cc.Director:getInstance():getWinSize()
    --    menu:setPosition(cc.p(s.width/2, s.height/2))
    --
    --    self.addChild(menu)
end

function PersonalInfo:PLVM()
    local updateTime = 0
    local learnPercent = 0.6
    local masterPercent = 0.5
    local back = self:getChildByName('back4')
    local circleBack = cc.Sprite:create('image/PersonalInfo/PLVM/shuju_circle_white.png')
    circleBack:setPosition(0.5 * s_DESIGN_WIDTH,0.42 * s_DESIGN_HEIGHT)
    back:addChild(circleBack)
    
    local toLearn = cc.ProgressTo:create(learnPercent,learnPercent * 100)
    local toMaster = cc.ProgressTo:create(masterPercent,masterPercent * 100)
    
    local backProgress = cc.ProgressTimer:create(cc.Sprite:create('image/PersonalInfo/PLVM/shuju_circle_ligheblue.png'))
    backProgress:setPosition(0.5 * circleBack:getContentSize().width,0.5 * circleBack:getContentSize().height)
    backProgress:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    backProgress:setReverseDirection(true)
    backProgress:setPercentage(0)
    backProgress:runAction(toLearn)
    circleBack:addChild(backProgress)
    
    local circleBackBig = cc.Sprite:create('image/PersonalInfo/PLVM/shuju_ring_blue_big.png')
    circleBackBig:setPosition(0.5 * circleBack:getContentSize().width,0.5 * circleBack:getContentSize().height)
    circleBack:addChild(circleBackBig)
    
    local circleBackSmall = cc.Sprite:create('image/PersonalInfo/PLVM/shuju_ring_blue_small.png')
    circleBackSmall:setPosition(0.5 * circleBack:getContentSize().width,0.5 * circleBack:getContentSize().height)
    circleBack:addChild(circleBackSmall)
    
    local learnProgress = cc.ProgressTimer:create(cc.Sprite:create('image/PersonalInfo/PLVM/shuju_ring_blue_big_dark.png'))
    learnProgress:setPosition(0.5 * circleBack:getContentSize().width,0.5 * circleBack:getContentSize().height)
    learnProgress:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    learnProgress:setReverseDirection(true)
    learnProgress:setPercentage(0)
    learnProgress:runAction(cc.ProgressTo:create(learnPercent,learnPercent * 100))
    circleBack:addChild(learnProgress)
    
    local masterProgress = cc.ProgressTimer:create(cc.Sprite:create('image/PersonalInfo/PLVM/shuju_ring_blue_small_dark.png'))
    masterProgress:setPosition(0.5 * circleBack:getContentSize().width,0.5 * circleBack:getContentSize().height)
    masterProgress:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    masterProgress:setReverseDirection(true)
    masterProgress:setPercentage(0)
    masterProgress:runAction(toMaster)
    circleBack:addChild(masterProgress)
    
    local smallCircle1 = cc.Sprite:create('image/PersonalInfo/PLVM/shuju_smallcircle_blue1.png')
    smallCircle1:setScale(1,42 / 41)
    smallCircle1:setPosition(0.5 * circleBackBig:getContentSize().width,461.5)
    circleBackBig:addChild(smallCircle1)
    
    local smallCircle2 = cc.Sprite:create('image/PersonalInfo/PLVM/shuju_smallcircle_blue2.png')
    smallCircle2:setScale(1,42 / 41)
    smallCircle2:setPosition(0.5 * circleBackSmall:getContentSize().width,344)
    circleBackSmall:addChild(smallCircle2)
    
    local smallCircleTail = cc.Sprite:create('image/PersonalInfo/PLVM/shuju_smallcircle_blue1.png')
    smallCircleTail:setScale(1,42 / 41)
    smallCircleTail:setPosition(0.5 * circleBackBig:getContentSize().width + 220 * math.cos((0.5 + 2 * 0) * math.pi),0.5 * circleBackBig:getContentSize().height + 220 * math.sin((0.5 + 2 * 0) * math.pi))
    circleBackBig:addChild(smallCircleTail)
    
    local smallCircleTail2 = cc.Sprite:create('image/PersonalInfo/PLVM/shuju_smallcircle_blue2.png')
    smallCircleTail2:setScale(1,42 / 41)
    smallCircleTail2:setPosition(0.5 * circleBackSmall:getContentSize().width + 161 * math.cos((0.5 + 2 * 0) * math.pi),0.5 * circleBackSmall:getContentSize().height + 161 * math.sin((0.5 + 2 * 0) * math.pi))
    circleBackSmall:addChild(smallCircleTail2)
    
    local line = cc.LayerColor:create(cc.c4b(0,0,0,255),200,1)
    line:ignoreAnchorPointForPosition(false)
    line:setAnchorPoint(0.5,0.5)
    line:setPosition(0.5 * circleBack:getContentSize().width,0.5 * circleBack:getContentSize().height)
    circleBack:addChild(line)
    
    local label_study = cc.Label:createWithSystemFont("已学单词","",36)
    label_study:ignoreAnchorPointForPosition(false)
    label_study:setAnchorPoint(0.5,1)
    label_study:setColor(cc.c4b(0,0,0 ,255))
    label_study:setPosition(0.5 * circleBack:getContentSize().width,0.49 * circleBack:getContentSize().height)
    circleBack:addChild(label_study)
    
    local label_book = cc.Label:createWithSystemFont("高考","",28)
    label_book:ignoreAnchorPointForPosition(false)
    label_book:setAnchorPoint(0.5,1)
    label_book:setColor(cc.c4b(0,0,0 ,255))
    label_book:setPosition(0.5 * circleBack:getContentSize().width,0.4 * circleBack:getContentSize().height)
    circleBack:addChild(label_book)
    
    local label_percent = cc.Label:createWithSystemFont("0%","",48)
    label_percent:ignoreAnchorPointForPosition(false)
    label_percent:setAnchorPoint(0.5,0)
    label_percent:setColor(cc.c4b(0,0,0 ,255))
    label_percent:setPosition(0.5 * circleBack:getContentSize().width,0.5 * circleBack:getContentSize().height)
    circleBack:addChild(label_percent)
    
    local function update(delta)
        local per = '%'
        local str = string.format("%.1f%s",learnProgress:getPercentage(),per)
        label_percent:setString(str)
        smallCircleTail:setPosition(0.5 * circleBackBig:getContentSize().width + 220 * math.cos((0.5 + 0.02 * learnProgress:getPercentage()) * math.pi),0.5 * circleBackBig:getContentSize().height + 220 * math.sin((0.5 + 0.02 * learnProgress:getPercentage()) * math.pi))
        smallCircleTail2:setPosition(0.5 * circleBackSmall:getContentSize().width + 161 * math.cos((0.5 + 0.02 * masterProgress:getPercentage()) * math.pi),0.5 * circleBackSmall:getContentSize().height + 161 * math.sin((0.5 + 0.02 * masterProgress:getPercentage()) * math.pi))
    end
    self:scheduleUpdateWithPriorityLua(update, 0)
end

function PersonalInfo:PLVI()
    
end

function PersonalInfo:login()
    local back = self:getChildByName('back2')
    math.randomseed(os.time()) 
    local loginArray = {}
    local weekCount = 8
    local totalDay = 0
    local weekDay = {}
    for i = 1 , weekCount do 
        loginArray[i] = {}
        weekDay[i] = 0
        for j = 1,7 do
            loginArray[i][j] = math.random(0,1)
            if loginArray[i][j] == 1 then
                totalDay = totalDay + 1
                weekDay[i] = weekDay[i] + 1
            end
        end
    end
    --draw circle 
    for i = 1,7 do
        local str
        if loginArray[1][i] == 1 then
            str = 'res/image/PersonalInfo/PLVI/login.png'
        elseif i < 6 then
            str = 'res/image/PersonalInfo/PLVI/not_login.png'
        else
            str = 'res/image/PersonalInfo/PLVI/not_coming.png'
        end
        local dayRing = cc.ProgressTimer:create(cc.Sprite:create(str))
        dayRing:setPosition(0.5 * s_DESIGN_WIDTH,0.5 * s_DESIGN_HEIGHT)
        dayRing:setScale(1.0)
        dayRing:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
        dayRing:setReverseDirection(false)
        dayRing:setPercentage(100/7)
        dayRing:setRotation( 360 * (i-1) / 7)
        back:addChild(dayRing,0,string.format('day%d',i))
    end
    local center = cc.Sprite:create('res/image/PersonalInfo/PLVI/center.png')
    center:setPosition(0.5 * s_DESIGN_WIDTH,0.5 * s_DESIGN_HEIGHT)
    center:setScale(1.0)
    
    local line = cc.LayerColor:create(cc.c4b(0,0,0,255),center:getContentSize().width * 0.8,1)
    line:ignoreAnchorPointForPosition(false)
    line:setAnchorPoint(0.5,0.5)
    line:setPosition(0.5 * center:getContentSize().width,0.5 * center:getContentSize().height)
    center:addChild(line)
    
    local weekDayLabel = cc.Label:createWithSystemFont(string.format('本周 %d 天',weekDay[1]),'',40)
    weekDayLabel:setColor(cc.c3b(0,0,0))
    weekDayLabel:ignoreAnchorPointForPosition(false)
    weekDayLabel:setAnchorPoint(0.5,0)
    weekDayLabel:setPosition(0.5 * center:getContentSize().width,0.55 * center:getContentSize().height)
    center:addChild(weekDayLabel)
    
    local totalLabel = cc.Label:createWithSystemFont(string.format('累计登陆%d天',totalDay),'',28)
    totalLabel:setColor(cc.c3b(0,0,0))
    totalLabel:ignoreAnchorPointForPosition(false)
    totalLabel:setAnchorPoint(0.5,1)
    totalLabel:setPosition(0.5 * center:getContentSize().width,0.45 * center:getContentSize().height)
    center:addChild(totalLabel)
    
    back:addChild(center,1)
    --add button
    local menu = cc.Node:create()
    menu:setPosition(0, 0.2 * s_DESIGN_HEIGHT)
    back:addChild(menu)
    local selectButton = 1
    local rightButton = 1
    local button = {}
    for i = 1, weekCount do
        
        button[i] = ccui.Button:create()
        if i > 4 then
            button[i]:setVisible(false)
        end
        button[i]:setTouchEnabled(true)
        --add label on button
        local weekLabel = cc.Label:createWithSystemFont(string.format('%d周',weekCount + 1 - i),'',40)
        local yearLabel = cc.Label:createWithSystemFont('2014','',28)
        local dateLabel = cc.Label:createWithSystemFont('9.8~9.14','',24)
        local sun = cc.Sprite:create('res/image/PersonalInfo/login/wsy_suanzhong.png')
        
        if i > 1 then
            button[i]:loadTextures("res/image/PersonalInfo/login/wsy_chengseban.png", "res/image/PersonalInfo/login/wsy_chengseban.png", "")
            sun:setVisible(false)
        else 
            button[i]:loadTextures("res/image/PersonalInfo/login/wsy_baiban.png", "res/image/PersonalInfo/login/wsy_baiban.png", "")
            
            weekLabel:setString('本周')
            weekLabel:setColor(cc.c3b(255,103,0))
            dateLabel:setColor(cc.c3b(255,103,0))
            yearLabel:setColor(cc.c3b(255,103,0))
        end
        weekLabel:setPosition(0.5 * button[i]:getContentSize().width,button[i]:getContentSize().height * 0.7)
        button[i]:addChild(weekLabel,0,'week')
        yearLabel:setPosition(0.5 * button[i]:getContentSize().width,button[i]:getContentSize().height * 0.4)
        button[i]:addChild(yearLabel,0,'year')
        dateLabel:setPosition(0.5 * button[i]:getContentSize().width,button[i]:getContentSize().height * 0.2)
        button[i]:addChild(dateLabel,0,'date')
        sun:setPosition(0.5 * button[i]:getContentSize().width,button[i]:getContentSize().height)
        button[i]:addChild(sun,0,'sun')
        
        button[i]:setPosition((5-i)/5 * s_DESIGN_WIDTH,0)  
        menu:addChild(button[i])
        --button event
        local function touchEvent(sender,eventType)
            if eventType == ccui.TouchEventType.ended  and selectButton ~= i then
                button[selectButton]:getChildByName('sun'):setVisible(false)
                button[selectButton]:getChildByName('date'):setColor(cc.c3b(255,255,255))
                button[selectButton]:getChildByName('year'):setColor(cc.c3b(255,255,255))
                button[selectButton]:getChildByName('week'):setColor(cc.c3b(255,255,255))
                button[selectButton]:loadTextures("res/image/PersonalInfo/login/wsy_chengseban.png", "res/image/PersonalInfo/login/wsy_chengseban.png", "")
                selectButton = i
                s_logd(i)
                button[selectButton]:getChildByName('sun'):setVisible(true)
                button[selectButton]:getChildByName('date'):setColor(cc.c3b(255,103,0))
                button[selectButton]:getChildByName('year'):setColor(cc.c3b(255,103,0))
                button[selectButton]:getChildByName('week'):setColor(cc.c3b(255,103,0))
                button[selectButton]:loadTextures("res/image/PersonalInfo/login/wsy_baiban.png", "res/image/PersonalInfo/login/wsy_baiban.png", "")
                weekDayLabel:setString(string.format('本周 %d 天',weekDay[i]))
                for j = 1,7 do
                    local str
                    if loginArray[i][j] == 1 then
                        str = 'res/image/PersonalInfo/PLVI/login.png'
                    elseif j < 6 then
                        str = 'res/image/PersonalInfo/PLVI/not_login.png'
                    else
                        str = 'res/image/PersonalInfo/PLVI/not_coming.png'
                    end
                    local dayRing = back:getChildByName(string.format('day%d',j))
                    dayRing:removeFromParent()
                    dayRing = cc.ProgressTimer:create(cc.Sprite:create(str))
                    dayRing:setPosition(0.5 * s_DESIGN_WIDTH,0.5 * s_DESIGN_HEIGHT)
                    dayRing:setScale(1.0)
                    dayRing:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
                    dayRing:setReverseDirection(false)
                    dayRing:setPercentage(100/7)
                    dayRing:setRotation( 360 * (j-1) / 7)
                    back:addChild(dayRing,0,string.format('day%d',j))
                end 
            end
        end      
        button[i]:addTouchEventListener(touchEvent)
        
        --add front/back button
        if weekCount > 4 then  
            local menu1 = cc.Menu:create()
            menu1:setPosition(0,0)
            back:addChild(menu1,0,'menu')
             
            local frontButton = cc.MenuItemImage:create('res/image/PersonalInfo/login/back_button.png','res/image/PersonalInfo/login/back_button.png','res/image/PersonalInfo/login/back_button.png')
            --frontButton:loadTextures('res/image/PersonalInfo/login/back_button.png','res/image/PersonalInfo/login/back_button.png','')
            frontButton:setPosition(0.05 * s_DESIGN_WIDTH,0.5 * s_DESIGN_HEIGHT)
            --frontButton:setVisible(false)
            menu1:addChild(frontButton,0,'front')
            local backButton = cc.MenuItemImage:create('res/image/PersonalInfo/login/back_button.png','','')
            --backButton:loadTextures('res/image/PersonalInfo/login/back_button.png','res/image/PersonalInfo/login/back_button.png','')
            backButton:setPosition(0.05 * s_DESIGN_WIDTH,0.2 * s_DESIGN_HEIGHT)
            backButton:setVisible(false)
            menu1:addChild(backButton)
            
            --frontButton:setVisible(true)
            -- button event
            local function onFront(sender)
                --if eventType == ccui.TouchEventType.ended then
                    button[rightButton]:setVisible(false)
                    button[rightButton + 4]:setVisible(true)
                    menu:runAction(cc.MoveBy:create(0.2,cc.p(0.2 *s_DESIGN_WIDTH,0) ))
                    rightButton = rightButton + 1
                    
                    if rightButton >= weekCount - 6 and frontButton:isVisible() then
                        s_logd(rightButton)
                        frontButton:setVisible(false)
                        if frontButton:isVisible() then
                            s_logd('true')
                       else 
                            s_logd('false')
                       end
                        --frontButton:setScale(2)
                    end
                    if rightButton > 1 and  backButton:isVisible() == false then
                        backButton:setVisible(true)
                    end
                --end
            end
--            
            local function onBack(sender,eventType)
                --if eventType == ccui.TouchEventType.ended then
                    button[rightButton + 3]:setVisible(false)
                    button[rightButton - 1]:setVisible(true)
                    menu:runAction(cc.MoveBy:create(0.2,cc.p(-0.2 *s_DESIGN_WIDTH,0) ))
                    rightButton = rightButton - 1
                    if rightButton <= 1 then
                        backButton:setVisible(false)
                    end
                    if rightButton < weekCount - 3 then
                        frontButton:setVisible(true)
                    end
                --end
            end
            frontButton:registerScriptTapHandler(onFront)
            --frontButton:addTouchEventListener(onFront)
            backButton:registerScriptTapHandler(onBack)
            
        end
        
        
        
    end
    
end

return PersonalInfo