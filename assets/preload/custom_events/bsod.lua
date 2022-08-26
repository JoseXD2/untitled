function onCreate()
	precacheImage('backgrounds/desktop/desktop_bsod')
end

function onEvent(name, value1, value2)
	if name == 'bsod' then
		removeLuaSprite('RED', true)

		setPropertyFromClass('flixel.FlxG', 'mouse.visible', false);
		makeLuaSprite('bsod', 'backgrounds/desktop/desktop_bsod', 0, 0);
		setScrollFactor('bsod', 0, 0);
		setObjectCamera('bsod', 'other')
        addLuaSprite('bsod', true);

        removeLuaSprite('popup 1', true)
        removeLuaSprite('popup 2', true)
        removeLuaSprite('popup 3', true)
        removeLuaSprite('popup 4', true)
	end
end