function onCreate()
	-- background shit


	makeLuaSprite('wallpaper', 'backgrounds/desktop/desktop_wallpaper', -285, -285);
	setScrollFactor('wallpaper', 0.6, 0.6);
	addLuaSprite('wallpaper', false);

	makeLuaSprite('winlogo', 'backgrounds/desktop/desktop_winlogo', 1330, 90);
	setScrollFactor('winlogo', 0.7, 0.7);
	addLuaSprite('winlogo', false);

	makeLuaSprite('trashcan', 'backgrounds/desktop/desktop_trashcan', 1680, 650);
	setScrollFactor('trashcan', 1, 1);
	addLuaSprite('trashcan', false);

	makeLuaSprite('taskbar', 'backgrounds/desktop/desktop_taskbar', -540, 900);
	scaleObject('taskbar', 20, 1)
	setScrollFactor('taskbar', 0, 1);
	addLuaSprite('taskbar', false);

	makeLuaSprite('icons', 'backgrounds/desktop/desktop_taskbar icons', -250, 990);
	setScrollFactor('icons', 0, 1);
	addLuaSprite('icons', false);

	makeLuaSprite('icons2', 'backgrounds/desktop/desktop_taskbar icons 2', 1200, 990);
	setScrollFactor('icons2', 0, 1);
	addLuaSprite('icons2', false);
	
	

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end