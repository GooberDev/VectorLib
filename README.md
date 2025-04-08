# VectorLib
## A vector library made in lua, for lua.
Made using the perception.cx api, and requires the perception.cx api for proper use.

As for the library, it includes support for Vector2, Vector3, and Vector4.

To use the library, simply include the line ```require("Vector")``` at the top of your script.


To create a simple Vector of your desired length(2, 3, or 4) you can follow in the footsteps of the following code snippets.

```lua
local vec2 = Vector2(-1, 2.1)
local vec3 = Vector3(-0.3, 1, 0)
local vec4 = Vector4(0.939, -0.3, 4, -6)
```

To create a debug vector(uses error handling) you can create them using the suffix "_d"
```lua
local vec2_d = Vector2_d(-1, 2.1)
local vec3_d = Vector3_d(-0.3, 1, 0)
local vec4_d = Vector4_d(0.939, -0.3, 4, -6)
```

You can also create a vector with elements straight from an applications memory through he use of the following functions.

This does assume that the elements are in successions of eachother. (4 bytes per element therefor either an integer or a float)

Replace "address" with the actual address to the first element in the vector stored in memory
You can also use the suffix "_d" here for a debug vector
```lua
local vec2Integers = Vector2.read_ints_from_memory(address)
local vec2Floats = Vector2.read_floats_from_memory(address)
local vec3Integers = Vector3.read_ints_from_memory(address)
local vec3Floats = Vector3.read_floats_from_memory(address)
local vec4Integers = Vector4.read_ints_from_memory(address)
local vec4Floats = Vector4.read_floats_from_memory(address
```
\

To actually access the elements of the vector, you can use the x, y, z, and w fields. (Whether or not that field exists depends on the vector length)
```lua
local vec2ComponentX, vec2ComponentY = vec2.x, vec2.y
local vec3ComponentX, vec3ComponentY, vec3ComponentZ = vec3.x, vec3.y, vec3.z
local vec4ComponentX, vec4ComponentY, vec4ComponentZ, vec4ComponentW = vec4.x, vec4.y, vec4.z, vec4.w
```

Each vector type natively supports the following operations and functions regardless of vector size.

```lua
local vecSum = vec1 + vec2 -- Returns the sum of the two vectors.
local vecDif = vec1 - vec2 -- Returns the difference of the two vectors.
local vecProd = vec1 * 0.5 -- Returns the vector multiplied by a scalar (scalar is just a number).
local vecQuot = vec1 / 2 -- Returns the vector divided by a scalar.
local vecString = tostring(vec1) -- Conversion to a string (2 decimal places of precision).
local mag = vec1:Magnitude() -- Returns the magnitude of the vector.
local norm = vec1:Normalize() -- Returns the normalize vector (the magnitude is transformed into 1).
local dot = vec1:Dot(vec2) -- Returns the dot product of the two vectors.
local lerp = vec1:Lerp(vec2, t) -- Returns the linear interpolation of the two vectors given a blend factor t between 0-1.
local dist = vec1:DistTo(vec2) -- Returns the distance from one vector to another.
```

Now, for the size dependent functions
Vector2:

```lua
local proj2 = vec1:Project(vec2) -- Returns the vector projection of vec1 onto vec2.
local angle2 = vec1:AngleBetween(vec2) -- Returns the angle between the two vectors in radians.
```

Vector3:

```lua
local proj3 = vec1:Project(vec2) -- Returns the vector project of vec1 onto vec2.
local projOnPlane3 = vec1:ProjectOnPlane(vec2) -- Returns the vector projection of vec1 onto a plane with a normal vector vec2.
local angle3 = vec1:AngleBetween(vec2) -- Returns the angle between the two vectors in radians.
local cross = vec1:Cross(vec2) -- Returns the cross product of vec1 and vec2 (vec1 x vec2)
```

Vector4:

```As it stands I have no specific functions for Vector4, kinda just here for colours 🤷‍♂️```

If you find bugs or suggestions (Providing the code would be nice though not necessary), feel free to contact me at ".shome" on discord, so long as you are in the perception discord, you should be able to message me.
