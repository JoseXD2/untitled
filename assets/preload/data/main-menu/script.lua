local function switchTab(direction, time, ease, objList, objList2, tab, vertical)
	setProperty('pointer.x', -20)
	setProperty('pointer.y', -20)
	if vertical == true then
		for i = 1, #(objList) do
			doTweenY('switchTabTweenY'..objList[i], objList[i], getProperty(objList[i]..'.y')-screenHeight*direction, time, ease)
		end
		for i = 1, #(objList2) do
			doTweenY('switchTabTweenY'..objList2[i], objList2[i], getProperty(objList2[i]..'.y')-screenHeight*direction, time, ease)
		end
	else
		for i = 1, #(objList) do
			doTweenX('switchTabTweenX'..objList[i], objList[i], getProperty(objList[i]..'.x')-screenWidth*direction, time, ease)
		end
		for i = 1, #(objList2) do
			doTweenX('switchTabTweenX'..objList2[i], objList2[i], getProperty(objList2[i]..'.x')-screenWidth*direction, time, ease)
		end
	end
	runTimer('switchToTab '..tab, time, 1)
end
local function fadeScreen(time)
	runTimer('EndMENU', time)
	doTweenAlpha('FADEOUTT', 'BLACK', 1, time, 'linear')
end
local function openLink(link)
	if (buildTarget == "linux") then
    	os.execute("/usr/bin/xdg-open " .. link)
  	else
    	os.execute("start " .. link)
  end
end

local sounds = {
	volume = 10,
	select = 'UI/ui_menu_main_select', 
	move = 'UI/ui_menu_main_toggle',
	switch = 'UI/ui_menu_main_switch',
	cancel = 'UI/ui_menu_main_select',
	}
local storyWeek = {'main-menu', 'Untitled Song', 'Trouble Maker', 'Town Menace', 'Ending', 'main-menu'}
-- storyWeek = {'main-menu', 'Untitled Song', 'Trouble Maker', 'Town Menace', 'Ending', 'main-menu'}
--local freeplay = {'Untitled Song', 'Trouble Maker', 'Menace', 'Desktop'}
local curS = 0
local curTab = 'title'
local text = {x = 550, y = 400, s = 35}
local titleTweenSpeed = 2

local globalObjs = {}
local menuObjs = {}
local freeplayObjs = {}
local creditsObjs = {}
local optionsObjs = {}

local menuList = {'Begin','Freeplay','Credits','Quit'}
local freeplayList = {'< Back', 'Untitled Song', 'Trouble Maker', 'Town Menace', 'Desktop'}
local creditsList = {'^ Back', 'Larnny', 'Begwhi02', 'DodZonedOut','Portel', 'House House'}
--local optionsList = {'> Back', 'Larnny', 'Begwhi02', 'DodZonedOut', 'House House'}
local creditsText = {
	'Director, Artist, Coder\nComposer for: \n"Town Menace"\n"Desktop"', 
	'Composer for "Untitled Song"', 
	'Composer for "Trouble Maker"\nHelped with "Untitled Song"', 
	'Drew the running BF sprites',
	'The Creators of Untitled Goose Game'
	}

local menuFunc = {
	['Begin']=function()
		playSound(sounds.select, sounds.volume)
		setPropertyFromClass('PlayState', 'storyPlaylist', storyWeek)
		fadeScreen(2)
		end,
	['Freeplay']=function()
		playSound(sounds.switch, sounds.volume)
		curTab = 'None'
		curS = 2
		switchTab(1, 1, 'sineinout', menuObjs, freeplayObjs, 'freeplay')
		end,
	['Options']=function() 
		end,
	['Credits']=function()
		curTab = 'None'
		curS = 1 
		switchTab(1, 1, 'sineinout', menuObjs, creditsObjs, 'credits', true)
		end,
	['Quit']=function()
		endSong(false)
		end
}
local freeplayFunc = {
	['< Back']=function()
		playSound(sounds.switch, sounds.volume)
		curTab = 'None'
		curS = 2
		switchTab(-1, 1, 'sineinout', menuObjs, freeplayObjs, 'mainmenu')
	end,
	['Untitled Song']=function()
		playSound(sounds.select, sounds.volume)
		loadSong('Untitled Song', 'hard')
	end,
	['Trouble Maker']=function()
		playSound(sounds.select, sounds.volume)
		loadSong('Trouble Maker', 'hard')
	end,
	['Town Menace']=function()
		playSound(sounds.select, sounds.volume)
		loadSong('Town Menace', 'hard')
	end,
	['Desktop']=function()
		playSound(sounds.select, sounds.volume)
		loadSong('Desktop', 'hard')
	end
	}
local creditsFunc = {
	['^ Back']=function()
		playSound(sounds.switch, sounds.volume)
		curTab = 'None'
		curS = 3
		switchTab(-1, 1, 'sineinout', menuObjs, creditsObjs, 'mainmenu', true)
		--switchTab(-1, 1, 'sineinout', menuObjs, freeplayObjs, 'mainmenu')
		end,
	['Larnny']=function()
		playSound(sounds.select, sounds.volume)
		openLink('https://twitter.com/Larnny3')
		end,
	['Begwhi02']=function()
		playSound(sounds.select, sounds.volume)
		openLink('https://twitter.com/Begwhi02')
		end,
	['DodZonedOut']=function()
		playSound(sounds.select, sounds.volume)
		openLink('https://twitter.com/DodZonedOut')
		end,
	['Portel']=function()
		playSound(sounds.select, sounds.volume)
		openLink('https://twitter.com/porteliscancel')
		end,
	['House House']=function()
		playSound(sounds.select, sounds.volume)
		openLink('https://twitter.com/house_house_')
		
		end
	}


--https://gist.github.com/FreeBirdLjj/6303864?permalink_comment_id=3400522#gistcomment-3400522
local function switch(param, case_table)
    local case = case_table[param]
    if case then return case() end
    local def = case_table['default']
    return def and def() or nil
end
local function keyPressed(key, isheld)
	if isheld == nil then isheld = false end
	if isheld == false then
		return getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..key)
	elseif isheld == true then
		return getPropertyFromClass('flixel.FlxG', 'keys.pressed.'..key)
	end
end
local function makeGooseText(tag, txt, w, x, y, size, list)
	makeLuaText(tag, txt, w, x, y);setTextSize(tag, size);
	setTextFont(tag, 'Transport New Medium.otf');setObjectCamera(tag, 'other');
	setTextBorder(tag, 0, '3b6cd5');addLuaText(tag);
	table.insert(list, tag)
end
local function makeGooseSprite(tag, file, x, y, list)
	makeLuaSprite(tag, file, x, y)
	setObjectCamera(tag, 'other')
	addLuaSprite(tag, true)
	table.insert(list, tag)
end
local function scrollMenuText(list, listName, b1, b2)
	if keyJustPressed(b1) then if curS>1 then curS=curS-1 else curS=#(list) end playSound(sounds.move, sounds.volume) end
	if keyJustPressed(b2) then if curS < #(list) then curS=curS+1 else curS=1 end playSound(sounds.move, sounds.volume) end
	setProperty('pointer.y', getProperty(listName..' '..list[curS]..'.y'))
	setProperty('pointer.x', getProperty(listName..' '..list[curS]..'.x')-20)
end


local allowStart=false
function onStartCountdown()
	if allowStart==false then
			--setProperty('inCutscene', true)
		return Function_Stop;
	end
	return Function_Continue;
end
local textYlist = {0, 100, 250, 300}
function onCreate()
	local chance = getRandomInt(0, 50)
	local Logofile = 'UI/logo'
	if chance == 5 then
		Logofile = 'UI/logo alt'
	end
	playMusic('MenuMusic', 1, true)
	makeGooseSprite('bg', 'UI/menuBG', 0, 0, globalObjs)
	makeGooseText('pointer', '•', 0, -20, -20, text.s, globalObjs)
	--MAINMENU
	makeGooseSprite('logo', Logofile, 320, 250, menuObjs)
	for i = 1, #(menuList) do
	makeGooseText('mainmenu '..menuList[i], menuList[i], 0, text.x, 
		(text.y + math.floor((i*(text.s+10))-text.s-text.s/2))+350 , text.s, menuObjs)
	end
	--FREEPLAY
	for i = 1, 3 do
	makeGooseSprite('notebook'..i, 'UI/notebook'..i, (200+300*(i-1))+screenWidth, 215, freeplayObjs)
	makeGooseText('freeplay '..freeplayList[i+1], freeplayList[i+1], 260, (200+300*(i-1)-30)+screenWidth, 515, text.s, freeplayObjs)
	setProperty('freeplay '..freeplayList[i+1]..'.alpha', 0)
	end
	makeGooseSprite('eraser', 'UI/eraser', 1100+screenWidth, 300, freeplayObjs)
	makeGooseText('freeplay '..freeplayList[1], freeplayList[1], 0, 40+screenWidth, 40, text.s, freeplayObjs)
	makeGooseText('freeplay '..freeplayList[5], freeplayList[5], 0, 1075+screenWidth, 400, text.s, freeplayObjs)
	setProperty('freeplay '..freeplayList[5]..'.alpha', 0)
	--CREDITS

	makeGooseText('credits '..creditsList[1], creditsList[1], 0, 40, 40+screenHeight, text.s, creditsObjs)
	makeGooseText('credits ~~ Credits ~~', '~~ Credits ~~', screenWidth, 0, 75+screenHeight, text.s*2, creditsObjs)
	for i = 2, #(creditsList) do
		local wow = 0
		if i ~= 2 then wow = text.s/2*2 end
		--if i > 4 then wow = text.s/2*5 + text.s/2*1 end 
		local yCalc = math.floor(225 + (i-2)*(text.s*2) + wow + screenHeight)-- + funny
		makeGooseText('credits '..creditsList[i], creditsList[i], 250, 390, yCalc, text.s, creditsObjs)--550
		makeGooseText('credits '..creditsList[i]..'2', creditsText[i-1], 0, 650, yCalc+10, text.s/2, creditsObjs)
		setTextAlignment('credits '..creditsList[i], 'right')
		setTextAlignment('credits '..creditsList[i]..'2', 'left')
		setTextFont('credits '..creditsList[i]..'2', 'Transport New Light.otf')
	end

	makeGooseSprite('BLACK', 'UI/menuBG', 0, 0, globalObjs)
	setProperty('BLACK.color', '000000')
	setProperty('BLACK.alpha', 0)
end

local titleThing = 0
local getYthing = 0
function onUpdate()
	if keyPressed('SPACE', false) then
		restartSong()
	end
	if keyPressed('ESCAPE', false) then
		endSong(false)
		playSound(sounds.cancel, sounds.volume)
	end

	local function textImportFunc(list, func, tab)
		if keyPressed('ENTER', false) then
			func[list[curS]]()
		end
	end
	switch(curTab, {
		['None'] = function()
			
		end,
		['title'] = function()
			if titleThing == 0 then
				titleThing = 1
				runTimer('title timer', 17, 1)
			end
			if keyPressed('ENTER', false) then
				titleTweenSpeed = 0.5
				runTimer('title timer', 0.1, 1)
			end
		end,
		['mainmenu'] = function()
			scrollMenuText(menuList, 'mainmenu', 'up', 'down')
			textImportFunc(menuList, menuFunc, 'mainmenu')
		end,
		['freeplay'] = function()
			scrollMenuText(freeplayList, 'freeplay', 'left', 'right')
			textImportFunc(freeplayList, freeplayFunc, 'freeplay')

			local function itemAscend(sel, item, y, text)
				if curS == sel and curTab == 'freeplay' then 
					cancelTween('CoolTween2'..item)
					doTweenY('CoolTween1'..item, item, y-30, 0.1, 'linear')
					cancelTween('CoolTween2'..text)
					doTweenAlpha('CoolTween1'..text, text, 1, 0.05, 'linear')
				elseif curS ~= sel and getProperty(item..'.y') ~= y then
					cancelTween('CoolTween1'..item)
					doTweenY('CoolTween2'..item, item, y, 0.1, 'linear')
					cancelTween('CoolTween1'..text)
					doTweenAlpha('CoolTween2'..text, text, 0, 0.05, 'linear')
				end
			end
			if (curS == 2 or curS == 3 or curS == 4 or curS == 5) and curTab == 'freeplay' then
				setProperty('pointer.visible', false)
			else
				setProperty('pointer.visible', true)
			end
			itemAscend(2, 'notebook1', 215, 'freeplay '..freeplayList[2])
			itemAscend(3, 'notebook2', 215, 'freeplay '..freeplayList[3])
			itemAscend(4, 'notebook3', 215, 'freeplay '..freeplayList[4])
			itemAscend(5, 'eraser', 300, 'freeplay '..freeplayList[5])
		end,
		['credits'] = function()
			scrollMenuText(creditsList, 'credits', 'up', 'down')
			textImportFunc(creditsList, creditsFunc, 'credits')
		end,
	})
end

function onTimerCompleted(tag)
	if tag == 'switchToTab freeplay' then
		curTab = 'freeplay'
	end
	if tag == 'switchToTab credits' then
		curTab = 'credits'
	end
	if tag == 'switchToTab mainmenu' then
		curTab = 'mainmenu'
	end
	if tag == 'title timer' then
		for i = 1, #(menuList) do
			local abc = (text.y + math.floor((i*(text.s+10))-text.s-text.s/2))
			doTweenY('TITLE TEXT TWEEN '..i, 'mainmenu '..menuList[i], abc, titleTweenSpeed, 'sineinout')
		end
		doTweenY('TITLE LOGO TWEEN ', 'logo', 140, titleTweenSpeed, 'sineinout')
	end
	if tag=='EndMENU' then endSong() end
end
function onTweenCompleted(tag)
	if tag == 'TITLE TEXT TWEEN '..#(menuList) then
		curS = 1
		curTab = 'mainmenu'
	end
end
