Game = Object:extend()

function Game:new()
    self.paddleLeft = Paddle()
    self.paddleLeft.keyUp = 'w'
    self.paddleLeft.keyDown = 's'
    self.paddleRight = Paddle()
    self.paddleRight.x = 740
    self.ball = Ball()
    self.scoreLeft = 0
    self.scoreRight = 0
end

function Game:update(dt)
    self.paddleLeft:update(dt)
    self.paddleRight:update(dt)
    self.ball:update(dt)
    self.ball:bounce(self.paddleRight)
    self.ball:bounce(self.paddleLeft)

    local ball_status = self.ball:outOfBounds()
    if ball_status == 'left' then
        self.ball = Ball()
        self.scoreRight = self.scoreRight + 1
    elseif ball_status == 'right' then
        self.ball = Ball()
        self.scoreLeft = self.scoreLeft + 1
    end
end

function Game:draw()
    for i=0,10 do
        love.graphics.rectangle('fill', 390, 80*i, 20, 60)
    end

    self.paddleLeft:draw()
    self.paddleRight:draw()
    self.ball:draw()
    love.graphics.print(self.scoreLeft .. " - " .. self.scoreRight, 350, 20, 0, 4, 4)
end
