
local Vector = require "math.Vector"
local Polygon = require "math.Polygon"
local Line = require "math.Line"
local Lightning = require "hikari.Lightning"
local Light = require "hikari.Light"

local lightworld
local light = Light:new(400, 250, 600)
light.color = {125, 255, 25, 100}

local light2 = Light:new(400, 250, 400)
light2.color = {55, 100, 255, 100}

function love.load()
  lightworld = Lightning:new()
  lightworld.ambientColor = {0, 0, 0, 255}
  lightworld:addObject(Polygon:new({Vector:new(200, 200), Vector:new(300, 200), Vector:new(300, 300), Vector:new(225, 375), Vector:new(200, 300)}))
  lightworld:addObject(Polygon:new({Vector:new(500, 500), Vector:new(700, 500), Vector:new(650, 650)}))
  
  lightworld:addObject(Polygon:new({Vector:new(900, 300), Vector:new(1100, 400), Vector:new(1000, 700)}))
  lightworld:addLight(light2)
  lightworld:addLight(light)
end

function love.draw()
  love.graphics.setColor(255, 255, 255, 255)
  lightworld:render()
end

function love.update(dt)
  love.window.setTitle("fps: "..math.ceil(1/dt))
  light.x = love.mouse.getX()
  light.y = love.mouse.getY()
  light:updateShader()
end