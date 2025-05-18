pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
x = 64
y = 64

function _init()
	cls()
end

function _update()
--btn 0 left
--btn 1 right
--btn 2 up
--btn 3 down
	if	btn(0) == true then
		x -= 2
	end
	if btn(1) == true then
		x += 2
	end
	if btn(2) == true then
		y -= 2
	end
	if btn(3) == true then
		y += 2
	end
end

function _draw()
	cls() --clear screen
	circ(x,y,4) --draw circle
end

