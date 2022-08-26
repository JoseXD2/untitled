function onCreate()
	makeLuaSprite('RED', 'empty', 0, 0);
	makeGraphic('RED', 1280, 720, 'b40f0f')
	setProperty('RED.alpha', 0.5)
	--setBlendMode('RED', 'HARDLIGHT')
	setObjectCamera('RED', 'other')
	setScrollFactor('RED', 0, 0);
end

function onEvent(name, value1, value2)
	if name == 'RED' then
		--setObjectOrder('RED', 99999999999)
        addLuaSprite('RED', true);

	end
end