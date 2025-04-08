require("Vector")

--2D Vector Examples
local vec1 = Vector2(2.0, -3.0)
local vec2 = Vector2(1.0, 2.5)

local vec2Sum = vec1 + vec2 -- Vector2(3.0, -0.5)
local vec2Dif = vec1 - vec2 -- Vector2(1.0, -5.5)
local vec2Mul = vec1 * 0.5 -- Vector2(1.0, -1.5)
local vec2Div = vec2 / 2 -- Vector2(0.5, 1.25)
local vec2Str = tostring(vec1) -- "Vector2(2.0, -3.0)"

local mag2 = vec1:Magnitude() -- 3.60555
local norm2 = vec1:Normalize() -- Vector2(0.5547, -0.83205)
local dot2 = vec1:Dot(vec2) -- -5.5
local lerp2 = vec1:Lerp(vec2, 0.5) -- Vector2(1.5, -0.25)
local dist2 = vec1:DistTo(vec2) -- 5.59017
local angle2 = vec1:AngleBetween(vec2) --2.17308 rads
local proj2 = vec1:Project(vec2) -- Vector2(−0.75862, −1.89655)

--3D Vector Examples
local vec3 = Vector3(2.0, -3.0, 1.0)
local vec4 = Vector3(1.0, 2.5, -1.0)

local vec3Sum = vec3 + vec4 -- Vector3(3.0, -0.5, 0.0)
local vec3Dif = vec3 - vec4 -- Vector3(1.0, -5.5, 2.0)
local vec3Mul = vec3 * 0.5 -- Vector3(1.0, -1.5, 0.5)
local vec3Div = vec4 / 2 -- Vector3(0.5, 1.25, -0.5)
local vec3Str = tostring(vec3) -- "Vector3(2.0, -3.0, 1.0)"

local mag3 = vec3:Magnitude() -- 3.74165
local norm3 = vec3:Normalize() -- Vector3(0.53452, -0.80178, 0.26726)
local dot3 = vec3:Dot(vec4) -- -6.5
local dist3 = vec3:DistTo(vec4) -- 5.93717
local lerp3 = vec3:Lerp(vec4, 0.5) -- Vector3(1.5, -0.25, 0.0)
local angle3 = vec3:AngleBetween(vec4) --2.22033 rads
local proj3 = vec3:Project(vec4) -- Vector3(−0.78788, 1.96970, 0.78788)
local projOnPlane3 = vec3:ProjectOnPlane(vec4) --Vector3(2.78788, -1.03030, 0.21212)
local cross = vec3:Cross(vec4) -- Vector3(0.5, 3, 8)

--4D Vector Examples
local vec5 = Vector4(2.0, -3.0, 1.0, -1.0)
local vec6 = Vector4(1.0, 2.5, -1.0, 1.0)

local vec4Sum = vec5 + vec6 -- Vector4(3.0, -0.5, 0.0, 0.0)
local vec4Dif = vec5 - vec6 -- Vector4(1.0, -5.5, 2.0, -2.0)
local vec4Mul = vec5 * 0.5 -- Vector4(1.0, -1.5, 0.5, -0.5)
local vec4Div = vec6 / 2 -- Vector4(0.5, 1.25, -0.5, 0.5)
local vec4Str = tostring(vec5) -- "Vector4(2.0, -3.0, 1.0, -1.0)"

local mag4 = vec5:Magnitude() -- 3.87298
local norm4 = vec5:Normalize() -- Vector4(0.51640, -0.77460, 0.25820, -0.25820)
local dot4 = vec5:Dot(vec6) -- -7.5
local dist4 = vec5:DistTo(vec6) -- 6.26498
local lerp4 = vec5:Lerp(vec6, 0.5) -- Vector4(1.5, -0.25, 0.0, 0.0)
