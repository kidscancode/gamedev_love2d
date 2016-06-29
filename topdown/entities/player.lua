Player = class('Player')


function Player:initialize(x, y)
    self.image = assets.images.manBrown_gun
    self.pos = vector(x, y)
    self.width = self.image:getWidth() / 2
    self.height = self.image:getHeight()
    self.offset = vector(11, 22)
    self.acceleration = 1000
    self.friction = 5
    self.rot = 0
    self.acc = vector(0, 0)
    self.vel = vector(0, 0)
    self.walk_sounds = { assets.sounds.sfx_movement_footsteps1a, assets.sounds.sfx_movement_footsteps1b}
    -- self.gravity = 1500
    -- self.on_ground = false
    -- gun settings - can be different for different guns
    self.shoot_sound = assets.sounds.sfx_wpn_machinegun_loop1
    self.rot_speed = 0.04
    self.fire_rate = 0.1
    self.precision = 9
    self.kickback = 350
    self.last_shot = love.timer.getTime()
end

function Player:update(dt)
    self.acc = vector(0, 0)
    -- if not self.on_ground then
    --     self.acc.y = self.gravity
    -- end
    if love.keyboard.isDown('left') then
        self.rot = self.rot - self.rot_speed
    elseif love.keyboard.isDown('right') then
        self.rot = self.rot + self.rot_speed
    end
    self.rot = self.rot % (2 * math.pi)
    if love.keyboard.isDown('up') then
        self.acc = vector(self.acceleration, 0):rotated(self.rot)
    elseif love.keyboard.isDown('down') then
        self.acc = vector(-self.acceleration/3, 0):rotated(self.rot)
    end
    if love.keyboard.isDown('space') then
        local now = love.timer.getTime()
        if now - self.last_shot > self.fire_rate then
            self.last_shot = now
            local dir = vector(1, 0):rotated(self.rot)
            local barrel = self.pos + self.offset/2 + vector(40, 10):rotated(self.rot)
            local b = Bullet:new(barrel, dir, self.precision)
            self.shoot_sound:play()
            screen:setScale(1, 1)
            screen:setShake(3)
            self.acc = self.acc + vector(-1, 0):rotated(self.rot) * self.kickback
        end
    end
    -- if love.keyboard.isDown('space') then
    --     if self.on_ground then
    --         self.vel.y = -700
    --     end
    -- -- elseif love.keyboard.isDown('down') then
    -- --     self.acc.y = 1
    -- end
    -- self.acc = self.acc:normalized() * self.acceleration

    -- update rectangle
    -- if (self.rot > PI/4 and self.rot < 3*PI/4) or (self.rot > 5*PI/4 and self.rot < 7*PI/4) then
    --     self.width = self.image:getHeight()
    --     self.height = self.image:getWidth()
    -- else
    --     self.width = self.image:getWidth()
    --     self.height = self.image:getHeight()
    -- end

    -- update equations of motion
    self.acc = self.acc - self.vel * self.friction
    self.vel = self.vel + self.acc * dt
    self.pos = self.pos + self.vel * dt + 0.5 * self.acc * dt * dt

end

function Player:draw()
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle("line", self.pos.x-self.offset.x, self.pos.y-self.offset.y, self.width, self.height)
    -- love.graphics.draw(self.image, self.pos.x+offset.x, self.pos.y+offset.y,
    --                    self.rot, 1, 1, offset.x, offset.y)
    love.graphics.draw(self.image, self.pos.x+self.offset.x, self.pos.y+self.offset.y,
                       self.rot, 1, 1, self.offset.x, self.offset.y)
end
