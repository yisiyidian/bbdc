require("Cocos2d")
require("Cocos2dConstants")
require("common.global")

local HomeLayer = class("HomeLayer", function ()
    return cc.Layer:create()
end)


function HomeLayer.create()
    -- data begin
    local bookName          = s_DATA_MANAGER.books[s_CURRENT_USER.bookKey].name
    local bookWordCount     = s_DATA_MANAGER.books[s_CURRENT_USER.bookKey].words
    local chapterIndex      = string.sub(s_CURRENT_USER.currentChapterKey,8,8)+1
    local chapterName       = s_DATA_MANAGER.chapters[chapterIndex].Name
    local levelIndex        = string.sub(s_CURRENT_USER.currentLevelKey,6,6)+1
    local levelName         = "第"..chapterIndex.."章 "..chapterName.." 第"..levelIndex.."关"
    local studyWordNum      = s_DATABASE_MGR.getStudyWordsNum(s_CURRENT_USER.bookKey)
    local graspWordNum      = s_DATABASE_MGR.getGraspWordsNum(s_CURRENT_USER.bookKey)
    -- data end
    
    local layer = HomeLayer.new()
    
    local offset = 500
    local viewIndex = 1
    
    local bigWidth = s_DESIGN_WIDTH+2*s_DESIGN_OFFSET_WIDTH

    local backColor = cc.LayerColor:create(cc.c4b(211,239,254,255), bigWidth, s_DESIGN_HEIGHT)  
    backColor:setAnchorPoint(0.5,0.5)
    backColor:ignoreAnchorPointForPosition(false)  
    backColor:setPosition(s_DESIGN_WIDTH/2, s_DESIGN_HEIGHT/2)
    layer:addChild(backColor)
    
    local setting_back
    
    local name = cc.Sprite:create("image/homescene/title_shouye_name.png")
    name:setPosition(bigWidth/2, s_DESIGN_HEIGHT-120)
    backColor:addChild(name)
   
    local button_left_clicked = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            if viewIndex == 1 then
                s_TOUCH_EVENT_BLOCK_LAYER.lockTouch()
            
                viewIndex = 2
            
                local action1 = cc.MoveTo:create(0.5, cc.p(s_DESIGN_WIDTH/2+offset,s_DESIGN_HEIGHT/2))
                backColor:runAction(action1)

                local action2 = cc.MoveTo:create(0.5, cc.p(s_LEFT_X+offset,s_DESIGN_HEIGHT/2))
                local action3 = cc.CallFunc:create(s_TOUCH_EVENT_BLOCK_LAYER.unlockTouch)
                setting_back:runAction(cc.Sequence:create(action2, action3))
            else
                s_TOUCH_EVENT_BLOCK_LAYER.lockTouch()
                
                viewIndex = 1

                local action1 = cc.MoveTo:create(0.5, cc.p(s_DESIGN_WIDTH/2,s_DESIGN_HEIGHT/2))
                backColor:runAction(action1)

                local action2 = cc.MoveTo:create(0.5, cc.p(s_LEFT_X,s_DESIGN_HEIGHT/2))
                local action3 = cc.CallFunc:create(s_TOUCH_EVENT_BLOCK_LAYER.unlockTouch)
                setting_back:runAction(cc.Sequence:create(action2, action3))
            end
        end
    end

    local button_left = ccui.Button:create("image/homescene/main_set.png","image/homescene/main_set.png","")
    button_left:setPosition((bigWidth-s_DESIGN_WIDTH)/2+50, s_DESIGN_HEIGHT-120)
    button_left:addTouchEventListener(button_left_clicked)
    backColor:addChild(button_left)
    
    local button_right_clicked = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then

        end
    end
    
    local button_right = ccui.Button:create("image/homescene/main_friends.png","image/homescene/main_friends.png","")
    button_right:setPosition((bigWidth-s_DESIGN_WIDTH)/2+s_DESIGN_WIDTH-50, s_DESIGN_HEIGHT-120)
    button_right:addTouchEventListener(button_right_clicked)
    backColor:addChild(button_right)   

    local book_back = cc.Sprite:create("image/homescene/book_back_whiteblue.png")
    book_back:setPosition(bigWidth/2, s_DESIGN_HEIGHT/2+30)
    backColor:addChild(book_back)
    
    local book_face = cc.Sprite:create("image/homescene/book_front_blue.png")
    book_face:setPosition(237.78, 261.17)
    book_back:addChild(book_face)

    local has_study = cc.ProgressTimer:create(cc.Sprite:create("image/homescene/book_front_blue_xuexi.png"))
    has_study:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    has_study:setMidpoint(cc.p(1, 0))
    has_study:setBarChangeRate(cc.p(0, 1))
    has_study:setPosition(book_face:getContentSize().width/2, book_face:getContentSize().height/2)
    has_study:setPercentage(100 * studyWordNum / bookWordCount)
--    has_study:setPercentage(40)
    book_face:addChild(has_study)
    
    local has_grasp = cc.ProgressTimer:create(cc.Sprite:create("image/homescene/book_front_blue_zhangwo.png"))
    has_grasp:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    has_grasp:setMidpoint(cc.p(1, 0))
    has_grasp:setBarChangeRate(cc.p(0, 1))
    has_grasp:setPosition(book_face:getContentSize().width/2, book_face:getContentSize().height/2)
    has_grasp:setPercentage(100 * graspWordNum / bookWordCount)
--    has_grasp:setPercentage(30)
    book_face:addChild(has_grasp)
    
    local book_back_width = book_back:getContentSize().width
    
    local label1 = cc.Label:createWithSystemFont(bookName.."词汇","",28)
    label1:setColor(cc.c4b(255,255,255,255))
    label1:setPosition(book_back_width/2, 350)
    book_back:addChild(label1)
    
    local label2 = cc.Label:createWithSystemFont(bookWordCount.."词","",20)
    label2:setColor(cc.c4b(255,255,255,255))
    label2:setPosition(book_back_width/2, 320)
    book_back:addChild(label2)
    
    local label3 = cc.Label:createWithSystemFont("学习"..studyWordNum.."词","",34)
    label3:setColor(cc.c4b(255,255,255,255))
    label3:setPosition(book_back_width/2, 210)
    book_back:addChild(label3)
    
    local label4 = cc.Label:createWithSystemFont("掌握"..graspWordNum.."词","",34)
    label4:setColor(cc.c4b(255,255,255,255))
    label4:setPosition(book_back_width/2, 150)
    book_back:addChild(label4)
    
--    local button_change_clicked = function(sender, eventType)
--        if eventType == ccui.TouchEventType.began then
--
--        end
--    end
--    
--    local button_change = ccui.Button:create("image/homescene/main_switchbutton.png","image/homescene/main_switchbutton.png","")
--    button_change:setPosition(10, container:getContentSize().height/2)
--    button_change:addTouchEventListener(button_change_clicked)
--    container:addChild(button_change)
    
    local label = cc.Label:createWithSystemFont(levelName,"",28)
    label:setColor(cc.c4b(0,0,0,255))
    label:setPosition(bigWidth/2, 280)
    backColor:addChild(label)
    
    local button_play_clicked = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            s_CorePlayManager.enterLevelLayer()
        end
    end

    local button_play = ccui.Button:create("image/homescene/main_play.png","image/homescene/main_play.png","")
    button_play:setTitleText("继续闯关   》")
    button_play:setTitleFontSize(30)
    button_play:setPosition(bigWidth/2, 200)
    button_play:addTouchEventListener(button_play_clicked)
    backColor:addChild(button_play)

    local button_data
    local isDataShow = false
    local button_data_clicked = function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            if isDataShow then
                isDataShow = false
                button_data:runAction(cc.MoveTo:create(0.5,cc.p(bigWidth/2, 0)))
            else
                isDataShow = true
                button_data:runAction(cc.MoveTo:create(0.5,cc.p(bigWidth/2, s_DESIGN_HEIGHT-300)))
            end
        end
    end

    button_data = ccui.Button:create("image/homescene/main_bottom.png","image/homescene/main_bottom.png","")
    button_data:setAnchorPoint(0.5,0)
    button_data:setPosition(bigWidth/2, 0)
    button_data:addTouchEventListener(button_data_clicked)
    backColor:addChild(button_data)
    
    local data_back = cc.LayerColor:create(cc.c4b(255,255,255,255), bigWidth, s_DESIGN_HEIGHT)  
    data_back:setAnchorPoint(0.5,1)
    data_back:ignoreAnchorPointForPosition(false)  
    data_back:setPosition(button_data:getContentSize().width/2, 0)
    button_data:addChild(data_back)
    
    local data_name = cc.Label:createWithSystemFont("数据","",28)
    data_name:setColor(cc.c4b(0,0,0,255))
    data_name:setPosition(button_data:getContentSize().width/2+30, button_data:getContentSize().height/2-5)
    button_data:addChild(data_name)
    
    
    -- setting ui
    setting_back = cc.Sprite:create("image/homescene/setup_background.png")
    setting_back:setAnchorPoint(1,0.5)
    setting_back:setPosition(s_LEFT_X, s_DESIGN_HEIGHT/2)
    layer:addChild(setting_back)
    
    
    local logo_name = {"head","book","photo","feedback","information","logout"}
    local label_name = {"游客1234","选择书籍", "拍摄头像", "用户反馈", "完善个人信息", "登出游戏"}
    for i = 1, 6 do
        local button_back_clicked = function(sender, eventType)
            if eventType == ccui.TouchEventType.began then
                print(label_name[i])
                if label_name[i] == "选择书籍" then
                    s_CorePlayManager.enterBookLayer()
                elseif label_name[i] == "登出游戏" then
                    
                else
                    
                end
            end
        end

        local button_back = ccui.Button:create("image/homescene/setup_button.png","image/homescene/setup_button.png","")
        button_back:setAnchorPoint(0, 1)
        button_back:setPosition(0, s_DESIGN_HEIGHT-button_back:getContentSize().height * (i - 1) - 20)
        button_back:addTouchEventListener(button_back_clicked)
        setting_back:addChild(button_back)
        
        local logo = cc.Sprite:create("image/homescene/setup_"..logo_name[i]..".png")
        logo:setPosition(button_back:getContentSize().width-offset+50, button_back:getContentSize().height/2)
        button_back:addChild(logo)
        
        local label = cc.Label:createWithSystemFont(label_name[i],"",28)
        label:setColor(cc.c4b(0,0,0,255))
        label:setAnchorPoint(0, 0.5)
        label:setPosition(button_back:getContentSize().width-offset+100, button_back:getContentSize().height/2)
        button_back:addChild(label)
        
        local split = cc.Sprite:create("image/homescene/setup_line.png")
        split:setAnchorPoint(0.5,0)
        split:setPosition(button_back:getContentSize().width/2, 0)
        button_back:addChild(split)
    end
    
    local setting_shadow = cc.Sprite:create("image/homescene/setup_shadow.png")
    setting_shadow:setAnchorPoint(1,0.5)
    setting_shadow:setPosition(setting_back:getContentSize().width, setting_back:getContentSize().height/2)
    setting_back:addChild(setting_shadow)
    
   
    local moveLength = 100
    local moved = false
    local start_x = nil
    local onTouchBegan = function(touch, event)
        local location = layer:convertToNodeSpace(touch:getLocation())
        start_x = location.x
        moved = false
        return true
    end
    
    local onTouchMoved = function(touch, event)
        if moved then
            return
        end
    
        local location = layer:convertToNodeSpace(touch:getLocation())
        local now_x = location.x
        if now_x - moveLength > start_x then
            if viewIndex == 1 then
                s_TOUCH_EVENT_BLOCK_LAYER.lockTouch()

                viewIndex = 2

                local action1 = cc.MoveTo:create(0.5, cc.p(s_DESIGN_WIDTH/2+offset,s_DESIGN_HEIGHT/2))
                backColor:runAction(action1)

                local action2 = cc.MoveTo:create(0.5, cc.p(s_LEFT_X+offset,s_DESIGN_HEIGHT/2))
                local action3 = cc.CallFunc:create(s_TOUCH_EVENT_BLOCK_LAYER.unlockTouch)
                setting_back:runAction(cc.Sequence:create(action2, action3))
            end
        elseif now_x + moveLength < start_x then
            if viewIndex == 2 then
                s_TOUCH_EVENT_BLOCK_LAYER.lockTouch()

                viewIndex = 1

                local action1 = cc.MoveTo:create(0.5, cc.p(s_DESIGN_WIDTH/2,s_DESIGN_HEIGHT/2))
                backColor:runAction(action1)

                local action2 = cc.MoveTo:create(0.5, cc.p(s_LEFT_X,s_DESIGN_HEIGHT/2))
                local action3 = cc.CallFunc:create(s_TOUCH_EVENT_BLOCK_LAYER.unlockTouch)
                setting_back:runAction(cc.Sequence:create(action2, action3))
            end
        end
    end
 
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

    return layer
end

return HomeLayer
