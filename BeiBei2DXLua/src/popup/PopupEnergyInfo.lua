local  PopupEnergyInfo = class("PopupEnergyInfo", function()
    return cc.Layer:create()
end)



function PopupEnergyInfo.create(heartNumber)
    local layer = PopupEnergyInfo.new(heartNumber)
    return layer
end

function PopupEnergyInfo:ctor(heartNumber)

    self.energy_number = heartNumber
    
    
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

    self.ccb['energy_number'] = heartNumber

    
    local proxy = cc.CCBProxy:create()
    local node = CCBReaderLoad('res/ccb/righttopnode_heart.ccbi', proxy, self.ccbPopupEnergyInfo, self.ccb)
    self.ccbPopupEnergyInfo['title']:setString('贝贝的体力正在恢复！')
    self.ccbPopupEnergyInfo['subtitle']:setString('复习以前的关卡不耗费体力')
    self.ccbPopupEnergyInfo['energyNumber']:setString("123")
    self.ccbPopupEnergyInfo['energyNumber']:setScale(2)
    node:setPosition(0,600)
    self:addChild(node)
    
    local label_buyEnergy = cc.Label:createWithSystemFont("体力商店购买","",36)
    label_buyEnergy:setPosition(0.5 * self.ccbPopupEnergyInfo['buyButton']:getContentSize().width + 20,0.5 * self.ccbPopupEnergyInfo['buyButton']:getContentSize().height)
    self.ccbPopupEnergyInfo['buyButton']:addChild(label_buyEnergy)
    
    
    if self.energy_number >= 4 then
    json = 'spine/energy/tilizhi_full.json'
    atlas = 'spine/energy/tilizhi_full.atlas'
    elseif  self.energy_number > 0 then
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
    
    if  self.energy_number > 0 and  self.energy_number < 4 then
    local label_energyNumber = cc.Label:createWithSystemFont( self.energy_number,"",36)
    label_energyNumber:setColor(cc.c4b(255,255,255 ,255))
    label_energyNumber:setPosition(0.5 * heart:getContentSize().width ,0.5 * heart:getContentSize().height )
        label_energyNumber:setName("energyNumber")
    heart:addChild(label_energyNumber,1)
--      print("213215111111!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    end
    
    
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
        local introLayer = IntroLayer.create(self.energy_number)  
        s_SCENE:popup(introLayer)

        local action2 = cc.MoveTo:create(0.3, cc.p(0,-400))          
        introLayer:runAction(action2)
    end)

    
--    local animation = introLayer.ccbPopupEnergyBuy['popupWindow']:getChildByName("heart_animation")
--    local label = animation:getChildByName("energyNumber")
--    label:setString(self.energy_number )
--    introLayer.ccbPopupEnergyBuy['energy_number'] =  self.energy_number 

    
end

return PopupEnergyInfo