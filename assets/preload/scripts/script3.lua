stopped = true
function onCreate()
	makeAnimatedLuaSprite('bitch', 'gameover goose', 600, 308)
	addAnimationByPrefix('bitch', 'dance', 'dance', 12, true)
	addAnimationByIndices('bitch', 'stop', 'dance', 1, 24)
	setObjectCamera('bitch', 'other')
	setProperty('bitch.alpha', 0)
	
	setPropertyFromClass('GameOverSubstate', 'characterName', 'ded'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'uh'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'honk'); --put in mods/music/

end
function onUpdate(elapsed)
	if inGameOver then
		if stopped == false then
			objectPlayAnimation('bitch', 'dance', true)
		end
		addLuaSprite('bitch', true)
		doTweenAlpha('alphabitch', 'bitch', 1, 20, 'circout')
	end
end

function onGameOverConfirm(reset)
	stopped = true
	objectPlayAnimation('bitch', 'stop', true)

	setProperty('bitch.scale.x', 0.75)
	setProperty('bitch.scale.y', 1.25)
	doTweenX('xbitch2', 'bitch.scale', 1, 0.25, 'circOut')
	doTweenY('ybitch2', 'bitch.scale', 1, 0.25, 'circOut')

	setProperty('bitch.alpha', 1)
	doTweenAlpha('alphabitch2', 'bitch', 0, 3, 'linear')
end

