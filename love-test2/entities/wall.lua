Wall = class('Wall')

function Wall:initialize(x, y, w, h)
    self.x = x
    self.y = y
    self.width = w
    self.height = h
    self.color = {0, 155, 0, 255}
end

function Wall:update(dt)

end

function Wall:draw()
    -- love.graphics.setColor(self.color)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
