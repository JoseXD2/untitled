local x = 259
local y = 40

function onCreate()
    makeAnimatedLuaSprite('gooseBODY', 'characters/goose RUN', getProperty('dad.x') + x, getProperty('dad.y') + y)
    addAnimationByPrefix('gooseBODY', 'run', 'goose run', 30, true)
    addLuaSprite('gooseBODY', false)
end

function onUpdate()
    setProperty('gooseBODY.alpha', getProperty('dad.alpha'))
    setProperty('gooseBODY.visible', getProperty('dad.visible'))
    setProperty('gooseBODY.x', getProperty('dad.x') + x)
    setProperty('gooseBODY.y', getProperty('dad.y') + y)
end