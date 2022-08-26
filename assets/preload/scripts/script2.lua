local songComp = '???'
local kawai = 'Kawai Sprite'
local larn = 'Larnny'
local dod = 'DodZonedOut'
local beg = 'Begwhi02'
local songArray = {
	{'Tutorial',kawai},      {'Bopeebo',kawai},     {'Fresh',kawai}, {'Dad Battle',kawai},
	{'Spookeez',kawai},      {'South',kawai},       {'Monster',kawai}, 
	{'Pico',kawai},          {'Philly Nice',kawai}, {'Blammed',kawai},
	{'Satin Panties',kawai}, {'High',kawai},        {'Milf',kawai},
	{'Cocoa',kawai},         {'Eggnog',kawai},      {'Winter Horrorland',kawai}, 
	{'Senpai',kawai},        {'Roses',kawai},       {'Thorns',kawai},
	{'Ugh',kawai},       	 {'Guns',kawai},       {'Stress',kawai},
	--Goose Songs
	{'Untitled Song', beg..' \n and '..dod},
	{'Trouble Maker', dod},
	{'Town Menace', larn},
	{'Desktop', larn}
}

local dflt_ease = 'quintout'
local dflt_easeout = 'backin'
local global_font = 'Transport New Light.otf'

local infbx = {
	w=275, h=115, x=0, y=-30,
	clr='3b6cd5',
	brd=3, brd_clr='183167'
}
infbx.x = 1280/2-infbx.w/2

local textArray = {
	{-- SONG NAME
		text='', 
		sz=28, w=1280,	x=0, y=0,
		algn='center', clr='ffffff'
	},
	{-- COMPOSER
		text='', 
		sz=20, w=1280,	x=0, y=0,
		algn='center', clr='9db5ea'
	} 
}
function onCreate()
	for i = 1, #(songArray) do
		if songName == songArray[i][1] then
			songComp = songArray[i][2]
		end
	end

	textArray[1].text = '"'..songName..'"'
	textArray[2].text = 'Made by '..songComp
	textArray[1].y = 15  --onRound((infbx.y+infbx.h/2-textArray[2].sz/2-(textArray[3].sz/2))+30)
	textArray[2].y = onRound(textArray[1].y+30)

------Actual Code !! --------------------------------------------------------------

	makeLuaSprite('infobox_outline', 'empty', infbx.x-infbx.brd, (infbx.y-infbx.brd)-240)
		makeGraphic('infobox_outline', infbx.w+infbx.brd*2, infbx.h+infbx.brd*2, infbx.brd_clr)
		setObjectCamera('infobox_outline', 'other')
		addLuaSprite('infobox_outline', true)

	makeLuaSprite('infobox', 'empty', infbx.x, infbx.y-240)
		makeGraphic('infobox', infbx.w, infbx.h, infbx.clr)
		setObjectCamera('infobox', 'other')
		addLuaSprite('infobox', true)

	for i = 1, #textArray do
		makeLuaText('text'..i, textArray[i].text, textArray[i].w, textArray[i].x, textArray[i].y-240)
		setTextAlignment('text'..i, textArray[i].algn)
		setTextSize('text'..i, textArray[i].sz)
		setTextFont('text'..i, global_font)
		setTextColor('text'..i, textArray[i].clr)
		setTextBorder('text'..i, 0, '3b6cd5')
		setObjectCamera('text'..i, 'other')
		addLuaText('text'..i)
	end

end

function onSongStart()
		doTweenY('MoveIn_infobox', 'infobox', infbx.y, 1, dflt_ease)
		doTweenY('MoveIn_infobox_outline', 'infobox_outline', infbx.y-infbx.brd, 1, dflt_ease)
	for i = 1, 2 do
		doTweenY('MoveIn_text'..i, 'text'..i, textArray[i].y, 1, dflt_ease)
	end

	runTimer('Timer1', 2.5, 1)
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'Timer1' then
			doTweenY('MoveOut_infobox_outline', 'infobox_outline', (infbx.y-infbx.brd)-240, 1, dflt_easeout)
			doTweenY('MoveOut_infobox', 'infobox', infbx.y-240, 1, dflt_easeout)
		for i = 1, #textArray do
			doTweenY('MoveOut_text'..i, 'text'..i, textArray[i].y-240, 1, dflt_easeout)
		end
	end
	
end 
function onTweenCompleted(tag) 
	if tag == 'MoveOut_text3' then
		removeLuaText('text1', true)
		removeLuaText('text2', true)
		removeLuaText('text3', true)
		removeLuaSprite('infobox_outline', true)
		removeLuaSprite('infobox', true)
		--close(true);
	end
end


function onRound(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
 	n = math.pow(10, n or 0)
 	x = x * n
  		if x >= 0 then
   		x = math.floor(x + 0.5)
  		else
   		x = math.ceil(x - 0.5)
  		end
 	return x / n
end