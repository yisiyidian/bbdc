local LoadingView = class ("LoadingView", function()
    return cc.Layer:create()
end)



function LoadingView.create()

    local height = s_DESIGN_HEIGHT
    local bigWidth = s_DESIGN_WIDTH+2*s_DESIGN_OFFSET_WIDTH
    
    local layer = LoadingView.new()
    
    local backcolor = cc.LayerColor:create(cc.c4b(0,0,0,100),bigWidth,s_DESIGN_HEIGHT)
    backcolor:setAnchorPoint(0.5,0.5)
    backcolor:ignoreAnchorPointForPosition(false)
    layer:addChild(backcolor)
    
    local background = cc.Sprite:create('image/loading/loading-little-girl-background.png')
    background:ignoreAnchorPointForPosition(false)
    background:setAnchorPoint(0,0.5)
    background:setPosition(bigWidth /2 , height )
    backcolor:addChild(background)

    local leaf = cc.Sprite:create('image/loading/loading-little-girl-leaf.png')
    leaf:ignoreAnchorPointForPosition(false)
    leaf:setAnchorPoint(0.5,0.5)
    leaf:setPosition(background:getContentSize().width * 0.4 ,background:getContentSize().height * 0.66)    
    background:addChild(leaf)

    local sleep_girl = sp.SkeletonAnimation:create('spine/loading-little-girl.json','spine/loading-little-girl.atlas',1) 
    sleep_girl:setAnimation(0,'animation',true)
    sleep_girl:ignoreAnchorPointForPosition(false)
    sleep_girl:setAnchorPoint(0.5,0.5)
    sleep_girl:setPosition(leaf:getContentSize().width * 0.2 ,leaf:getContentSize().height * 0.3)    
    leaf:addChild(sleep_girl)
    
    return layer
end

return LoadingView