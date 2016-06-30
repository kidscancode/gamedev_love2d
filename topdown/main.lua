-- Copyright 2016 KidsCanCode
-- KidsCanCode
-- Art by kenney.nl

io.stdout:setvbuf('no') --fixes print issues

--//////////////////////////////////--
--//-\\-//-[[- SETTINGS -]]-\\-//-\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

WWIDTH, WHEIGHT = 1200,800 --Game dimensions - 1920/1080 = 16/9 aspect ratio

--//////////////////////////////////--
--//-\\-//-[[- INCLUDES -]]-\\-//-\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

--Libraries
push = require "lib.push"
screen = require "lib.shack" --Screen effects (shake, rotate, shear, scale)
lem = require "lib.lem" --Event manager
lue = require "lib.lue" --Hue
state = require "lib.stager" --Manages scenes and transitions
--audio = require "lib.wave" --Audio manager/parser
class = require 'lib.middleclass' -- Classes
vector = require 'lib.vector' -- hump.lua vector class
bump = require 'lib.bump' -- collision detection
gamera = require 'lib.gamera' -- camera
assets = require('lib.cargo').init('assets')  -- simple asset management
sti = require('lib.sti') -- Tiled library

--///////////////////////////////--
--//-\\-//-[[- SETUP -]]-\\-//-\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

local os = love.system.getOS()

phoneMode = (os == "iOS" or os == "Android") and true or false --handles mobile platforms
fullscreenMode = phoneMode and true or false --enables fullscreen if on mobile

local windowWidth, windowHeight = love.window.getDesktopDimensions()

if fullscreenMode then
  RWIDTH, RHEIGHT = windowWidth, windowHeight
else
  RWIDTH = WWIDTH RHEIGHT = WHEIGHT
end

push:setupScreen(WWIDTH, WHEIGHT, RWIDTH, RHEIGHT, {fullscreen = fullscreenMode, resizable = not phoneMode})

--///////////////////////////////////--
--//-\\-//-[[- FUNCTIONS -]]-\\-//-\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

function love.load()

    require "entities/game"
    require "entities/player"
    require "entities/wall"
    require "entities/bullet"
    require "entities/zombie"

    game = Game:new()
    screen:setDimensions(push:getDimensions())

    state:switch("scenes/splash", {})

end

function love.update(dt)
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
    screen:update(dt)
    lue:update(dt)

    state:update(dt)

end

function love.draw()

  push:apply("start")
  screen:apply()

  state:draw()

  push:apply("end")

end

if not phoneMode then
  function love.resize(w, h)
    return push:resize(w, h)
  end
end
