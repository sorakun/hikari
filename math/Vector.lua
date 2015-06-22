

local class = require("middleclass")

local Vector = class ("Vector")

function Vector:initialize(x, y)
  self.x = x
  self.y = y
end

function Vector:length()
  return math.sqrt(self.x * self.x + self.y*self.y)
end

function Vector:distance(v)
  return (self:sub(v)):length()
end

function Vector:normalize()
  local length = self:length()
  return Vector:new(self.x/length, self.y/length)
end

function Vector:add(v)
  return Vector:new(self.x + v.x, self.y + v.y)
end

function Vector:sub(v)
  return Vector:new(self.x - v.x, self.y - v.y)
end

function Vector:mult(v)
  return Vector:new(self.x * v, self.y * v)
end

function Vector:dot(v)
  return self.x * v.x + self.y * v.y
end

function Vector:cross(v)
  return self.x * v.y - self.y * v.x
end

return Vector
