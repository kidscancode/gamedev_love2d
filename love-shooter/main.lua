canShoot = true
canShootTimerMax = 0.25
canShootTimer = canShootTimerMax

createEnemyTimerMax = 1
createEnemyTimer = createEnemyTimerMax

enemyImg = nil
enemies = {}

bulletImg = nil
bullets = {}

isAlive = true
score = 0

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.load(arg)
    player = { x = 200, y = 710, speed = 250, img = nil }
    player.img = love.graphics.newImage('assets/ship.png')
    bulletImg = love.graphics.newImage('assets/laser.png')
    enemyImg = love.graphics.newImage('assets/enemy.png')
end

function love.update(dt)
    canShootTimer = canShootTimer - (1 * dt)
    if canShootTimer < 0 then
        canShoot = true
    end

    createEnemyTimer = createEnemyTimer - (1 * dt)
    if createEnemyTimer < 0 then
        createEnemyTimer = createEnemyTimerMax
        ran = math.random(10, love.graphics.getWidth() - 10)
        newEnemy = {x = ran, y = -20, img = enemyImg}
        table.insert(enemies, newEnemy)
    end

    if love.keyboard.isDown('space') and canShoot then
        newBullet = {x = player.x + (player.img:getWidth()/2),
                     y = player.y, img = bulletImg}
        table.insert(bullets, newBullet)
        canShoot = false
        canShootTimer = canShootTimerMax
    end

    for i, bullet in ipairs(bullets) do
        bullet.y = bullet.y - (650 * dt)
        if bullet.y < 0 then
            table.remove(bullets, i)
        end
    end

    for i, enemy in ipairs(enemies) do
        enemy.y = enemy.y + (300 * dt)
        if enemy.y > 850 then
            table.remove(enemies, i)
        end
    end

    for i, enemy in ipairs(enemies) do
        for j, bullet in ipairs(bullets) do
            if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(),
                              bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
                table.remove(bullets, j)
                table.remove(enemies, i)
                score = score + 1
            end
        end
        if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) and isAlive then
            table.remove(enemies, i)
            isAlive = false
        end
    end

    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    if love.keyboard.isDown('left') then
        if player.x > 0 then
            player.x = player.x - (player.speed * dt)
        end
    elseif love.keyboard.isDown('right') then
        if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
            player.x = player.x + (player.speed * dt)
        end
    end

end

function love.draw(dt)
    if isAlive then
        love.graphics.draw(player.img, player.x, player.y)
    else
        love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
    end
    
    for i, bullet in ipairs(bullets) do
        love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end
    for i, enemy in ipairs(enemies) do
        love.graphics.draw(enemy.img, enemy.x, enemy.y)
    end
end
