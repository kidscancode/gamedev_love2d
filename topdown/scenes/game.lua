local game_screen = state:new()

--[[ State ]]--

function game_screen.load(params)

  game = Game:new()

end

function game_screen.update(dt)
    game:update(dt)
end

function game_screen.draw()
    love.graphics.setBackgroundColor(50, 50, 50)
    game:draw()

end

function game_screen.unload()

  --unload

end

--[[ External ]]--

function love.keypressed(key, scancode, isrepeat)
    if key == 'n' then
        game.dark = not game.dark
    end
end

--[[ End ]]--

return game_screen
