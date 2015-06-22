

local class = require("middleclass")

local Polygon = class ("Polygon")

function Polygon:initialize(points)
  self.vertices = { }
  for _,v in ipairs(points) do
    self:addVertex(v)
  end
end


function Polygon:addVertex(v)
  table.insert(self.vertices, v)
end

function Polygon:getLines()
  local Line = require "math.Line"
  
  local lines = {}
  for i = 1,#self.vertices do
    local v1 = self.vertices[i]
    local v2
    if i + 1 > #self.vertices then
      v2 = self.vertices[1]
    else
      v2 = self.vertices[i+1]
    end
    table.insert(lines, Line:new(v1, v2))
  end
  
  return lines
end

function Polygon:render()
  local verts = {}
  
  love.graphics.setColor(255, 0, 0, 255)
  for i = 1,#self.vertices do
    local v1 = self.vertices[i]
    local v2
    if i + 1 > #self.vertices then
      v2 = self.vertices[1]
    else
      v2 = self.vertices[i+1]
    end
    
    table.insert(verts, v1.x)
    table.insert(verts, v1.y)
    
    love.graphics.line(v1.x, v1.y, v2.x, v2.y)
  end
  
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.polygon("fill", verts)
  
end

return Polygon