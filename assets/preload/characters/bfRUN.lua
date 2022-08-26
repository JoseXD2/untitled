local x = 75
local y = 125
local x2 = 15
local y2 = 80
local a = 0
local char = 'boyfriend'
function onCreate()
    makeAnimatedLuaSprite('bfRunARM', 'characters/bfRUN_Arm', getProperty(char..'.x') + x2, getProperty(char..'.y') + y2)
    addAnimationByPrefix('bfRunARM', 'run22', 'BFArm2_Anim instance 1', 24, true)
    addLuaSprite('bfRunARM', false)
    makeAnimatedLuaSprite('bfBODY', 'characters/bfRUN_legs', getProperty(char..'.x') + x, getProperty(char..'.y') + y)
    addAnimationByPrefix('bfBODY', 'run2', 'BFLegs_Run', 24, true)
    addLuaSprite('bfBODY', false)
end

function onUpdate()
    setProperty('bfBODY.alpha', getProperty(char..'.alpha'))
    setProperty('bfBODY.visible', getProperty(char..'.visible'))
    setProperty('bfBODY.x', getProperty(char..'.x') + x)
    setProperty('bfBODY.y', getProperty(char..'.y') + y)

    if getProperty(char..'.visible') == true and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
        setProperty('bfRunARM.visible', true)
        if a == 0 then
            objectPlayAnimation('bfRunARM', 'run22', true)
            objectPlayAnimation('bfBODY', 'run2', true)
            a = 1
        end
    else
        setProperty('bfRunARM.visible', false)
        objectPlayAnimation('bfRunARM', 'run1', true)
        a = 0
    end
    setProperty('bfRunARM.alpha', getProperty(char..'.alpha'))
    
    setProperty('bfRunARM.x', getProperty(char..'.x') + x2)
    setProperty('bfRunARM.y', getProperty(char..'.y') + y2)
end