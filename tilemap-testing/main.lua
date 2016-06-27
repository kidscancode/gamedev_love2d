tile = {}
for i=0,3 do
    tile[i] = love.graphics.newImage(i..'.png')
end

love.graphics.setNewFont(12)

map_w = 25
map_h = 20
map_x = 0
map_y = 0
map_offset_x = 0
map_offset_y = 0
map_display_w = 20
map_display_h = 15
map_display_buffer = 2
tile_w = 48
tile_h = 48

map={
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 1, 0, 0, 2, 2, 2, 0, 3, 0, 3, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 1, 0, 0, 2, 0, 2, 0, 3, 0, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 1, 1, 0, 2, 2, 2, 0, 0, 3, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 2, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
}

function love.load(arg)
    -- body...
end

function love.update(dt)
    local speed = 300 * dt
    if love.keyboard.isDown('up') then
        map_y = map_y - speed
    end
    if love.keyboard.isDown('down') then
        map_y = map_y + speed
    end
    if love.keyboard.isDown('left') then
        map_x = map_x - speed
    end
    if love.keyboard.isDown('right') then
        map_x = map_x + speed
    end

    -- boundary
    if map_x < 0 then
        map_x = 0
    end
    if map_y < 0 then
        map_y = 0
    end
    if map_x > map_w * tile_w - map_display_w * tile_w - 1 then
        map_x = map_w * tile_w - map_display_w * tile_w - 1
    end
    if map_y > map_h * tile_h - map_display_h * tile_h - 1 then
        map_y = map_h * tile_h - map_display_h * tile_h - 1
    end
end

function draw_map()
    offset_x = map_x % tile_w
    offset_y = map_y % tile_h
    firstTile_x = math.floor(map_x / tile_w)
    firstTile_y = math.floor(map_y / tile_h)

    for y=1, (map_display_h + map_display_buffer) do
        for x=1, (map_display_w + map_display_buffer) do
            if y+firstTile_y >= 1 and y+firstTile_y <= map_h
                and x+firstTile_x >= 1 and x+firstTile_x <= map_w
            then
                love.graphics.draw(tile[map[y+firstTile_y][x+firstTile_x]],
                    ((x-1)*tile_w)-offset_x-tile_w/2, ((y-1)*tile_h)-offset_y-tile_h/2)
            end
        end
    end
end

function love.draw()
    draw_map()
    -- for y=1, map_display_h do
    --     for x=1, map_display_w do
    --         love.graphics.draw(tile[map[y+map_y][x+map_x]], ((x-1)*tile_w)+map_offset_x, ((y-1)*tile_h)+map_offset_y)
    --     end
    -- end
end

function love.keypressed(key, unicode)
    if key == 'escape' then
        love.event.push('quit')
    end
end
