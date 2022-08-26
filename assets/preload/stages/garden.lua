dfltDir = 'backgrounds/garden/'
obj = {
	{tag= 'sky'     ,fn= 'sky'     ,x= 0    ,y= -340 ,sfx= 0.0, sfy= 0.0 ,frnt= false},
	{tag= 'mounts'  ,fn= 'mounts'  ,x= -310 ,y= -100 ,sfx= 0.2, sfy= 0.2 ,frnt= false},
	{tag= 'town2'   ,fn= 'town2'   ,x= 100  ,y= -325 ,sfx= 0.3, sfy= 0.3 ,frnt= false},
	{tag= 'town1'   ,fn= 'town1'   ,x= -350 ,y= -345 ,sfx= 0.5, sfy= 0.5 ,frnt= false},
	{tag= 'ground'  ,fn= 'ground'  ,x= -414 ,y= 212  ,sfx= 1.0, sfy= 1.0 ,frnt= false},
	{tag= 'wall'    ,fn= 'wall'    ,x= -400 ,y= -150 ,sfx= 0.8, sfy= 0.8 ,frnt= false},
	{tag= 'bench'   ,fn= 'bench'   ,x= 235  ,y= 250  ,sfx= 1.0, sfy= 1.0 ,frnt= false},
	{tag= 'cattail' ,fn= 'cattail' ,x= 150  ,y= 750  ,sfx= 1.5, sfy= 1.5 ,frnt= true}
}

function onCreate()
	-- background shit
	for i = 1, #(obj) do
		makeLuaSprite(obj[i].tag, dfltDir..obj[i].fn, obj[i].x, obj[i].y);
		setScrollFactor(obj[i].tag, obj[i].sfx, obj[i].sfy);
		addLuaSprite(obj[i].tag, obj[i].frnt);
	end

	makeAnimatedLuaSprite('radio', dfltDir..'Radio', 590, 360);
	addAnimationByPrefix('radio', 'idle', 'Radio', 24, false)
	addLuaSprite('radio', false); 

	if songName ~=  'Untitled Song' then
		makeAnimatedLuaSprite('gardenman', dfltDir..'people_groundskeeper', 1450, 80);
		addAnimationByPrefix('gardenman', 'idle', 'people_groundskeeper', 24, false)
		addLuaSprite('gardenman', false);
	end

end

function onBeatHit()
	objectPlayAnimation('radio', 'idle', true)
	if curBeat % 2 == 0 then
		objectPlayAnimation('gardenman', 'idle', false)
	end
end

