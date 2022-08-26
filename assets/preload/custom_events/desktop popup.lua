local winNumber = 0
local winX = 0
local winY = 0


function onCreate()
    makeLuaSprite('aText', 'AA', 0, 0)
    setObjectCamera('aText', 'other')

    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true);
    for i = 1, 4 do
        makeAnimatedLuaSprite('popup '..i, 'gimmick/Desktop Windows/Desktop windows '..i-1, -3000, -3000)
        addAnimationByPrefix('popup '..i, 'popup', (i-1)..' appear', 24, false)
        addAnimationByPrefix('popup '..i, 'popdown', (i-1)..' close', 24, false)
        scaleObject('popup '..i, 0.5, 0.5)
        setObjectCamera('popup '..i, 'other')
        setObjectOrder('popup '..i, 0+i)
        addLuaSprite('popup '..i, true);
    end
end

function onDestroy()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false);
end

function onEvent(name, value1, value2)
    if name == 'desktop popup' then
        if winNumber >= 4 then winNumber = 0 end
        winNumber = winNumber+1

        if middlescroll == false then
            winX = getRandomInt(700,1000)
        else
            winX = getRandomInt(400,700)
        end
        winY = getRandomInt(180,320)

        objectPlayAnimation('popup '..winNumber, 'popup', true)
        setProperty('popup '..winNumber..'.x', winX)
        setProperty('popup '..winNumber..'.y', winY)

    end
end

function onUpdatePost(elapsed)
    setProperty('aText.x', getMouseX('hud'))
    setProperty('aText.y', getMouseY('hud'))
    for i = 1, 4 do
        if mouseClicked() and objectsOverlap('aText', 'popup '..i ) and 
            not objectsOverlap('aText', 'popup '..i+1) and 
            not objectsOverlap('aText', 'popup '..i+2) and 
            not objectsOverlap('aText', 'popup '..i+3)
            then --
            setProperty('popup '..i..'.x', -3000)
            setProperty('popup '..i..'.y', -3000)
        end
    end
end




