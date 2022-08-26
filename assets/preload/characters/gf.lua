function onCreate()
    boomx = 150
    boomy = 311
    makeAnimatedLuaSprite('boombox', 'characters/GF_speakers', getProperty('gf.x') - boomx, getProperty('gf.y') + boomy)
    addAnimationByPrefix('boombox', 'boom', 'stereo boom', 24, false)
    addLuaSprite('boombox', false)
end

function onUpdate()
    setProperty('boombox.alpha', getProperty('gf.alpha'))
    setProperty('boombox.visible', getProperty('gf.visible'))
    setProperty('boombox.x', getProperty('gf.x') - boomx)
    setProperty('boombox.y', getProperty('gf.y') + boomy)
end

function onBeatHit()
    
    objectPlayAnimation('boombox', 'boom', true)
end