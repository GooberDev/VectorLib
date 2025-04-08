require("Vector")

--[[
    RELEASE SECTION
]]


local examples = {}
--2D Vector examples
examples.vec1 = Vector2(2.0, -3.0)
examples.vec2 = Vector2(1.0, 2.5)

examples.vec2Sum = examples.vec1 + examples.vec2 -- Vector2(3.0, -0.5)
examples.vec2Dif = examples.vec1 - examples.vec2 -- Vector2(1.0, -5.5)
examples.vec2Mul = examples.vec1 * 0.5 -- Vector2(1.0, -1.5)
examples.vec2Div = examples.vec2 / 2 -- Vector2(0.5, 1.25)
examples.vec2Str = tostring(examples.vec1) -- "Vector2(2.0, -3.0)"

examples.mag2 = examples.vec1:Magnitude() -- 3.60555
examples.norm2 = examples.vec1:Normalize() -- Vector2(0.5547, -0.83205)
examples.dot2 = examples.vec1:Dot(examples.vec2) -- -5.5
examples.lerp2 = examples.vec1:Lerp(examples.vec2, 0.5) -- Vector2(1.5, -0.25)
examples.dist2 = examples.vec1:DistTo(examples.vec2) -- 5.59017
examples.angle2 = examples.vec1:AngleBetween(examples.vec2) --2.17308 rads
examples.proj2 = examples.vec1:Project(examples.vec2) -- Vector2(−0.75862, −1.89655)

--3D Vector examples
examples.vec3 = Vector3(2.0, -3.0, 1.0)
examples.vec4 = Vector3(1.0, 2.5, -1.0)

examples.vec3Sum = examples.vec3 + examples.vec4 -- Vector3(3.0, -0.5, 0.0)
examples.vec3Dif = examples.vec3 - examples.vec4 -- Vector3(1.0, -5.5, 2.0)
examples.vec3Mul = examples.vec3 * 0.5 -- Vector3(1.0, -1.5, 0.5)
examples.vec3Div = examples.vec4 / 2 -- Vector3(0.5, 1.25, -0.5)
examples.vec3Str = tostring(examples.vec3) -- "Vector3(2.0, -3.0, 1.0)"

examples.mag3 = examples.vec3:Magnitude() -- 3.74165
examples.norm3 = examples.vec3:Normalize() -- Vector3(0.53452, -0.80178, 0.26726)
examples.dot3 = examples.vec3:Dot(examples.vec4) -- -6.5
examples.dist3 = examples.vec3:DistTo(examples.vec4) -- 5.93717
examples.lerp3 = examples.vec3:Lerp(examples.vec4, 0.5) -- Vector3(1.5, -0.25, 0.0)
examples.angle3 = examples.vec3:AngleBetween(examples.vec4) --2.22033 rads
examples.proj3 = examples.vec3:Project(examples.vec4) -- Vector3(−0.78788, 1.96970, 0.78788)
examples.projOnPlane3 = examples.vec3:ProjectOnPlane(examples.vec4) --Vector3(2.78788, -1.03030, 0.21212)
examples.cross = examples.vec3:Cross(examples.vec4) -- Vector3(0.5, 3, 8)

--4D Vector examples
examples.vec5 = Vector4(2.0, -3.0, 1.0, -1.0)
examples.vec6 = Vector4(1.0, 2.5, -1.0, 1.0)

examples.vec4Sum = examples.vec5 + examples.vec6 -- Vector4(3.0, -0.5, 0.0, 0.0)
examples.vec4Dif = examples.vec5 - examples.vec6 -- Vector4(1.0, -5.5, 2.0, -2.0)
examples.vec4Mul = examples.vec5 * 0.5 -- Vector4(1.0, -1.5, 0.5, -0.5)
examples.vec4Div = examples.vec6 / 2 -- Vector4(0.5, 1.25, -0.5, 0.5)
examples.vec4Str = tostring(examples.vec5) -- "Vector4(2.0, -3.0, 1.0, -1.0)"

examples.mag4 = examples.vec5:Magnitude() -- 3.87298
examples.norm4 = examples.vec5:Normalize() -- Vector4(0.51640, -0.77460, 0.25820, -0.25820)
examples.dot4 = examples.vec5:Dot(examples.vec6) -- -7.5
examples.dist4 = examples.vec5:DistTo(examples.vec6) -- 6.26498
examples.lerp4 = examples.vec5:Lerp(examples.vec6, 0.5) -- Vector4(1.5, -0.25, 0.0, 0.0)

for _, value in pairs(examples) do
    engine.log(tostring(value), 255, 255, 255, 255)
end

--[[
    DEBUG SECTION
]]


local examples = {}
--2D Vector examples
examples.vec1 = Vector2(2.0, -3.0)
examples.vec2 = Vector2(1.0, 2.5)

examples.vec2Sum = examples.vec1 + examples.vec2 -- Vector2(3.0, -0.5)
examples.vec2Dif = examples.vec1 - examples.vec2 -- Vector2(1.0, -5.5)
examples.vec2Mul = examples.vec1 * 0.5 -- Vector2(1.0, -1.5)
examples.vec2Div = examples.vec2 / 2 -- Vector2(0.5, 1.25)
examples.vec2Str = tostring(examples.vec1) -- "Vector2(2.0, -3.0)"

examples.mag2 = examples.vec1:Magnitude() -- 3.60555
examples.norm2 = examples.vec1:Normalize() -- Vector2(0.5547, -0.83205)
examples.dot2 = examples.vec1:Dot(examples.vec2) -- -5.5
examples.lerp2 = examples.vec1:Lerp(examples.vec2, 0.5) -- Vector2(1.5, -0.25)
examples.dist2 = examples.vec1:DistTo(examples.vec2) -- 5.59017
examples.angle2 = examples.vec1:AngleBetween(examples.vec2) --2.17308 rads
examples.proj2 = examples.vec1:Project(examples.vec2) -- Vector2(−0.75862, −1.89655)

--3D Vector examples
examples.vec3 = Vector3(2.0, -3.0, 1.0)
examples.vec4 = Vector3(1.0, 2.5, -1.0)

examples.vec3Sum = examples.vec3 + examples.vec4 -- Vector3(3.0, -0.5, 0.0)
examples.vec3Dif = examples.vec3 - examples.vec4 -- Vector3(1.0, -5.5, 2.0)
examples.vec3Mul = examples.vec3 * 0.5 -- Vector3(1.0, -1.5, 0.5)
examples.vec3Div = examples.vec4 / 2 -- Vector3(0.5, 1.25, -0.5)
examples.vec3Str = tostring(examples.vec3) -- "Vector3(2.0, -3.0, 1.0)"

examples.mag3 = examples.vec3:Magnitude() -- 3.74165
examples.norm3 = examples.vec3:Normalize() -- Vector3(0.53452, -0.80178, 0.26726)
examples.dot3 = examples.vec3:Dot(examples.vec4) -- -6.5
examples.dist3 = examples.vec3:DistTo(examples.vec4) -- 5.93717
examples.lerp3 = examples.vec3:Lerp(examples.vec4, 0.5) -- Vector3(1.5, -0.25, 0.0)
examples.angle3 = examples.vec3:AngleBetween(examples.vec4) --2.22033 rads
examples.proj3 = examples.vec3:Project(examples.vec4) -- Vector3(−0.78788, 1.96970, 0.78788)
examples.projOnPlane3 = examples.vec3:ProjectOnPlane(examples.vec4) --Vector3(2.78788, -1.03030, 0.21212)
examples.cross = examples.vec3:Cross(examples.vec4) -- Vector3(0.5, 3, 8)

--4D Vector examples
examples.vec5 = Vector4(2.0, -3.0, 1.0, -1.0)
examples.vec6 = Vector4(1.0, 2.5, -1.0, 1.0)

examples.vec4Sum = examples.vec5 + examples.vec6 -- Vector4(3.0, -0.5, 0.0, 0.0)
examples.vec4Dif = examples.vec5 - examples.vec6 -- Vector4(1.0, -5.5, 2.0, -2.0)
examples.vec4Mul = examples.vec5 * 0.5 -- Vector4(1.0, -1.5, 0.5, -0.5)
examples.vec4Div = examples.vec6 / 2 -- Vector4(0.5, 1.25, -0.5, 0.5)
examples.vec4Str = tostring(examples.vec5) -- "Vector4(2.0, -3.0, 1.0, -1.0)"

examples.mag4 = examples.vec5:Magnitude() -- 3.87298
examples.norm4 = examples.vec5:Normalize() -- Vector4(0.51640, -0.77460, 0.25820, -0.25820)
examples.dot4 = examples.vec5:Dot(examples.vec6) -- -7.5
examples.dist4 = examples.vec5:DistTo(examples.vec6) -- 6.26498
examples.lerp4 = examples.vec5:Lerp(examples.vec6, 0.5) -- Vector4(1.5, -0.25, 0.0, 0.0)

for _, value in pairs(examples) do
    engine.log(tostring(value), 255, 255, 255, 255)
end

