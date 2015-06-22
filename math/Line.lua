

local class = require("middleclass")

local Line = class ("Line")

function Line:initialize(v1, v2)
  self.startVertex = v1
  self.endVertex   = v2
end

return Line
