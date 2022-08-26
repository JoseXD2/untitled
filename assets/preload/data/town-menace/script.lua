local allowCountdown = false
local working = false
local page = {w = 0, h = 0}
local fileName = 'Town Menace'
local fax = 2
local fay = 2
local fax1 = 0
local fay1 = 0

local function endTHIS()
    doTweenAlpha('cutscene thing alpha', 'cutscene thing', 0, 1, 'linear')
    doTweenAlpha('enterButton alpha', 'enterButton', 0, 1, 'linear')
    doTweenAlpha('skipButton alpha', 'skipButton', 0, 1, 'linear')
    doTweenAlpha('border alpha', 'border', 0, 1, 'linear')
    playSound('UI/ui_menu_main_toggle', 15)
    working = false
end

local function makeCutsceneThing(tag, file, x, y, s, a)
    makeLuaSprite(tag, 'CUTSCENES/'..file, x, y)
    setObjectCamera(tag, 'other');      setProperty(tag..'.alpha', a)
    setProperty(tag..'.origin.x', -1);  setProperty(tag..'.origin.y', -1)
    setProperty(tag..'.scale.x', s);    setProperty(tag..'.scale.y', s)
    addLuaSprite(tag, true)
end

function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then --
        playMusic('MenuMusic', 0.5, true)
        makeCutsceneThing('cutscene thing', 'cutscene_'..fileName, -1, -1, 1.5, 1)
        makeCutsceneThing('border', 'Border', -11, -11, 4, 1)
        setProperty('border.antialiasing', false)
        makeCutsceneThing('enterButton', 'pressENTER', 20, screenHeight-100, 0.75, 0.5)
        makeCutsceneThing('skipButton', 'pressESC', 25, screenHeight-40, 0.75, 0.5)
        page.w = getProperty('cutscene thing.width') / fax
        page.h = getProperty('cutscene thing.height') / fay
        working = true
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end

function onUpdate()
    if working == true then
        if keyJustPressed('accept') then
            if fax1 >= fax-1 and fay1 >= fay-1 then endTHIS() 
            elseif fax1 < fax-1 then 
                fax1 = fax1+1; 
                playSound('UI/ui_menu_main_switch', 15)
                doTweenX('x tween', 'cutscene thing', -fax1*(page.w*getProperty('cutscene thing.scale.x')), 0.75, 'quadOut')
            elseif fax1 >= fax-1 then 
                fay1 = fay1+1; fax1 = 0;
                playSound('UI/ui_menu_main_switch', 15) 
                doTweenY('y tween1', 'cutscene thing', -fay1*(page.h*getProperty('cutscene thing.scale.y')), 0.75, 'quadOut')
                doTweenX('x tween1', 'cutscene thing', 0, 0.75, 'quadOut')
            end
        end
        if keyJustPressed('back') then endTHIS() end
    end
end

function onTweenCompleted(tag)
    if tag == 'cutscene thing alpha' then
        removeLuaSprite('cutscene thing', true); removeLuaSprite('skipButton', true)
        removeLuaSprite('enterButton', true); removeLuaSprite('border', true);  startCountdown()
    end
end