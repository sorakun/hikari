
local class = require("middleclass")

local Vector = require "math.Vector"
local Polygon = require "math.Polygon"
local Line = require "math.Line"
local Light = require "hikari.Light"

local Lightning = class ("Lightning")

local function projectPoint(p, l)
  local ltp = p:sub(l)
  local extraLength = l.radius - ltp:length()
  
  return p:add(ltp:normalize():mult(extraLength))
end

local function checkDrawLine(line, light)
  local v1 = line.endVertex:sub(line.startVertex)
  local normal = Vector:new(v1.y, -1*v1.x)
  local v2 = line.startVertex:sub(light)
  
  if v2:dot(normal) > 0 then
    if line.startVertex:distance(light) < light.radius or line.endVertex:distance(light) < light.radius then
      return true
    else
      return false
    end
  end
  
  return false
end

function Lightning:initialize()
  self.objects = {}
  self.lights  = {}
  
  self.ambientColor = {255, 255, 255, 255}
  
  self.shader = love.graphics.newShader("resources/shaders/shadow.glsl")
  
  self:updateShader()
end

function Lightning:updateShader()
  self.shader:send("screenH", love.window.getHeight())
  self.canvas = love.graphics.newCanvas(love.window.getWidth(), love.window.getHeight())
end

function Lightning:addObject(o)
  table.insert(self.objects, o)
end

function Lightning:addLight(l)
  table.insert(self.lights, l)
end

function Lightning:render()
  
  love.graphics.setBackgroundColor(self.ambientColor[1], self.ambientColor[2], self.ambientColor[3], self.ambientColor[4])
  
  love.graphics.setBlendMode("additive")
  for _, light in ipairs(self.lights) do
    light:render()
  end
  
  self.canvas:clear()
  
  for _, light in ipairs(self.lights) do 
    self.shader:send("lightX", light.x)
    self.shader:send("lightY", light.y)
    self.shader:send("lightRadius", light.radius)
    
    love.graphics.setBlendMode("alpha")
    for _,v in ipairs(self.objects) do
      for _,l in ipairs(v:getLines()) do
        if checkDrawLine(l, light) then
          -- projected point
          love.graphics.setShader(self.shader)
          local pp = projectPoint(l.startVertex, light)
        
          local pp2 = projectPoint(l.endVertex, light)
        
          love.graphics.setColor(0,0,0, 255)
        
          love.graphics.setColor(0,0,0, 255)
          love.graphics.polygon("fill", l.startVertex.x, l.startVertex.y, pp.x, pp.y, pp2.x, pp2.y, l.endVertex.x, l.endVertex.y) 
          love.graphics.setShader()
        end
      end
    end
  end  
  
  for _,v in ipairs(self.objects) do
    v:render()
  end
end

return Lightning
