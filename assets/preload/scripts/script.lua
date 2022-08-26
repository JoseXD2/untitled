txt = {
	x = 0,
	y = 20,
	w = 450,
	size = 20,
	al = 'center',
	font = 'Transport New Medium.otf'
}
txty = txt.y --make this into variable because it crashes if i dont do it (IDK WHY)

function onCreate()
	strumXp = 732
	strumYp = 50
	if downscroll then
		strumYp = 570
		txty = 720 - (txty+txt.size)
	end
	if middlescroll then
		strumXp = 412
	end
end

function onCreatePost()
	txt.y = txty -- convert it back so i dont need to change rest of the code
	txt.x = strumXp
	
	--disable vanilla stuff
	setProperty('scoreTxt.visible', false)
	setProperty('timeBar.visible', false)
	setProperty('timeBarBG.visible', false)
	setProperty('timeTxt.visible', false)
	--make score text
	makeLuaText('scoreText', '', 450, txt.x, txt.y); 
	setTextSize('scoreText', txt.size)
	setTextAlignment('scoreText', txt.al)
	setTextFont('scoreText', txt.font)
	setProperty('scoreText.alpha', 0)
	addLuaText('scoreText');
end

function onRecalculateRating()
	setTextString('scoreText', '!!: ' .. getProperty('songMisses')..'    %: '..onRound((getProperty('ratingPercent')*100),2)..'    #: ' .. score);
	doTweenAlpha('tween4','scoreText', 1, 0.25, 'linear');
end

-- round function
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