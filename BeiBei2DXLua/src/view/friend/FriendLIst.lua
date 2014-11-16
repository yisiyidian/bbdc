require("Cocos2d")
require("Cocos2dConstants")
require("common.global")

local FriendList = class("FriendList", function()
    return cc.Layer:create()
end)

function FriendList.create()
    local layer = FriendList.new()
    --layer.friend = friend
    return layer 
end

function FriendList:ctor()
    --local friendCount = #self.friend
    
    local function listViewEvent(sender, eventType)
        if eventType == ccui.ListViewEventType.ONSELECTEDITEM_START then
            print("select child index = ",sender:getCurSelectedIndex())
        end
    end
    
    self.array = {}
    for i = 1,5 do
        self.array[i] = string.format("ListView_item_%d",i - 1)
    end
    
    local back = cc.LayerColor:create(cc.c4b(208,212,215,255),s_RIGHT_X - s_LEFT_X,162 * 6)
    back:ignoreAnchorPointForPosition(false)
    back:setAnchorPoint(0.5,0.5)
    back:setPosition(0.5 * s_DESIGN_WIDTH,162 * 3)
    self:addChild(back)
    
    self:addList(200)
    
    local function update(delta)

    end


    self:scheduleUpdateWithPriorityLua(update, 0)
end

function FriendList:addList(index_list)
    self:removeChildByName('listView',true)
    local listView = ccui.ListView:create()
    -- set list view ex direction
    listView:setDirection(ccui.ScrollViewDir.vertical)
    listView:setBounceEnabled(false)
    listView:setBackGroundImageScale9Enabled(true)
    listView:setContentSize(cc.size(s_RIGHT_X - s_LEFT_X,162 * 6))
    listView:setPosition(0,0)
    self:addChild(listView,0,'listView')

    -- create model
    local default_button = ccui.Button:create('image/friend/friendRankButton.png', 'image/friend/friendRankButton.png')
    default_button:setName("Title Button")

    local default_item = ccui.Layout:create()
    default_item:setTouchEnabled(true)
    default_item:setContentSize(default_button:getContentSize())
    default_button:setPosition(cc.p(default_item:getContentSize().width / 2.0, default_item:getContentSize().height / 2.0))
    default_item:addChild(default_button)

    --set model
    listView:setItemModel(default_item)
    --local array = {}
    --add default item
    local count = #self.array
    s_logd("count = %d",count)
    for i = 1,math.floor(count) do
        listView:pushBackDefaultItem()
    end
    --insert default item
    for i = 1,math.floor(count) do
        listView:insertDefaultItem(0)
    end

    listView:removeAllChildren()

    --add custom item
    for i = 1,math.floor(count) do
        local custom_button = ccui.Button:create("image/friend/friendRankButton.png", "image/friend/friendRankButton.png")
        custom_button:setName("Title Button")
        custom_button:setScale9Enabled(true)
        custom_button:setContentSize(default_button:getContentSize())
        
        local custom_item = ccui.Layout:create()
        custom_item:setContentSize(custom_button:getContentSize())
        custom_button:setPosition(cc.p(custom_item:getContentSize().width / 2.0, custom_item:getContentSize().height / 2.0))
        custom_item:addChild(custom_button)

        listView:addChild(custom_item)
        --array[i] = listView:getIndex(custom_item)
        
        if(i == index_list + 1) then
            local custom_button = ccui.Button:create("image/friend/delete_friend_back.png", "image/friend/delete_friend_back.png")
            custom_button:setName("Title Button")
            custom_button:setScale9Enabled(true)
            custom_button:setContentSize(default_button:getContentSize())

            local custom_item = ccui.Layout:create()
            custom_item:setContentSize(custom_button:getContentSize())
            custom_button:setPosition(cc.p(custom_item:getContentSize().width / 2.0, custom_item:getContentSize().height / 2.0))
            custom_item:addChild(custom_button)
            listView:addChild(custom_item)
            local delete = cc.Sprite:create('image/friend/fri_delete.png')
            delete:setPosition(cc.p(custom_item:getContentSize().width / 2.0, custom_item:getContentSize().height / 2.0))
            custom_button:addChild(delete)
            local function touchEvent(sender,eventType)
                if eventType == ccui.TouchEventType.ended then
                    table.remove(self.array,listView:getCurSelectedIndex() + 1)
                    s_logd(self.array[listView:getCurSelectedIndex()])
                    self:addList(200)
                end
            end

            custom_button:addTouchEventListener(touchEvent)
            
        end
        local function touchEvent(sender,eventType)
            if eventType == ccui.TouchEventType.ended then
                s_logd(listView:getCurSelectedIndex())
                if(index_list == listView:getCurSelectedIndex()) then
                    self:addList(200)
                elseif(index_list > listView:getCurSelectedIndex()) then
                    self:addList(listView:getCurSelectedIndex())
                else
                    self:addList(listView:getCurSelectedIndex() - 1)
                end
            end
        end
    
        custom_button:addTouchEventListener(touchEvent)
        
        
        
    end

--    -- set item data
    local items_count = table.getn(listView:getItems())
    for i = 1,items_count do
        local item = listView:getItem(i - 1)
        local button = item:getChildByName("Title Button")
        local index = listView:getIndex(item)
        if (i ~= index_list + 2) then
        local str = 'n'
        local x = 3
        s_logd(index_list)
        if index_list < 2 then 
            x = 4 
        end
        local rankIndex = {}
        if index > index_list and index_list ~= 200 then
            rankIndex[i] = index
        else
            rankIndex[i] = index + 1
        end
        if index < x then
            str = string.format('%d',rankIndex[i])
        end
        local rankIcon = cc.Sprite:create(string.format('image/friend/fri_rank_%s.png',str))
        rankIcon:setPosition(0.08 * button:getContentSize().width,0.5 * button:getContentSize().height)
        button:addChild(rankIcon)
        
        local rankLabel = cc.Label:createWithSystemFont(string.format('%d',rankIndex[i]),'',36)
        rankLabel:setPosition(rankIcon:getContentSize().width / 2,rankIcon:getContentSize().width / 2)
        rankIcon:addChild(rankLabel)
        
        local head = cc.Sprite:create('image/PersonalInfo/hj_personal_avatar.png')
        head:setScale(0.8)
        head:setPosition(0.26 * button:getContentSize().width,0.5 * button:getContentSize().height)
        button:addChild(head)
        
        local fri_name = cc.Label:createWithSystemFont('Name','',32)
        fri_name:setColor(cc.c3b(0,0,0))
        fri_name:ignoreAnchorPointForPosition(false)
        fri_name:setAnchorPoint(0,0)
        fri_name:setPosition(0.42 * button:getContentSize().width,0.52 * button:getContentSize().height)
        button:addChild(fri_name)
        
        local fri_word = cc.Label:createWithSystemFont('已学单词总数：300','',24)
        fri_word:setColor(cc.c3b(0,0,0))
        fri_word:ignoreAnchorPointForPosition(false)
        fri_word:setAnchorPoint(0,1)
        fri_word:setPosition(0.42 * button:getContentSize().width,0.48 * button:getContentSize().height)
        button:addChild(fri_word)
        local str = 'image/friend/fri_jiantouxia.png'
        if (i == index_list + 1) then
            str = 'image/friend/fri_jiantoushang.png'
        end
        local arrow = cc.Sprite:create(str)
        arrow:setPosition(0.9 * button:getContentSize().width,0.5 * button:getContentSize().height)
        button:addChild(arrow)
        
        --button:setTitleText(array[index + 1])
        end
    end
    
    listView:setItemsMargin(2.0)
end

return FriendList
