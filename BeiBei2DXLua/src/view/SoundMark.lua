

local SoundMark = class("SoundMark", function()
    return cc.Layer:create()
end)

function SoundMark.create(wordname, soundmarkus, soundmarken)
    -- system variate
    local size = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
    
    local gap = 115
    
    local main = SoundMark.new()
    main:setContentSize(size.width, gap)
    main:setAnchorPoint(0.5,0.5)
    main:ignoreAnchorPointForPosition(false)

    local button_pronounce
    local button_wordname
    local button_country
    local button_soundmark_en
    local button_soundmark_us

    local changeCountry = function()
        if button_country:getTitleText() == "US" then
            button_country:setTitleText("EN")
            button_soundmark_en:setVisible(true)
            button_soundmark_us:setVisible(false)
        else
            button_country:setTitleText("US")
            button_soundmark_en:setVisible(false)
            button_soundmark_us:setVisible(true)
        end
    end
    
    local pronounce = function()
    	print("pronounce")
    end


    button_pronounce = ccui.Button:create()
    button_pronounce:loadTextures("image/button/soundButton1.png", "", "")
    button_pronounce:addTouchEventListener(pronounce)
    
    button_wordname = ccui.Button:create()
    button_wordname:setTitleText(wordname)
    button_wordname:setTitleFontSize(80)
    button_wordname:setTitleColor(cc.c4b(0,0,0,255))
    --button_wordname:setScale(math.min(400,button_wordname:getContentSize().width)/button_wordname:getContentSize().width)
    button_wordname:addTouchEventListener(pronounce)
    
    button_country = ccui.Button:create()
    button_country:loadTextures("image/button/USButton1.png", "", "")
    button_country:setTitleText("US")
    button_country:setTitleFontSize(30)
    button_country:addTouchEventListener(changeCountry)
    
    button_soundmark_us = ccui.Button:create()
    button_soundmark_us:setTitleText(soundmarkus)
    button_soundmark_us:setTitleFontSize(40)
    button_soundmark_us:setTitleColor(cc.c4b(0,0,0,255))
    --button_soundmark_us:setScale(math.min(400,button_soundmark_us:getContentSize().width)/button_soundmark_us:getContentSize().width)
    button_soundmark_us:addTouchEventListener(changeCountry)
    
    button_soundmark_en = ccui.Button:create()
    
    button_soundmark_en:setTitleText(soundmarken)
    button_soundmark_en:setTitleFontSize(40)
    button_soundmark_en:setTitleColor(cc.c4b(0,0,0,255))
    --button_soundmark_en:setScale(math.min(400,button_soundmark_en:getContentSize().width)/button_soundmark_en:getContentSize().width)
    button_soundmark_en:addTouchEventListener(changeCountry)
   
    -- handle position
    local max_text_length = math.max(button_wordname:getContentSize().width, button_soundmark_en:getContentSize().width, button_soundmark_us:getContentSize().width)
    local total_length = button_pronounce:getContentSize().width + max_text_length + 10
    local position_left_x = (size.width-total_length)/2 + button_pronounce:getContentSize().width/2
    local position_right_x = (size.width+total_length)/2 - max_text_length/2
    
    button_pronounce:setPosition(position_left_x,gap)
    button_wordname:setPosition(position_right_x,gap)
    button_country:setPosition(position_left_x,0)
    button_soundmark_us:setPosition(position_right_x,0)
    button_soundmark_en:setPosition(position_right_x,0)
    
    -- add node
    main:addChild(button_pronounce)
    main:addChild(button_wordname)
    main:addChild(button_country)
    main:addChild(button_soundmark_us)
    main:addChild(button_soundmark_en)
    
    button_soundmark_en:setVisible(false)

    return main
end


return SoundMark







