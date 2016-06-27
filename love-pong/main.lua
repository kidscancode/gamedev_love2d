function love.load()
    Object = require "classic"
    require "game"
    require "entity"
    require "paddle"
    require "ball"

    game = Game()
end

function love.update(dt)
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
    game:update(dt)
end

function love.draw()
    game:draw()
end

function love.keypressed(k)
    if k == 'r' then
        love.load()
    end
end
