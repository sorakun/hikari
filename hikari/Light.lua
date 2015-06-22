

local class = require("middleclass")
local Vector = require "math.Vector"

local Light = class ("Light", Vector)

function Light:initialize(x, y, radius)
  Vector.initialize(self, x, y)
  self.color = {255, 255, 255, 200}
  self.radius = radius
  self.shader = love.graphics.newShader("resources/shaders/light.glsl")
  self:updateShader()
end

function Light:updateShader()
  self.shader:send("lightX", self.x)
  self.shader:send("lightY", self.y)
  self.shader:send("lightRadius", self.radius)
  self.shader:send("screenH", love.window.getHeight())
end

function Light:render()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
  love.graphics.setShader(self.shader)
  love.graphics.circle("fill", self.x, self.y, self.radius, self.radius)
  love.graphics.setShader()
end

return Light