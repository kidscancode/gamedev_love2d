--defines directions, their movement functions and their opposite directions
DIRECTIONS = {
    left = { 
        movement = function (snake) snake.x = snake.x - snake.size end,
        opposite = "right" 
    },
    up = { 
        movement = function (snake) snake.y = snake.y - snake.size end,
        opposite = "down" 
    },
    right = { 
        movement = function (snake) snake.x = snake.x + snake.size end,
        opposite = "left" 
    },
    down = { 
        movement = function (snake) snake.y = snake.y + snake.size end,
        opposite = "up" 
    }
}

--defines the delay between steps
DELAY = 0.50

function love.load ()
    --creates the snake's head
    snake = {
        --initial position
        x = 400,
        y = 300,
        size = 10, --snake node size, used for grid-like movement
        direction, nextdirection = "left" --initial movement direction
    }
    
    seconds = 0 --counts the seconds elapsed, used for delayed movement
end

function love.keypressed (key, scancode, isrepeat)
    --checks if pressed key is a valid direction 
    --and not the opposite of the current direction
    if DIRECTIONS[key] ~= nil and snake.direction ~= DIRECTIONS[key].opposite then
        snake.nextdirection = key --change the snake's next direction
    end
end

function love.update (dt)
    --we add the time passed since the last update, probably a very small number like 0.01
    seconds = seconds + dt
    
    --checks if the delay time has passed
    if seconds >= DELAY then
        --reduces our counter by the delay time
        seconds = seconds - DELAY
    
        --updates the snake's direction
        snake.direction = snake.nextdirection
        
        --moves the snake according to its current direction
        DIRECTIONS[snake.direction].movement(snake)
    end
end

function love.draw ()
    --draw snake
    love.graphics.rectangle("fill", snake.x, snake.y, snake.size, snake.size)
end
