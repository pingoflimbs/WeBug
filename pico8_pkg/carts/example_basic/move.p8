pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
x = 64
y = 100

function _update()
	if	btn(0) == true then	
		x -= 2	
	end
	if btn(1) == true then	
		x += 2	
	end
end

function _draw()
	cls() --clear screen
	circ(x,y,4) --draw circle
end
