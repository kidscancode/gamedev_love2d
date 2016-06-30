Zombie = class('Zombie')

function Zombie:initialize(x, y)
    self.image = assets.images.zombie1_hold
    self.pos = vector(x, y)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.offset = vector(self.width / 2, self.height / 2)
    self.acceleration = 1000
    self.friction = 5
    self.rot = -math.random()
    self.knockback = 500
    self.acc = vector(0, 0)
    self.vel = vector(0, 0)
    self.max_health = 10
    self.health = 10
end

function Zombie:update(dt)
    if self.hit then
        self.hit = false
        self.rot = self.rot + math.pi / 6 % math.pi
        self.vel = vector(0, 0)
    end
    self.acc = vector(250, 0):rotated(self.rot)
    -- self.rot = self.rot + 0.2 * dt
    self.acc = self.acc - self.vel * self.friction
    self.vel = self.vel + self.acc * dt
    self.pos = self.pos + self.vel * dt + 0.5 * self.acc * dt * dt

    if self.health < 1 then
        self.delete = true
    end
end

function Zombie:draw()
    love.graphics.draw(self.image, self.pos.x+self.offset.x, self.pos.y+self.offset.y,
                       self.rot, 1, 1, self.offset.x, self.offset.y)
    if self.health < 10 then
        love.graphics.push("all")
        if self.health > self.max_health / 2 then
            love.graphics.setColor(0, 255, 0, 255)
        elseif self.health < self.max_health / 4 then
            love.graphics.setColor(255, 0, 0, 255)
        else
            love.graphics.setColor(255, 255, 0, 255)
        end

        local bar_width = (self.width / 10) * self.health
        love.graphics.rectangle("fill", self.pos.x, self.pos.y-15, bar_width, 5)
        love.graphics.pop()
    end
end
