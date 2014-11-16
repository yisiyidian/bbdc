local  PopupEnergyInfo = class("PopupEnergyInfo", function()
    return cc.Layer:create()
end)



function PopupEnergyInfo.create()
    local layer = PopupEnergyInfo.new()
    return layer
end

function PopupEnergyInfo:ctor()  
    local json = ''
    local atlas = ''
--    local min = time_betweenServerAndEnergy / 60
--    local sec = time_betweenServerAndEnergy % 60
  --  print("213215111111!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
     self.ccbPopupEnergyInfo = {}
        
    self.ccbPopupEnergyInfo['onCloseButtonClicked'] = function()
         self:onCloseButtonClicked()
     end
     
    self.ccbPopupEnergyInfo['onBuyButtonClicked'] = function()
        self:onBuyButtonClicked()
     end

    self.ccb = {} 
    self.ccb['rightTopNode_Heart'] = self.ccbPopupEnergyInfo
    self.ccb['title'] = self.ccbPopupEnergyInfo_title
    self.ccb['subtitle'] = self.ccbPopupEnergyInfo_subtitle
    -- full or xx:xx
    self.ccb['energyNumber'] = self.ccbPopupEnergyInfo_energyNumber
    self.ccb['closeButton'] = self.ccbPopupEnergyInfo_closeButton
    self.ccb['buyButton'] = self.ccbPopupEnergyInfo_buyButton
    self.ccb['popupWindow'] = self.ccbPopupEnergyInfo_popupWindow

    self.ccb['energy_number'] = s_CURRENT_USER.energyCount 

    
    local proxy = cc.CCBProxy:create()
    local node = CCBReaderLoad('res/ccb/righttopnode_heart.ccbi', proxy, self.ccbPopupEnergyInfo, self.ccb)
    self.ccbPopupEnergyInfo['title']:setString('贝贝的体力正在恢复！')
    self.ccbPopupEnergyInfo['subtitle']:setString('复习以前的关卡不耗费体力')
    self.ccbPopupEnergyInfo['energyNumber']:setString(s_CURRENT_USER.energyCount)
    self.ccbPopupEnergyInfo['energyNumber']:setScale(2)
    node:setPosition(0,600)
    self:addChild(node)
    
    local action1 = cc.MoveTo:create(0.3, cc.p(0,0))
    local action2 = cc.EaseBackOut:create(action1)
    node:runAction(action2)
    
    local label_buyEnergy = cc.Label:createWithSystemFont("体力商店购买","",36)
    label_buyEnergy:setPosition(0.5 * self.ccbPopupEnergyInfo['buyButton']:getContentSize().width + 20,0.5 * self.ccbPopupEnergyInfo['buyButton']:getContentSize().height)
    self.ccbPopupEnergyInfo['buyButton']:addChild(label_buyEnergy)
    
    --animation init
    if s_CURRENT_USER.energyCount >= s_energyMaxCount then
    json = 'spine/energy/tilizhi_full.json'
    atlas = 'spine/energy/tilizhi_full.atlas'
    elseif  s_CURRENT_USER.energyCount > 0 then
    json = 'spine/energy/tilizhi_recovery.json' 
    atlas = 'spine/energy/tilizhi_recovery.atlas'
    else
    json = 'spine/energy/tilizhi_no.json'
    atlas = 'spine/energy/tilizhi_no.atlas'
    end
    
    local heart = sp.SkeletonAnimation:create(json,atlas, 1)
    heart:setAnimation(0,'animation',true)
    heart:ignoreAnchorPointForPosition(false)
    heart:setAnchorPoint(0.5,0.5)
    heart:setPosition(0.5 * self.ccbPopupEnergyInfo['popupWindow']:getContentSize().width ,0.5 * self.ccbPopupEnergyInfo['popupWindow']:getContentSize().height  + 30)
    heart:setName("heart_animation")
    self.ccbPopupEnergyInfo['popupWindow']:addChild(heart) 
    
    -- number on heart
    local label_energyNumber = cc.Label:createWithSystemFont( "","",36)
    label_energyNumber:setColor(cc.c4b(255,255,255 ,255))
    label_energyNumber:setPosition(0.5 * heart:getContentSize().width ,0.5 * heart:getContentSize().height )
    label_energyNumber:setName("energyNumber")
    heart:addChild(label_energyNumber,1)
    
    
    
    local function update(delta)
    -- update timer
        local time_betweenServerAndEnergy = s_CURRENT_USER.serverTime - s_CURRENT_USER.energyLastCoolDownTime
        local min = time_betweenServerAndEnergy / 60
        local sec = time_betweenServerAndEnergy % 60
        
        if s_CURRENT_USER.energyCount >= s_energyMaxCount then 
                if json == 'spine/energy/tilizhi_recovery.json'  or json == 'spine/energy/tilizhi_no.json' then
                local change = self.ccbPopupEnergyInfo['popupWindow']:removeChildByName("heart_animation")   
                json = 'spine/energy/tilizhi_full.json'
                atlas = 'spine/energy/tilizhi_full.atlas'
                local replace = sp.SkeletonAnimation:create(json,atlas, 1)
                replace:setAnimation(0,'animation',true)
                replace:ignoreAnchorPointForPosition(false)
                replace:setAnchorPoint(0.5,0.5)
                replace:setPosition(0.5 * self.ccbPopupEnergyInfo['popupWindow']:getContentSize().width ,0.5 * self.ccbPopupEnergyInfo['popupWindow']:getContentSize().height  + 30)
                replace:setName("heart_animation")
                self.ccbPopupEnergyInfo['popupWindow']:addChild(replace)  
                end
                
                local animation = self.ccbPopupEnergyInfo['popupWindow']:getChildByName("heart_animation")
                local label = animation:getChildByName("energyNumber")
                if label ~= nil then
                label:setString("")
                end   
                -- xx:xx => full
                self.ccbPopupEnergyInfo['energyNumber']:setString("full")                 
        elseif  s_CURRENT_USER.energyCount > 0 then 
            if json == 'spine/energy/tilizhi_no.json' then
                local change = self.ccbPopupEnergyInfo['popupWindow']:removeChildByName("heart_animation")   
                json = 'spine/energy/tilizhi_recovery.json'
                atlas = 'spine/energy/tilizhi_recovery.atlas'
                local replace = sp.SkeletonAnimation:create(json,atlas, 1)
                replace:setAnimation(0,'animation',true)
                replace:ignoreAnchorPointForPosition(false)
                replace:setAnchorPoint(0.5,0.5)
                replace:setPosition(0.5 * self.ccbPopupEnergyInfo['popupWindow']:getContentSize().width ,0.5 * self.ccbPopupEnergyInfo['popupWindow']:getContentSize().height  + 30)
                replace:setName("heart_animation")
                self.ccbPopupEnergyInfo['popupWindow']:addChild(replace)
                
                -- xx:xx 
                self.ccbPopupEnergyInfo['energyNumber']:setString(string.format("%d",min) ..":"..string.format("%d",sec))
            end
        else
            -- s_CURRENT_USER.energyCount == 0
            -- xx:xx
            self.ccbPopupEnergyInfo['energyNumber']:setString(string.format("%d",min) ..":"..string.format("%d",sec))
            local animation = self.ccbPopupEnergyInfo['popupWindow']:getChildByName("heart_animation")
            local label = animation:getChildByName("energyNumber")
            if label ~= nil then
                label:setString("")
            end       
        end
    end


    self:scheduleUpdateWithPriorityLua(update, 0) 

    
    
end



function PopupEnergyInfo:onCloseButtonClicked()
    s_logd('on close button clicked')
    s_SCENE:removeAllPopups()
end

function PopupEnergyInfo:onBuyButtonClicked()
 --   s_logd('on buy button clicked')
 
--    local action1 = cc.MoveTo:create(10, cc.p(0,-600))          
--    self:runAction(action1)  
    local action1 = cc.MoveTo:create(0.3, cc.p(0,600))      
    self:runAction(action1) 

 
    s_SCENE:callFuncWithDelay(0.3,function()
        local IntroLayer = require("popup/PopupEnergyBuy")
        local introLayer = IntroLayer.create()  
        s_SCENE:popup(introLayer)

--        local action2 = cc.MoveTo:create(0.3, cc.p(0,-600))          
--        introLayer:runAction(action2)
    end)

    
--    local animation = introLayer.ccbPopupEnergyBuy['popupWindow']:getChildByName("heart_animation")
--    local label = animation:getChildByName("energyNumber")
--    label:setString(self.energy_number )
--    introLayer.ccbPopupEnergyBuy['energy_number'] =  self.energy_number 

    
end

return PopupEnergyInfo