

function action_init()
    -- particle_init()
    move_init()
end


function action_update()
    -- particle_update()
    move_update()
end


function action_draw()
    -- particle_draw()
    move_draw()
end

-------------------------------------------------
-- particles = {}
-- function make_particle()
--   return {
--     x = rnd(128),
--     y = rnd(128),
--     dx = rnd(2)-1,
--     dy = rnd(2)-1
--   }
-- end

-- function particle_thread(p)
--   while true do
--     p.x += p.dx
--     p.y += p.dy

--     -- 화면 밖이면 방향 반전
--     if p.x < 0 or p.x > 127 then p.dx = -p.dx end
--     if p.y < 0 or p.y > 127 then p.dy = -p.dy end

--     yield()
--   end
-- end


-- function particle_init()
-- 	-- 파티클 3개 만들고 코루틴 생성
-- 	for i=1,3 do
-- 	  local p = make_particle() -- x y dx dy 객체 리턴
-- 	  p.co = cocreate(function() particle_thread(p) end) --particle_thread() 코루틴만듦
-- 	  add(particles, p)
-- 	end
-- end

-- function particle_update()
--   -- 모든 파티클 코루틴 실행
--   for p in all(particles) do
--     coresume(p.co)
--   end
-- end

-- function particle_draw()
--   cls()
--   for p in all(particles) do
--     circfill(p.x, p.y, 2, 8+i) -- 색상 다르게 하고 싶으면 +i
--   end
-- end

-----------------------------------------
CAT_SPR = {
    SIT = 1,
    WALK1 = 2,
    WALK2 = 3,    
    JUMP = 4,
}

-- 플레이어 변수
player = {
    x = 64,
    y = 100,
    dy = 0, --y방향속도
    jump_power = -4,
    gravity = 0.2,
    on_ground = true,
    speed = 2,
    gaze = XDIR.RIGHT,
    sprite = CAT_SPR.WALK1,
  }


function move_init()
end
framecnt = 0
function move_update()
    framecnt += 1
    
    local p = player
    --1Player
    if (btn(BTN.LEFT, PLAYER.NO1)) then 
        p.x -= p.speed 
        p.gaze = XDIR.LEFT
        if(framecnt % 10 == 0) then
            if(player.sprite == CAT_SPR.WALK1) then
                player.sprite = CAT_SPR.WALK2
            else
                player.sprite = CAT_SPR.WALK1
            end
        end    
    end
    if (btn(BTN.RIGHT,PLAYER.NO1)) then 
        p.x += p.speed 
        p.gaze = XDIR.RIGHT
        if(framecnt % 10 == 0) then
            if(player.sprite == CAT_SPR.WALK1) then
                player.sprite = CAT_SPR.WALK2
            else
                player.sprite = CAT_SPR.WALK1
            end
        end
    
    end
    if (btn(BTN.UP,PLAYER.NO1)) then 
        p.y -= p.speed 
        p.sprite = CAT_SPR.JUMP
    end
    if (btn(BTN.DOWN,PLAYER.NO1)) then
        p.y += p.speed 
        p.sprite = CAT_SPR.SIT
        end     
    if (btnp(BTN.JUMP)) and p.on_ground then
        p.dy = p.jump_power
        p.on_ground = false
        p.sprite = CAT_SPR.JUMP
    end
  
    -- 중력 적용
    p.dy += p.gravity
    p.y += p.dy
  
    -- 바닥에 닿으면 멈춤
    if p.y >= 100 then
      p.y = 100
      p.dy = 0
      p.on_ground = true    
    end

    if not p.on_ground then
        p.sprite = CAT_SPR.JUMP
    end
end

function move_draw()
    cls()
    local p = player

    spr(p.sprite, p.x,p.y, 1,1, p.gaze, false)
    rectfill(0, 108, 127, 127, COLOR.DARK_GRAY)      -- 바닥
end



-- function init_player(x, play_no)
--     local player = 
--     {        
--         x = x,
--         y = POS.BOTTOM,
--         size = 3,
--         life = 3,
--         speed = 2,
--         play_no = play_no,
--         color = 3,
--     }

--     function player:draw()
--         circfill(self.x, self.y, self.size, self.color)
--     end

--     function player:update()
--         if btn(BTN.LEFT, play_no) then self.x -= self.speed end
--         if btn(BTN.RIGHT, play_no) then self.x += self.speed end
--         if btn(BTN.DOWN, play_no) then self.size -= self.speed end
--         if btn(BTN.UP, play_no) then self.size += self.speed end
--         if btn(BTN.JUMP, play_no) then self.y -= self.speed end
--         if btn(BTN.FIRE, play_no) then self.color = flr(rnd(8)) end
--     end

--     return player
-- end