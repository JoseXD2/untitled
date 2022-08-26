--https://gist.github.com/FreeBirdLjj/6303864?permalink_comment_id=3400522#gistcomment-3400522
_G.switch = function(param, case_table)
    local case = case_table[param]
    if case then return case() end
    local def = case_table['default']
    return def and def() or nil
end

local allowCountdown = false
function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown and isStoryMode and not seenCutscene 
        --variables
        fps = 24
        goosex = getProperty('dad.x')
        camZoom = getProperty('camGame.zoom')
        taof = 334+16
        --
        runTimer('Cutscene1', 1/fps, taof)
        triggerEvent('Change Character', 0, '1cut bf');
        characterPlayAnim('boyfriend', 'anim', true)
        setProperty('dad.x', -1000)
        playMusic('MenuMusic', 0.5, true)
        setProperty('healthBar.visible', false)
        setProperty('healthBarBG.visible', false)
        setProperty('iconP1.visible', false)
        setProperty('iconP2.visible', false)
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'Cutscene1' then
        bfPosX = getProperty('boyfriend.x')+getProperty('boyfriend.width')/2
        bfPosY = getProperty('boyfriend.y')+getProperty('boyfriend.height')/2
        dadPosX = getProperty('dad.x')+getProperty('dad.width')/2
        dadPosY = getProperty('dad.y')+getProperty('dad.height')/2

        switch(loopsLeft, { 
            [taof-25] = function()   -- Camera zooms on BF
                setProperty('cameraSpeed', 30/fps)
                triggerEvent('Camera Follow Pos', bfPosX, bfPosY)
                doTweenZoom('camZT1', 'camGame', camZoom+0.65, getProperty('cameraSpeed'), 'sineout')
                end,

            [taof-71] = function()   -- BF Sings 1
                doTweenZoom('camZT11', 'camGame', 2, 4, 'linear')
                playSound('BF1', 1) 
                end,

            [taof-86] = function()   -- BF Sings 2
                playSound('BF2', 1)
                end,

            [taof-101] = function()  -- BF Sings 3
                playSound('BF3', 1) 
                end,

            [taof-111] = function()  -- Goose steals The Mic
                characterPlayAnim('dad', 'steal', true)
                setProperty('dad.x', 600)
                cancelTween('camZT11')
                setProperty('camGame.zoom', camZoom+0.65)
                playSound('BITE', 1)
                end,

            [taof-113] = function()  -- Put goose in his place after stealing
                setProperty('dad.x', goosex-150)
                end,

            [taof-141] = function()  -- BF realizes he has no mic
                playSound('missnote2', 1)
                end,

            [taof-156] = function()  -- Camera zooms on Goose
                setProperty('cameraSpeed', (192-(156+15))/fps)
                triggerEvent('Camera Follow Pos', dadPosX+100, dadPosY)
                doTweenZoom('camZT2', 'camGame', camZoom+0.45, getProperty('cameraSpeed'), 'sineout')
                end,

            [taof-192] = function()  -- Goose honks
                playSound('honk')
                characterPlayAnim('dad', 'singLEFT', true)
                end,

            [taof-208] = function()  -- Camera zooms on BF (again)
                setProperty('cameraSpeed', 19/fps)
                triggerEvent('Camera Follow Pos', bfPosX, bfPosY)
                end,

            [taof-301] = function()  -- BF takes the mic out of the pocket
                playSound('introGo', 1)
                doTweenZoom('camZT3', 'camGame', camZoom+0.7, 1, 'elasticOut')
                end,

            [0] = function()        -- Reset Everything
                setProperty('healthBar.visible', true)
                setProperty('healthBarBG.visible', true)
                setProperty('iconP1.visible', true)
                setProperty('iconP2.visible', true)

                setProperty('healthBar.alpha', 0)
                setProperty('healthBarBG.alpha', 0)
                setProperty('iconP1.alpha', 0)
                setProperty('iconP2.alpha', 0)

                doTweenAlpha('hp1', 'healthBarBG', 1, 1, 'linear')
                doTweenAlpha('hp2', 'healthBar', 1, 1, 'linear')
                doTweenAlpha('hp3', 'iconP1', 1, 1, 'linear')
                doTweenAlpha('hp4', 'iconP2', 1, 1, 'linear')

                -- camera
                triggerEvent('Camera Follow Pos')
                setProperty('cameraSpeed', 1)
                doTweenZoom('camZTF', 'camGame', camZoom, 1, 'cubeinout')
                --cameraSetTarget('bf')
                --misc
                setProperty('dad.x', goosex)
                triggerEvent('Change Character', 0, 'bf');
                triggerEvent('Change Character', 1, 'goose');
                --characterPlayAnim('boyfriend', 'hey', true)
                --setProperty('boyfriend.specialAnim', true)
                startCountdown()
                end
        })  
    end
end