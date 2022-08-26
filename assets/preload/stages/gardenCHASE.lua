local speed = 70--45
local thr = 2250
local dfltDir = 'backgrounds/garden/'
local obj = {
	{tag= 'sky'     ,fn= 'sky'     		,x= 0    ,y= -340 ,sfx= 0.0, sfy= 0.0 ,frnt= false, gap= 0},
	{tag= 'mounts'  ,fn= 'mounts'  		,x= -310 ,y= -100 ,sfx= 0.2, sfy= 0.2 ,frnt= false, gap= 0},
	{tag= 'town2'   ,fn= 'town2'   		,x= 100  ,y= -325 ,sfx= 0.3, sfy= 0.3 ,frnt= false, gap= 1700},
	{tag= 'town1'   ,fn= 'town1'   		,x= -350 ,y= -345 ,sfx= 0.5, sfy= 0.5 ,frnt= false, gap= 500},
	{tag= 'ground'  ,fn= 'CHASE ground' ,x= -414 ,y= 212  ,sfx= 1.0, sfy= 1.0 ,frnt= false, gap= 0},
	{tag= 'wall'    ,fn= 'CHASE wall 2' ,x= -400 ,y= 106  ,sfx= 0.8, sfy= 0.8 ,frnt= false, gap= 0},
	{tag= 'objects' ,fn= 'CHASE objects',x= 780  ,y= 106  ,sfx= 0.8, sfy= 0.8 ,frnt= false, gap= 10000},
	{tag= 'cattail' ,fn= 'cattail' 		,x= 150  ,y= 750  ,sfx= 1.5, sfy= 1.5 ,frnt= true,  gap= 5000}
}

function onCreate()
	
	for i = 1, #(obj) do
		makeLuaSprite(obj[i].tag, dfltDir..obj[i].fn, obj[i].x, obj[i].y);
		setScrollFactor(obj[i].tag, obj[i].sfx, obj[i].sfy);
		addLuaSprite(obj[i].tag, obj[i].frnt);

		makeLuaSprite(obj[i].tag.."2", dfltDir..obj[i].fn, obj[i].x-getProperty(obj[i].tag..'.width')-obj[i].gap, obj[i].y);
		setScrollFactor(obj[i].tag.."2", obj[i].sfx, obj[i].sfy);
		addLuaSprite(obj[i].tag.."2", obj[i].frnt);
	end
		makeLuaSprite('test', 'storymenu/week 1', thr, 0)
		addLuaSprite('test', true)
end
function onCreatePost()
	triggerEvent('Camera Follow Pos', getProperty('gfGroup.x'), getProperty('gfGroup.y'))
end
function onEvent(name, value1, value2)
	if name == 'menaceChangeSpeed' then
		if speed ~= 0 then
			speed = speed*value1
		else
			speed = value1
		end
		setProperty('gooseBODY.framerate', 0)
	end
end

function onUpdate()

	for i = 1, #(obj) do
		local tag = obj[i].tag
		local tag2 = obj[i].tag..'2'
		local sfx = obj[i].sfx
		local x = obj[i].x
		local gap = obj[i].gap
		setProperty(tag..'.x', getProperty(tag..'.x')+speed*sfx)
		setProperty(tag2..'.x', getProperty(tag2..'.x')+speed*sfx)

		if getProperty(tag..'.x')+getProperty(tag..'.width') >= thr then
			setProperty(tag2..'.x', getProperty(tag..'.x')-getProperty(tag..'.width')-gap+5)
		end
		if getProperty(tag2..'.x')+getProperty(tag2..'.width') >= thr then
			setProperty(tag..'.x', getProperty(tag2..'.x')-getProperty(tag2..'.width')-gap+5)
		end
		
	end
end

