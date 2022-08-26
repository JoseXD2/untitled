--https://gist.github.com/FreeBirdLjj/6303864?permalink_comment_id=3400522#gistcomment-3400522
_G.switch = function(param, case_table)
    local case = case_table[param]
    if case then return case() end
    local def = case_table['default']
    return def and def() or nil
end

local walkSpeed = 5
local phase = 0
local timerA = 0
local timerB = 0
local defx = 0.8
local defy = 0.8
local goosx = 0
local getPos = 0

function onCreatePost()
	makeAnimatedLuaSprite('birus', 'gimmick/birus goose', 1350 ,getProperty('healthBar.y')-100)
	addAnimationByPrefix('birus', 'Walk', 'birus walk', 24, true)
	addAnimationByPrefix('birus', 'Drag', 'birus drag', 24, true)
	addAnimationByPrefix('birus', 'LetGo', 'birus letgo', 24, false)
	setObjectCamera('birus', 'other')
	addLuaSprite('birus', false)
	setProperty('birus.scale.x', defx)
	setProperty('birus.scale.y', defy)

end

function onEvent(name, value1, value2)
	if name == 'desktop goose' then
		
		isActive = true
		phase = 1
	end
end

function onUpdate()
	if isActive == true then
		goosx = getProperty('birus.x')
		

		switch(phase, { 
		    [1] = function()
		    	-- Walk In
		    	objectPlayAnimation('birus', 'Walk', false)
				setProperty('birus.x', goosx-walkSpeed)
				setProperty('birus.scale.x', defx)
				timerA = 0
				timerB = 0
				--debugPrint("1")
			end,

			[2] = function()
				-- Drag
				
				if getProperty('health') <= 1 then
					phase = 5
				else
					timerA = timerA+10/60
					if timerA >= 5 then
						objectPlayAnimation('birus', 'Drag', false)
						setProperty('birus.x', getProperty('iconP1.x')+100)
						setProperty('health', getProperty('health')-0.005)
					end
				end	
				--debugPrint("2")
			end,

			[3] = function()
				-- Walk Out
				timerA = 0
				timerB = timerB+10/60

				if timerB >= 5 then
					setProperty('birus.scale.x', defx*-1)
					setProperty('birus.x', goosx+walkSpeed)
					objectPlayAnimation('birus', 'Walk', false)
				end
				if getProperty('birus.x') > 1300 then
					setProperty('birus.scale.x', defx)
					timerB = 0
					phase = 0
				end
			end,

			[4] = function()
				objectPlayAnimation('birus', 'LetGo', true)
				phase = 2
			end,
			[5] = function()
				objectPlayAnimation('birus', 'LetGo', true)
				phase = 3
			end
		})	

		if getProperty('birus.animation.name') == 'Drag' then
			setProperty('birus.offset.y', -50);
		else
			setProperty('birus.offset.y', 0);
		end

		getPos = getProperty('birus.x') >= getProperty('iconP1.x') and getProperty('birus.x') <= (getProperty('iconP1.x')+100)
		if getPos and phase == 1 then
			phase = 4
		end

		--debug
		--if getPropertyFromClass("flixel.FlxG", "keys.justPressed.G") then
		--	setProperty('health', getProperty('health') + 0.10);
		--end
		--if getPropertyFromClass("flixel.FlxG", "keys.justPressed.H") then
		--	setProperty('health', getProperty('health') - 0.10);
		--end

	end

end