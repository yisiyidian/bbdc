require("Cocos2d")
require("Cocos2dConstants")

require("common.global")

local RBProgressBar = require("view.reviewboss.RBProgressBar")
local ReviewBossNode = require("view.reviewboss.ReviewBossNode")
local ReviewBossAlter = require("view.reviewboss.ReviewBossAlter")


local ReviewBossLayerII = class("ReviewBossLayerII", function ()
    return cc.Layer:create()
end)


function ReviewBossLayerII.create()
    math.randomseed(os.time())

    local layer = ReviewBossLayerII.new()

    local back = cc.Sprite:create("image/reviewbossscene/background_fxboss_dierguan.png")
    back:setPosition(s_DESIGN_WIDTH/2, s_DESIGN_HEIGHT/2)
    layer:addChild(back)      

    local rbProgressBar = RBProgressBar.create(#s_CorePlayManager.rbWordList, "red")
    rbProgressBar:setPosition(s_DESIGN_WIDTH/2, 1040)
    layer:addChild(rbProgressBar)

    local getRandomWordForRightWord = function(wordName)
        local currentWordIndex = nil
        tmp = {}
        for i = 1, #s_CorePlayManager.rbWordList do
            table.insert(tmp, s_CorePlayManager.rbWordList[i])
            if s_CorePlayManager.rbWordList[i] == wordName then
                currentWordIndex = i
            end
        end

        table.remove(tmp, currentWordIndex)

        local randomIndex = math.random(1, #tmp)
        local word1 = tmp[randomIndex]
        table.remove(tmp, randomIndex)
        local randomIndex = math.random(1, #tmp)
        local word2 = tmp[randomIndex]

        local rightIndex = math.random(1,1024)%3 + 1
        ans = {}
        ans[rightIndex] = wordName
        if rightIndex == 1 then
            ans[2] = word1
            ans[3] = word2
        elseif rightIndex == 2 then
            ans[3] = word1
            ans[1] = word2
        else
            ans[1] = word1
            ans[2] = word2
        end
        return ans
    end

    local rbCurrentWordIndex = 1
    local wordToBeTested = {}
    local sprite_array = {}
    for i = 1, #s_CorePlayManager.rbWordList do
        table.insert(wordToBeTested, s_CorePlayManager.rbWordList[i])
        local words = getRandomWordForRightWord(s_CorePlayManager.rbWordList[i])
        local tmp = {}
        for j = 1, 3 do
            local sprite = ReviewBossNode.create(words[j])
            if i == 1 then
                sprite:setPosition(cc.p(s_DESIGN_WIDTH/2 - 170 + 170*(j-1), 400))
                sprite:setScale(0.8)
            else
                sprite:setPosition(cc.p(s_DESIGN_WIDTH/2 - 200 + 200*(j-1), 140 - 350*(i-2)))
            end
            layer:addChild(sprite)
            tmp[j] = sprite
        end
        sprite_array[i] = tmp
    end

    local wordMeaningBeTestedNow = cc.Label:createWithSystemFont(s_WordPool[wordToBeTested[rbCurrentWordIndex]].wordMeaningSmall,"",40)
    wordMeaningBeTestedNow:setColor(cc.c4b(0,0,0,255))
    wordMeaningBeTestedNow:setPosition(s_DESIGN_WIDTH/2, s_DESIGN_HEIGHT*0.8)
    layer:addChild(wordMeaningBeTestedNow)

    local checkTouchIndex = function(location)
        for i = 1, #wordToBeTested do
            for j = 1, 3 do
                local sprite = sprite_array[i][j]
                if cc.rectContainsPoint(sprite:getBoundingBox(), location) then
                    return {x=i, y=j}
                end
            end
        end
        return {x=-1, y=-1}
    end

    local onTouchBegan = function(touch, event)
        local location = layer:convertToNodeSpace(touch:getLocation())
        local logic_location = checkTouchIndex(location)

        if logic_location.x == rbCurrentWordIndex then
            if wordToBeTested[logic_location.x] == sprite_array[logic_location.x][logic_location.y].character then
                rbProgressBar.addOne()
                sprite_array[logic_location.x][logic_location.y].right()
            else
                sprite_array[logic_location.x][logic_location.y].wrong()

                table.insert(wordToBeTested, wordToBeTested[rbCurrentWordIndex])
                local words = getRandomWordForRightWord(wordToBeTested[#wordToBeTested])
                local index_x, index_y = sprite_array[#sprite_array][1]:getPosition()
                local tmp = {}
                for j = 1, 3 do
                    local sprite = ReviewBossNode.create(words[j])
                    if rbCurrentWordIndex == #sprite_array then
                        print("aaa")
                        sprite:setPosition(cc.p(s_DESIGN_WIDTH/2 - 200 + 200*(j-1), index_y - 260))
                    else
                        sprite:setPosition(cc.p(s_DESIGN_WIDTH/2 - 200 + 200*(j-1), index_y - 350))
                    end

                    layer:addChild(sprite)
                    tmp[j] = sprite
                end
                table.insert(sprite_array, tmp)
            end

            if rbCurrentWordIndex < #wordToBeTested then
                s_TOUCH_EVENT_BLOCK_LAYER.lockTouch()
                for i = 1, #wordToBeTested do
                    for j = 1, 3 do
                        local sprite = sprite_array[i][j]
                        if i == rbCurrentWordIndex-1 then
                            local action0 = cc.DelayTime:create(0.1)
                            local action1 = cc.MoveBy:create(0.4, cc.p(60-30*j,200))
                            local action2 = cc.ScaleTo:create(0.4, 0)
                            local action3 = cc.Spawn:create(action1, action2)
                            sprite:runAction(cc.Sequence:create(action0, action3))
                        elseif i == rbCurrentWordIndex then
                            local action0 = cc.DelayTime:create(0.1)
                            local action1 = cc.MoveBy:create(0.4, cc.p(60-30*j,210))
                            local action2 = cc.ScaleTo:create(0.4, 0.6)
                            local action3 = cc.Spawn:create(action1, action2)
                            sprite:runAction(cc.Sequence:create(action0, action3))
                        elseif i == rbCurrentWordIndex + 1 then
                            local action0 = cc.DelayTime:create(0.1)
                            local action1 = cc.MoveBy:create(0.4, cc.p(60-30*j,260))
                            local action2 = cc.ScaleTo:create(0.4, 0.8)
                            local action3 = cc.Spawn:create(action1, action2)
                            sprite:runAction(cc.Sequence:create(action0, action3))
                        else
                            local action0 = cc.DelayTime:create(0.1)
                            local action1 = cc.MoveBy:create(0.4, cc.p(0,350))
                            sprite:runAction(cc.Sequence:create(action0, action1))
                        end
                    end
                end

                local action1 = cc.DelayTime:create(0.5)
                local action2 = cc.CallFunc:create(s_SCENE.touchEventBlockLayer.unlockTouch)
                layer:runAction(cc.Sequence:create(action1, action2))

                rbCurrentWordIndex = rbCurrentWordIndex + 1
                wordMeaningBeTestedNow:setString(s_WordPool[wordToBeTested[rbCurrentWordIndex]].wordMeaningSmall)
            else
                s_TOUCH_EVENT_BLOCK_LAYER.unlockTouch()

                local showAlter = function()
                    local alter = ReviewBossAlter.create()
                    alter:setPosition(s_DESIGN_WIDTH/2, s_DESIGN_HEIGHT/2)
                    layer:addChild(alter)
                end

                local action1 = cc.DelayTime:create(0.5)
                local action2 = cc.CallFunc:create(showAlter)
                local action3 = cc.Sequence:create(action1,action2)
                layer:runAction(action3)
            end            
        end

        return true
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)

    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

    return layer
end

return ReviewBossLayerII
