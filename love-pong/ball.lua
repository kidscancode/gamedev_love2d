Ball = Entity:extend()

function Ball:new(x, y, w, h)
    Ball.super.new(self, 400, 300, 15, 15)
    self.vy = -500
    if math.random(1, 2) == 1 then
        self.vx = 400
    else
        self.vx = -400
    end

    self.timer = 10
end

function Ball:update(dt)
    if self.timer > 0 then
        self.timer = self.timer - 1
    else
        Ball.super.update(self, dt)
    end
end

function Ball:bounce(e)
    local left1 = self.x
    local right1 = self.x + self.width
    local top1 = self.y
    local bottom1 = e.y + e.height
    local left2 = e.x
    local right2 = e.x + e.width
    local top2 = e.y
    local bottom2 = e.y + e.height

    if left1 < right2 and
        right1 > left2 and
        top1 < bottom2 and
        bottom1 > top2 then
            self.vx = -self.vx
    end
end

function Ball:outOfBounds()
    if self.x + self.width < 0 then
        return 'left'
    elseif self.x > love.graphics.getWidth() then
        return 'right'
    else
        return false
    end
end
