local imageFile
local frames = {}
local cur_frame = 1
local active_frame
local curX = 0

function love.draw()
    love.graphics.draw(imageFile, active_frame, curX, 100)
end

local elapsed_time = 0
function love.update(dt)
    curX = curX + 300 * dt
    if curX > love.graphics.getWidth() then
        curX = 0
    end
    elapsed_time = elapsed_time + dt
    if elapsed_time > 0.1 then
        elapsed_time = 0
        if cur_frame < 6 then
            cur_frame = cur_frame + 1
        else
            cur_frame = 1
        end
        active_frame = frames[cur_frame]
    end
end

function love.load()
    love.graphics.setBackgroundColor(0, 155, 155, 255)
    imageFile = love.graphics.newImage("char9 copy.png")
    frames[1] = love.graphics.newQuad(8, 76, 86, 53, imageFile:getDimensions())
    frames[2] = love.graphics.newQuad(138, 76, 88, 54, imageFile:getDimensions())
    frames[3] = love.graphics.newQuad(268, 78, 92, 50, imageFile:getDimensions())
    frames[4] = love.graphics.newQuad(404, 78, 88, 52, imageFile:getDimensions())
    frames[5] = love.graphics.newQuad(8, 210, 90, 52, imageFile:getDimensions())
    frames[6] = love.graphics.newQuad(144, 208, 90, 52, imageFile:getDimensions())
    active_frame = frames[cur_frame]
end

function love.quit()

end
