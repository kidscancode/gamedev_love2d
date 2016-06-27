local splash = state:new()

--[[ State ]]--

function splash.load(params)

  --load

end

function splash.update(dt)


end

function splash.draw()

  love.graphics.print("Press a key", 100, 100, 0, 5, 5)

end

function splash.unload()

    splash = nil

end

--[[ External ]]--

function love.keyreleased(key, scancode, isrepeat)

    if splash ~= nil then
        state:switch("scenes/game", {})
    end
end

--[[ End ]]--

return splash
