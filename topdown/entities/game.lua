Game = class('Game')

local layer

function Game:initialize()
    self.dark = false
    self.show_bump = false
    self.world_objects = {}
    self.map = sti.new('assets/maps/test2.lua')
    -- self.map:addCustomLayer("Sprite Layer", 6)
    self.map_offset = vector(0, 0)
    self.camera = gamera.new(0, 0, 50*64, 30*64)
    self.world = bump.newWorld()
    self.light = assets.images.light700
    for k,object in pairs(self.map.objects) do
        if object.name == "Player" then
            self.player = Player:new(object.x, object.y)
            self.world:add(self.player, self.player.pos.x - self.player.offset.x,
                           self.player.pos.y - self.player.offset.y,
                           self.player.width - 0,
                           self.player.height - 10)
        end
        if object.name == "Zombie" then
            z = Zombie:new(object.x, object.y)
            table.insert(self.world_objects, z)
            self.world:add(z, z.pos.x - z.offset.x,
                           z.pos.y - z.offset.y,
                           z.width - 0,
                           z.height - 10)
       end
        if object.name == "Wall" then
            local w = Wall:new(object.x, object.y, object.width, object.height)
            self.world:add(w, w.x, w.y, w.width, w.height)
        end
    end
end

local playerFilter = function(item, other)
    if other:isInstanceOf(Wall) then return 'slide' end
    if other:isInstanceOf(Zombie) then return 'slide' end
end

local objectFilter = function(item, other)
    if other:isInstanceOf(Wall) then return 'bounce' end
    if other:isInstanceOf(Player) then return 'touch' end
    if other:isInstanceOf(Zombie) then return 'bounce' end
end

function Game:update(dt)
    local d = vector(1, 0)
    self.map:update(dt)
    self.player:update(dt)
    -- collide player with objects
    local actX, actY, cols, len = self.world:move(self.player, self.player.pos.x,
    self.player.pos.y, playerFilter)
    for i=1, len do
        if cols[i].other:isInstanceOf(Zombie) then
            self.player.pos = vector(actX, actY)
            -- self.player.vel = self.player.vel * -3
            self.player.vel = vector(-cols[i].other.knockback, 0):rotated(self.player.rot)
        end

        if cols[i].other:isInstanceOf(Wall) then
            -- cols[i].other.color = {0, 255, 0, 255}
            self.player.pos = vector(actX, actY)
            -- if cols[i].type == 'slide' then
            if (cols[i].normal.x < 0 and self.player.vel.x > 0) or (cols[i].normal.x > 0 and self.player.vel.x < 0) then
                self.player.vel.x = 0
                self.player.acc.x = 0
            end
            if (cols[i].normal.y < 0 and self.player.vel.y > 0) then
                self.player.vel.y = 0
                self.player.acc.y = 0
                self.player.on_ground = true
            elseif (cols[i].normal.y > 0 and self.player.vel.y < 0) then
                self.player.vel.y = 0
                self.player.acc.y = 0
            end
            -- end
        end
    end

    for i,o in pairs(self.world_objects) do
        o:update(dt)
        local actX, actY, cols, len = self.world:move(o, o.pos.x, o.pos.y, objectFilter)
        for i=1, len do
            if cols[i].other:isInstanceOf(Wall) then
                -- o.delete = false
                o.pos = vector(actX, actY)
                o.hit = true
                if cols[i].normal.x ~= 0 then
                    o.vel.x = -o.vel.x
                end
                if cols[i].normal.y ~= 0 then
                    o.vel.y = -o.vel.y
                end
            end
            if cols[i].other:isInstanceOf(Zombie) then
                if o:isInstanceOf(Bullet) then
                    cols[i].other.health = cols[i].other.health - 1
                    o.delete = true
                end
            end
            if cols[i].other:isInstanceOf(Player) then
                if o:isInstanceOf(Zombie) then
                    o.pos = vector(actX, actY)
                    cols[i].other.vel = vector(o.knockback, 0):rotated(o.rot)
                end
            end
        end
        if o.delete then
            self.world:remove(o)
            self.world_objects[i] = nil
        end

    end
    self.camera:setPosition(self.player.pos.x, self.player.pos.y)
    -- self.player.on_ground = false


end

function Game:draw()

    self.map_offset.x = math.floor(-self.player.pos.x + love.graphics.getWidth()/2)
    self.map_offset.y = math.floor(-self.player.pos.y + love.graphics.getHeight()/2)
    self.camera:draw(function(l, t, w, h)
        self.map:draw()
        self.player:draw()
        for i,o in pairs(self.world_objects) do
            o:draw()
        end
        -- draw bump.lua rect for each item
        if self.show_bump then
            local items, len = self.world:queryRect(self.player.pos.x - love.graphics.getWidth()/2,
                                                    self.player.pos.y - love.graphics.getHeight()/2,
                                                    love.graphics.getWidth(), love.graphics.getHeight())
            for i=1, len do
                local x,y,w,h = self.world:getRect(items[i])
                love.graphics.setColor(255, 255, 0, 100)
                love.graphics.rectangle('fill', x,y,w,h)
            end
        end
        if self.dark then
            love.graphics.draw(self.light, self.player.pos.x, self.player.pos.y, 0, 1, 1, self.light:getWidth()/2, self.light:getHeight()/2)
        end
    end)
    -- debug stats
    love.graphics.print("P: ("..tostring(math.floor(self.player.pos.x))..","..tostring(math.floor(self.player.pos.y))..")", 5, love.graphics.getHeight() - 20)
    love.graphics.print(tostring(love.timer.getFPS()), love.graphics.getWidth() - 30, love.graphics.getHeight() - 20)
end
