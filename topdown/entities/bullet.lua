Bullet = class('Bullet')

function Bullet:initialize(pos, dir, precision)
    self.image = assets.images.bullet
    self.pos = pos
    local spread = math.random() / precision - 0.1
    self.vel = dir:rotated(spread) * 500
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.spawn_time = love.timer.getTime()
    self.lifetime = 1
    self.delete = false
    table.insert(game.world_objects, self)
    game.world:add(self, self.pos.x, self.pos.y, self.width, self.height)
end

function Bullet:update(dt)
    self.pos = self.pos + self.vel * dt

    if love.timer.getTime() - self.spawn_time > self.lifetime then
        self.delete = true
    end
end

function Bullet:draw()
    love.graphics.draw(self.image, self.pos.x, self.pos.y)
end
