local ar = 1
local zoom = 0
local zoomHud = 0
function onCreate()
	addCharacterToList('BF_Stunned', 'boyfriend');
	addCharacterToList('bf', 'boyfriend');
	addCharacterToList('GooseAttack', 'dad');
	addCharacterToList('Goose', 'dad');

	makeLuaText('pressSpace','Press SpaceBar!',0, 0, 0)
	setTextSize('pressSpace', 35)
	setObjectCamera('pressSpace', 'other')
	setTextFont('pressSpace', 'Transport New Light.otf')
	addLuaText('pressSpace')
	setProperty('pressSpace.alpha', 0)
end

--Stuff i couldnt put in Create :(
function onCreatePost()	
	zoom = getProperty('camGame.zoom')
	zoomHud = getProperty('camHud.zoom')
end

--Goose takes your mic
function onEvent(name, value1, value2)
	if name == 'Mic Steal' then
		ar = 0
		if getProperty('boyfriend.stunned') == true then
			setProperty('health', getProperty('health') - 0.10);
		end
		--Important Stuff
		triggerEvent('Change Character', 0, 'BF_Stunned');
		triggerEvent('Change Character', 1, 'GooseAttack');
		setProperty('boyfriend.stunned', true) -- Important Line

		--UI Stuff
		for i = 4,7 do -- Arrows Darken
			setPropertyFromGroup('strumLineNotes',i,'visible', false)
		end
		setProperty('pressSpace.alpha', 1)
		setProperty('pressSpace.x', getPropertyFromGroup('playerStrums', 0, 'x') + 85)
		setProperty('pressSpace.y', getPropertyFromGroup('playerStrums', 0, 'y') + 35)

		-- Animation Stuff
		characterPlayAnim('dad', 'steal', true)
		setProperty('dad.specialAnim', true);
		doTweenZoom('zoom1', 'camGame', zoom+0.05, 0.2, 'quadinout')
		playSound('BITE', 0.5)	
	end
end

function onUpdatePost(elapsed)
	--
	if ar == 0 then
		if getProperty('dad.animation.curAnim.finished') then
			triggerEvent('Change Character', 1, 'Goose');
			ar = ar+1
		end
	end


	if getProperty('boyfriend.stunned') == true and keyJustPressed('space') then
		triggerEvent('Change Character', 0, 'bf');
		setProperty('boyfriend.stunned', false)
		setProperty('pressSpace.alpha', 0)
		characterPlayAnim('boyfriend', 'hey', true)
		setProperty('boyfriend.specialAnim', true);

		for i = 4,7 do
			setPropertyFromGroup('strumLineNotes',i,'visible', true)
		end

		doTweenZoom('zoom2', 'camGame', zoomHud-0.025, 0.1, 'quadinout')


	elseif getProperty('boyfriend.stunned') == false and keyJustPressed('space') then
		setProperty('health', getProperty('health') - 0.10);
		characterPlayAnim('boyfriend', 'singDOWNmiss', true)
		playSound('missnote2', 0.5)
	end

end
