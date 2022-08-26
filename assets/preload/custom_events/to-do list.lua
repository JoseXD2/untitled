local a = 0

function onCreate()
    precacheImage('gimmick/To-do list')
    makeAnimatedLuaSprite('list', 'gimmick/To-do list', 1280/2-(1182/2)/2, (720-668/2)+125)
    addAnimationByPrefix('list', 'popup', 'Appear', 24, false)
    addAnimationByPrefix('list', 'popdown', 'Dissapear', 24, false)
    scaleObject('list', 0.5, 0.5)
    setObjectCamera('list', 'other')
end
function onCreatePost()
    if songName == 'Town Menace' then
        setProperty('list.x', (1280/2-(1182/2)/2)+330 ) --125
        setProperty('list.y', (720-668/2)+175 )
    end
end

function onEvent(name, value1, value2)
    if name == 'to-do list' then
        a = a+1
        setProperty('list.alpha', 1)
        addLuaSprite('list', true);
        --check
        if a < 2 then
            objectPlayAnimation('list', 'popup')
        else
            objectPlayAnimation('list', 'popdown')
            runTimer('listthing1', 0.30, 1)
            a = 0
        end
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'listthing1' then
        setProperty('list.alpha', 0)
    end
end
