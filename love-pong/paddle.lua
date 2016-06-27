Paddle = Entity:extend()

function Paddle:new(x, y, w, h)
    Paddle.super.new(self, 50, 100, 10, 100)
    self.keyUp = 'up'
    self.keyDown = 'down'
end

function Paddle:update(dt)
    self.vy = 0
    keys = love.keyboard.isDown
    if keys(self.keyUp) then
        self.vy = -400
    elseif keys(self.keyDown) then
        self.vy = 400
    end
    Paddle.super.update(self, dt)
end
