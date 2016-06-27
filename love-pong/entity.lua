Entity = Object:extend()

function Entity:new(x, y, w, h)
    self.x = x
    self.y = y
    self.width = w
    self.height = h
    self.vx = 0
    self.vy = 0
end

function Entity:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt

    if self.y <= 0 then
        self.y = 0
        self.vy = -self.vy
    end
    if self.y + self.height >= love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
        self.vy = -self.vy
    end

end

function Entity:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
