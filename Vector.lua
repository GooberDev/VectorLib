--[[
    RELEASE SECTION
]] 
--[[  
    Vector2 Library

    Provides a 2D vector type with operations and memory read functions.
]]
Vector2 = {}
Vector2.__index = Vector2

--- Creates a new Vector2 instance.
-- @param x (number, optional) The x-coordinate (defaults to 0).
-- @param y (number, optional) The y-coordinate (defaults to 0).
-- @return A new Vector2 object.
function Vector2.new(x, y)
    return setmetatable({x = x or 0, y = y or 0}, Vector2)
end

--- Reads two floats from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector2 instance with the read values.
function Vector2.read_floats_from_memory(address)
    return setmetatable({x = proc.read_float(address) or 0, y = proc.read_float(address + 0x04) or 0}, Vector2)
end

--- Reads two 32-bit integers from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector2 instance with the read integer values.
function Vector2.read_ints_from_memory(address)
    return setmetatable({x = proc.read_int32(address) or 0, y = proc.read_int32(address + 0x04) or 0}, Vector2)
end

--- Metamethod for vector addition.
-- @param a (Vector2) The first vector.
-- @param b (Vector2) The second vector.
-- @return A new Vector2 instance representing the sum.
function Vector2.__add(a, b)
    return Vector2.new(a.x + b.x, a.y + b.y)
end

--- Metamethod for vector subtraction.
-- @param a (Vector2) The first vector.
-- @param b (Vector2) The second vector.
-- @return A new Vector2 instance representing the difference.
function Vector2.__sub(a, b)
    return Vector2.new(a.x - b.x, a.y - b.y)
end

--- Metamethod for vector multiplication (scalar multiplication).
-- @param a (Vector2 or number) A vector or a scalar.
-- @param b (Vector2 or number) A vector or a scalar.
-- @return A new Vector2 instance representing the product.
function Vector2.__mul(a, b)
    if type(a) == "number" then
        return Vector2.new(a * b.x, a * b.y)
    else
        return Vector2.new(a.x * b, a.y * b)
    end
end

--- Metamethod for vector division (scalar division).
-- @param a (Vector2) The vector.
-- @param b (number) The scalar.
-- @return A new Vector2 instance representing the division result.
function Vector2.__div(a, b)
    return Vector2.new(a.x / b, a.y / b)
end

--- Metamethod to convert the vector to a string.
-- @return A string representation of the vector.
function Vector2.__tostring(self)
    return string.format("Vector2(%.2f, %.2f)", self.x, self.y)
end

--- Computes the magnitude (length) of the vector.
-- @return The magnitude as a number.
function Vector2:Magnitude()
    return math.sqrt(self.x^2 + self.y^2)
end

--- Normalizes the vector (scales it to a magnitude of 1).
-- @return A new normalized Vector2 instance.
function Vector2:Normalize()
    local mag = self:Magnitude()
    return self / mag
end

--- Computes the dot product with another vector.
-- @param other (Vector2) The other vector.
-- @return The dot product as a number.
function Vector2:Dot(other)
    return self.x * other.x + self.y * other.y
end

--- Projects this vector onto another vector.
-- @param other (Vector2) The vector to project onto.
-- @return A new Vector2 instance that is the projection result.
function Vector2:Project(other)
    return (self:Dot(other) / other:Magnitude()^2) * other
end

--- Computes the angle between this vector and another.
-- @param other (Vector2) The other vector.
-- @return The angle in radians.
function Vector2:AngleBetween(other)
    local magProduct = self:Magnitude() * other:Magnitude()
    local cosine = math.max(-1, math.min(1, self:Dot(other) / magProduct))
    return math.acos(cosine)
end
--- Computes the distance to another vector.
-- @param other (Vector3) The other vector.
-- @return The distance as a number.
function Vector2:DistTo(other)
    return (self - other):Magnitude()
end
--- Linearly interpolates between this vector and another.
-- @param other (Vector2) The target vector.
-- @param t (number) The interpolation factor between 0 and 1.
-- @return A new Vector2 instance representing the interpolated vector.
function Vector2:Lerp(other, t)
    return Vector2.new(
        t * (other.x - self.x) + self.x,
        t * (other.y - self.y) + self.y
    )
end

setmetatable(Vector2, {__call = function(_, ...) return Vector2.new(...) end})

--[[  
    Vector3 Library

    Provides a 3D vector type with operations and memory read functions.
]]
Vector3 = {}
Vector3.__index = Vector3

--- Creates a new Vector3 instance.
-- @param x (number, optional) The x-coordinate (defaults to 0).
-- @param y (number, optional) The y-coordinate (defaults to 0).
-- @param z (number, optional) The z-coordinate (defaults to 0).
-- @return A new Vector3 object.
function Vector3.new(x, y, z)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0}, Vector3)
end

--- Reads three floats from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector3 instance with the read values.
function Vector3.read_floats_from_memory(address)
    return setmetatable({x = proc.read_float(address) or 0, y = proc.read_float(address + 0x04) or 0, z = proc.read_float(address + 0x08) or 0}, Vector3)
end

--- Reads three 32-bit integers from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector3 instance with the read integer values.
function Vector3.read_ints_from_memory(address)
    return setmetatable({x = proc.read_int32(address) or 0, y = proc.read_int32(address + 0x04) or 0, z = proc.read_int32(address + 0x08) or 0}, Vector3)
end

--- Metamethod for vector addition.
-- @param a (Vector3) The first vector.
-- @param b (Vector3) The second vector.
-- @return A new Vector3 instance representing the sum.
function Vector3.__add(a, b)
    return Vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
end

--- Metamethod for vector subtraction.
-- @param a (Vector3) The first vector.
-- @param b (Vector3) The second vector.
-- @return A new Vector3 instance representing the difference.
function Vector3.__sub(a, b)
    return Vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
end

--- Metamethod for vector multiplication (scalar multiplication).
-- @param a (Vector3 or number) A vector or a scalar.
-- @param b (Vector3 or number) A vector or a scalar.
-- @return A new Vector3 instance representing the product.
function Vector3.__mul(a, b)
    if type(a) == "number" then
        return Vector3.new(a * b.x, a * b.y, a * b.z)
    else
        return Vector3.new(a.x * b, a.y * b, a.z * b)
    end
end

--- Metamethod for vector division (scalar division).
-- @param a (Vector3) The vector.
-- @param b (number) The scalar.
-- @return A new Vector3 instance representing the division result.
function Vector3.__div(a, b)
    return Vector3.new(a.x / b, a.y / b, a.z / b)
end

--- Metamethod to convert the vector to a string.
-- @return A string representation of the vector.
function Vector3.__tostring(self)
    return string.format("Vector3(%.8f, %.8f, %.8f)", self.x, self.y, self.z)
end

--- Computes the magnitude (length) of the vector.
-- @return The magnitude as a number.
function Vector3:Magnitude()
    return math.sqrt(self.x^2 + self.y^2 + self.z^2)
end

--- Normalizes the vector (scales it to a magnitude of 1).
-- @return A new normalized Vector3 instance.
function Vector3:Normalize()
    local mag = self:Magnitude()
    return self / mag
end

--- Computes the dot product with another vector.
-- @param other (Vector3) The other vector.
-- @return The dot product as a number.
function Vector3:Dot(other)
    return self.x * other.x + self.y * other.y + self.z * other.z
end

--- Computes the cross product with another vector.
-- @param other (Vector3) The other vector.
-- @return A new Vector3 instance that is the cross product.
function Vector3:Cross(other)
    return Vector3.new(
        self.y * other.z - self.z * other.y,
        self.z * other.x - self.x * other.z,
        self.x * other.y - self.y * other.x
    )
end

--- Computes the distance to another vector.
-- @param other (Vector3) The other vector.
-- @return The distance as a number.
function Vector3:DistTo(other)
    return (self - other):Magnitude()
end

--- Projects this vector onto another vector.
-- @param other (Vector3) The vector to project onto.
-- @return A new Vector3 instance that is the projection result.
function Vector3:Project(other)
    return (self:Dot(other) / other:Magnitude()^2) * other
end

--- Projects this vector onto a plane defined by a normal vector.
-- @param normal (Vector3) The normal vector of the plane.
-- @return A new Vector3 instance representing the projection onto the plane.
function Vector3:ProjectOnPlane(normal)
    return self - (self:Dot(normal) / (normal:Magnitude()^2)) * normal
end

--- Computes the angle between this vector and another.
-- @param other (Vector3) The other vector.
-- @return The angle in radians.
function Vector3:AngleBetween(other)
    local magProduct = self:Magnitude() * other:Magnitude()
    local cosine = math.max(-1, math.min(1, self:Dot(other) / magProduct))
    return math.acos(cosine)
end

--- Linearly interpolates between this vector and another.
-- @param other (Vector3) The target vector.
-- @param t (number) The interpolation factor between 0 and 1.
-- @return A new Vector3 instance representing the interpolated vector.
function Vector3:Lerp(other, t)
    return Vector3.new(
        t * (other.x - self.x) + self.x,
        t * (other.y - self.y) + self.y,
        t * (other.z - self.z) + self.z
    )
end

setmetatable(Vector3, {__call = function(_, ...) return Vector3.new(...) end})

--[[  
    Vector4 Library

    Provides a 4D vector type with selected operations and memory read functions.
]]
Vector4 = {}
Vector4.__index = Vector4

--- Creates a new Vector4 instance.
-- @param x (number, optional) The x-coordinate (defaults to 0).
-- @param y (number, optional) The y-coordinate (defaults to 0).
-- @param z (number, optional) The z-coordinate (defaults to 0).
-- @param w (number, optional) The w-coordinate (defaults to 0).
-- @return A new Vector4 object.
function Vector4.new(x, y, z, w)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Vector4)
end

--- Reads four floats from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector4 instance with the read values.
function Vector4.read_floats_from_memory(address)
    return setmetatable({x = proc.read_float(address) or 0, y = proc.read_float(address + 0x04) or 0, z = proc.read_float(address + 0x08) or 0, w = proc.read_float(address + 0x0C) or 0}, Vector4)
end

--- Reads four 32-bit integers from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector4 instance with the read integer values.
function Vector4.read_ints_from_memory(address)
    return setmetatable({x = proc.read_int32(address) or 0, y = proc.read_int32(address + 0x04) or 0, z = proc.read_int32(address + 0x08) or 0, w = proc.read_int32(address + 0x0C) or 0}, Vector4)
end

--- Metamethod for vector addition.
-- @param a (Vector4) The first vector.
-- @param b (Vector4) The second vector.
-- @return A new Vector4 instance representing the sum.
function Vector4.__add(a, b)
    return Vector4.new(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)
end

--- Metamethod for vector subtraction.
-- @param a (Vector4) The first vector.
-- @param b (Vector4) The second vector.
-- @return A new Vector4 instance representing the difference.
function Vector4.__sub(a, b)
    return Vector4.new(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)
end

--- Metamethod for vector multiplication (scalar multiplication).
-- @param a (Vector4 or number) A vector or a scalar.
-- @param b (Vector4 or number) A vector or a scalar.
-- @return A new Vector4 instance representing the product.
function Vector4.__mul(a, b)
    if type(a) == "number" then
        return Vector4.new(a * b.x, a * b.y, a * b.z, a * b.w)
    else 
        return Vector4.new(a.x * b, a.y * b, a.z * b, a.w * b)
    end
end

--- Metamethod for vector division (scalar division).
-- @param a (Vector4) The vector.
-- @param b (number) The scalar divisor.
-- @return A new Vector4 instance representing the division result.
function Vector4.__div(a, b)
    return Vector4.new(a.x / b, a.y / b, a.z / b, a.w / b)
end

--- Metamethod to convert the vector to a string.
-- @return A string representation of the vector.
function Vector4.__tostring(self)
    return string.format("Vector4(%.2f, %.2f, %.2f, %.2f)", self.x, self.y, self.z, self.w)
end

--- Computes the magnitude (length) of the vector.
-- @return The magnitude as a number.
function Vector4:Magnitude()
    return math.sqrt(self.x^2 + self.y^2 + self.z^2 + self.w^2)
end

--- Normalizes the vector (scales it to a magnitude of 1).
-- @return A new normalized Vector4 instance.
function Vector4:Normalize()
    local mag = self:Magnitude()
    return self / mag
end

--- Computes the dot product with another vector.
-- @param other (Vector4) The other vector.
-- @return The dot product as a number.
function Vector4:Dot(other)
    return self.x * other.x + self.y * other.y + self.z * other.z + self.w * other.w
end

--- Computes the distance between this vector and another.
-- @param other (Vector4) The other vector.
-- @return The Euclidean distance as a number.
function Vector4:DistTo(other)
    return (self - other):Magnitude()
end

--- Linearly interpolates between this vector and another.
-- @param other (Vector4) The target vector.
-- @param t (number) The interpolation factor between 0 and 1.
-- @return A new Vector4 instance representing the interpolated vector.
function Vector4:Lerp(other, t)
    return Vector4.new(
        t * (other.x - self.x) + self.x,
        t * (other.y - self.y) + self.y,
        t * (other.z - self.z) + self.z,
        t * (other.w - self.w) + self.w
    )
end

setmetatable(Vector4, {__call = function(_, ...) return Vector4.new(...) end})



--[[
    DEBUG SECTION
]] 
--[[  
    Vector2_d Library

    Provides a 2D vector type with operations and memory read functions.
]]
Vector2_d = {}
Vector2_d.__index = Vector2_d

--- Creates a new Vector2_d instance.
-- @param x (number, optional) The x-coordinate (defaults to 0).
-- @param y (number, optional) The y-coordinate (defaults to 0).
-- @return A new Vector2_d object.
function Vector2_d.new(x, y)
    if x ~= nil and type(x) ~= "number" then
        error("Vector2_d.new: expected 'x' to be a number, got " .. type(x))
    end
    if y ~= nil and type(y) ~= "number" then
        error("Vector2_d.new: expected 'y' to be a number, got " .. type(y))
    end
    return setmetatable({x = x or 0, y = y or 0}, Vector2_d)
end

--- Reads two floats from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector2_d instance with the read values.
function Vector2_d.read_floats_from_memory(address)
    if type(address) ~= "number" then
        error("Vector2_d.read_floats_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_float(address)
    local y = proc.read_float(address + 0x04)
    return setmetatable({x = x or 0, y = y or 0}, Vector2_d)
end

--- Reads two 32-bit integers from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector2_d instance with the read integer values.
function Vector2_d.read_ints_from_memory(address)
    if type(address) ~= "number" then
        error("Vector2_d.read_ints_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_int32(address)
    local y = proc.read_int32(address + 0x04)
    return setmetatable({x = x or 0, y = y or 0}, Vector2_d)
end

--- Metamethod for vector addition.
-- @param a (Vector2_d) The first vector.
-- @param b (Vector2_d) The second vector.
-- @return A new Vector2_d instance representing the sum.
function Vector2_d.__add(a, b)
    if getmetatable(a) ~= Vector2_d or getmetatable(b) ~= Vector2_d then
        error("Vector2_d.__add: both operands must be Vector2_d")
    end
    return Vector2_d.new(a.x + b.x, a.y + b.y)
end

--- Metamethod for vector subtraction.
-- @param a (Vector2_d) The first vector.
-- @param b (Vector2_d) The second vector.
-- @return A new Vector2_d instance representing the difference.
function Vector2_d.__sub(a, b)
    if getmetatable(a) ~= Vector2_d or getmetatable(b) ~= Vector2_d then
        error("Vector2_d.__sub: both operands must be Vector2_d")
    end
    return Vector2_d.new(a.x - b.x, a.y - b.y)
end

--- Metamethod for vector multiplication (scalar multiplication).
-- @param a (Vector2_d or number) A vector or a scalar.
-- @param b (Vector2_d or number) A vector or a scalar.
-- @return A new Vector2_d instance representing the product.
function Vector2_d.__mul(a, b)
    if type(a) == "number" and getmetatable(b) == Vector2_d then
        return Vector2_d.new(a * b.x, a * b.y)
    elseif type(b) == "number" and getmetatable(a) == Vector2_d then
        return Vector2_d.new(a.x * b, a.y * b)
    else
        error("Vector2_d.__mul: one operand must be a number and the other a Vector2_d")
    end
end

--- Metamethod for vector division (scalar division).
-- @param a (Vector2_d) The vector.
-- @param b (number) The scalar.
-- @return A new Vector2_d instance representing the division result.
function Vector2_d.__div(a, b)
    if getmetatable(a) ~= Vector2_d then
        error("Vector2_d.__div: the first operand must be a Vector2_d")
    end
    if type(b) ~= "number" then
        error("Vector2_d.__div: the second operand must be a number")
    end
    return Vector2_d.new(a.x / b, a.y / b)
end

--- Metamethod to convert the vector to a string.
-- @return A string representation of the vector.
function Vector2_d.__tostring(self)
    return string.format("Vector2_d(%.2f, %.2f)", self.x, self.y)
end

--- Computes the magnitude (length) of the vector.
-- @return The magnitude as a number.
function Vector2_d:Magnitude()
    return math.sqrt(self.x^2 + self.y^2)
end

--- Normalizes the vector (scales it to a magnitude of 1).
-- @return A new normalized Vector2_d instance.
function Vector2_d:Normalize()
    local mag = self:Magnitude()
    if mag == 0 then
        return Vector2_d.new(0, 0)
    else
        return self / mag
    end
end

--- Computes the dot product with another vector.
-- @param other (Vector2_d) The other vector.
-- @return The dot product as a number.
function Vector2_d:Dot(other)
    if getmetatable(other) ~= Vector2_d then
        error("Vector2_d:Dot: expected 'other' to be a Vector2_d")
    end
    return self.x * other.x + self.y * other.y
end

--- Projects this vector onto another vector.
-- @param other (Vector2_d) The vector to project onto.
-- @return A new Vector2_d instance that is the projection result.
function Vector2_d:Project(other)
    if getmetatable(other) ~= Vector2_d then
        error("Vector2_d:Project: expected 'other' to be a Vector2_d")
    end
    local otherMagSq = other:Magnitude()^2
    if otherMagSq == 0 then
        error("Vector2_d:Project: cannot project onto a zero-magnitude vector")
    end
    return (self:Dot(other) / otherMagSq) * other
end

--- Computes the angle between this vector and another.
-- @param other (Vector2_d) The other vector.
-- @return The angle in radians.
function Vector2_d:AngleBetween(other)
    if getmetatable(other) ~= Vector2_d then
        error("Vector2_d:AngleBetween: expected 'other' to be a Vector2_d")
    end
    local magProduct = self:Magnitude() * other:Magnitude()
    if magProduct == 0 then
        error("Vector2_d:AngleBetween: cannot compute angle with a zero-magnitude vector")
    end
    local cosine = math.max(-1, math.min(1, self:Dot(other) / magProduct))
    return math.acos(cosine)
end
--- Computes the distance to another vector.
-- @param other (Vector3_d) The other vector.
-- @return The distance as a number.
function Vector2_d:DistTo(other)
    if getmetatable(other) ~= Vector2_d then
        error("Vector2_d:DistTo: expected 'other' to be a Vector2_d")
    end
    return (self - other):Magnitude()
end
--- Linearly interpolates between this vector and another.
-- @param other (Vector2_d) The target vector.
-- @param t (number) The interpolation factor between 0 and 1.
-- @return A new Vector2_d instance representing the interpolated vector.
function Vector2_d:Lerp(other, t)
    if getmetatable(other) ~= Vector2_d then
        error("Vector2_d:Lerp: expected 'other' to be a Vector2_d")
    end
    if type(t) ~= "number" then
        error("Vector2_d:Lerp: expected 't' to be a number")
    end
    return Vector2_d.new(
        t * (other.x - self.x) + self.x,
        t * (other.y - self.y) + self.y
    )
end

setmetatable(Vector2_d, {__call = function(_, ...) return Vector2_d.new(...) end})

--[[  
    Vector3_d Library

    Provides a 3D vector type with operations and memory read functions.
]]
Vector3_d = {}
Vector3_d.__index = Vector3_d

--- Creates a new Vector3_d instance.
-- @param x (number, optional) The x-coordinate (defaults to 0).
-- @param y (number, optional) The y-coordinate (defaults to 0).
-- @param z (number, optional) The z-coordinate (defaults to 0).
-- @return A new Vector3_d object.
function Vector3_d.new(x, y, z)
    if x ~= nil and type(x) ~= "number" then
        error("Vector3_d.new: expected 'x' to be a number, got " .. type(x))
    end
    if y ~= nil and type(y) ~= "number" then
        error("Vector3_d.new: expected 'y' to be a number, got " .. type(y))
    end
    if z ~= nil and type(z) ~= "number" then
        error("Vector3_d.new: expected 'z' to be a number, got " .. type(z))
    end
    return setmetatable({x = x or 0, y = y or 0, z = z or 0}, Vector3_d)
end

--- Reads three floats from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector3_d instance with the read values.
function Vector3_d.read_floats_from_memory(address)
    if type(address) ~= "number" then
        error("Vector3_d.read_floats_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_float(address)
    local y = proc.read_float(address + 0x04)
    local z = proc.read_float(address + 0x08)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0}, Vector3_d)
end

--- Reads three 32-bit integers from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector3_d instance with the read integer values.
function Vector3_d.read_ints_from_memory(address)
    if type(address) ~= "number" then
        error("Vector3_d.read_ints_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_int32(address)
    local y = proc.read_int32(address + 0x04)
    local z = proc.read_int32(address + 0x08)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0}, Vector3_d)
end

--- Metamethod for vector addition.
-- @param a (Vector3_d) The first vector.
-- @param b (Vector3_d) The second vector.
-- @return A new Vector3_d instance representing the sum.
function Vector3_d.__add(a, b)
    if getmetatable(a) ~= Vector3_d or getmetatable(b) ~= Vector3_d then
        error("Vector3_d.__add: both operands must be Vector3_d")
    end
    return Vector3_d.new(a.x + b.x, a.y + b.y, a.z + b.z)
end

--- Metamethod for vector subtraction.
-- @param a (Vector3_d) The first vector.
-- @param b (Vector3_d) The second vector.
-- @return A new Vector3_d instance representing the difference.
function Vector3_d.__sub(a, b)
    if getmetatable(a) ~= Vector3_d or getmetatable(b) ~= Vector3_d then
        error("Vector3_d.__sub: both operands must be Vector3_d")
    end
    return Vector3_d.new(a.x - b.x, a.y - b.y, a.z - b.z)
end

--- Metamethod for vector multiplication (scalar multiplication).
-- @param a (Vector3_d or number) A vector or a scalar.
-- @param b (Vector3_d or number) A vector or a scalar.
-- @return A new Vector3_d instance representing the product.
function Vector3_d.__mul(a, b)
    if type(a) == "number" and getmetatable(b) == Vector3_d then
        return Vector3_d.new(a * b.x, a * b.y, a * b.z)
    elseif type(b) == "number" and getmetatable(a) == Vector3_d then
        return Vector3_d.new(a.x * b, a.y * b, a.z * b)
    else
        error("Vector3_d.__mul: one operand must be a number and the other a Vector3_d")
    end
end

--- Metamethod for vector division (scalar division).
-- @param a (Vector3_d) The vector.
-- @param b (number) The scalar.
-- @return A new Vector3_d instance representing the division result.
function Vector3_d.__div(a, b)
    if getmetatable(a) ~= Vector3_d then
        error("Vector3_d.__div: the first operand must be a Vector3_d")
    end
    if type(b) ~= "number" then
        error("Vector3_d.__div: the second operand must be a number")
    end
    return Vector3_d.new(a.x / b, a.y / b, a.z / b)
end

--- Metamethod to convert the vector to a string.
-- @return A string representation of the vector.
function Vector3_d.__tostring(self)
    return string.format("Vector3_d(%.8f, %.8f, %.8f)", self.x, self.y, self.z)
end

--- Computes the magnitude (length) of the vector.
-- @return The magnitude as a number.
function Vector3_d:Magnitude()
    return math.sqrt(self.x^2 + self.y^2 + self.z^2)
end

--- Normalizes the vector (scales it to a magnitude of 1).
-- @return A new normalized Vector3_d instance.
function Vector3_d:Normalize()
    local mag = self:Magnitude()
    if mag == 0 then
        return Vector3_d.new(0, 0, 0)
    else
        return self / mag
    end
end

--- Computes the dot product with another vector.
-- @param other (Vector3_d) The other vector.
-- @return The dot product as a number.
function Vector3_d:Dot(other)
    if getmetatable(other) ~= Vector3_d then
        error("Vector3_d:Dot: expected 'other' to be a Vector3_d")
    end
    return self.x * other.x + self.y * other.y + self.z * other.z
end

--- Computes the cross product with another vector.
-- @param other (Vector3_d) The other vector.
-- @return A new Vector3_d instance that is the cross product.
function Vector3_d:Cross(other)
    if getmetatable(other) ~= Vector3_d then
        error("Vector3_d:Cross: expected 'other' to be a Vector3_d")
    end
    return Vector3_d.new(
        self.y * other.z - self.z * other.y,
        self.z * other.x - self.x * other.z,
        self.x * other.y - self.y * other.x
    )
end

--- Computes the distance to another vector.
-- @param other (Vector3_d) The other vector.
-- @return The distance as a number.
function Vector3_d:DistTo(other)
    if getmetatable(other) ~= Vector3_d then
        error("Vector3_d:DistTo: expected 'other' to be a Vector3_d")
    end
    return (self - other):Magnitude()
end

--- Projects this vector onto another vector.
-- @param other (Vector3_d) The vector to project onto.
-- @return A new Vector3_d instance that is the projection result.
function Vector3_d:Project(other)
    if getmetatable(other) ~= Vector3_d then
        error("Vector3_d:Project: expected 'other' to be a Vector3_d")
    end
    local otherMagSq = other:Magnitude()^2
    if otherMagSq == 0 then
        error("Vector3_d:Project: cannot project onto a zero-magnitude vector")
    end
    return (self:Dot(other) / otherMagSq) * other
end

--- Projects this vector onto a plane defined by a normal vector.
-- @param normal (Vector3_d) The normal vector of the plane.
-- @return A new Vector3_d instance representing the projection onto the plane.
function Vector3_d:ProjectOnPlane(normal)
    if getmetatable(normal) ~= Vector3_d then
        error("Vector3_d:ProjectOnPlane: expected 'normal' to be a Vector3_d")
    end
    return self - (self:Dot(normal) / (normal:Magnitude()^2)) * normal
end

--- Computes the angle between this vector and another.
-- @param other (Vector3_d) The other vector.
-- @return The angle in radians.
function Vector3_d:AngleBetween(other)
    if getmetatable(other) ~= Vector3_d then
        error("Vector3_d:AngleBetween: expected 'other' to be a Vector3_d")
    end
    local magProduct = self:Magnitude() * other:Magnitude()
    if magProduct == 0 then
        error("Vector3_d:AngleBetween: cannot compute angle with a zero-magnitude vector")
    end
    local cosine = math.max(-1, math.min(1, self:Dot(other) / magProduct))
    return math.acos(cosine)
end

--- Linearly interpolates between this vector and another.
-- @param other (Vector3_d) The target vector.
-- @param t (number) The interpolation factor between 0 and 1.
-- @return A new Vector3_d instance representing the interpolated vector.
function Vector3_d:Lerp(other, t)
    if getmetatable(other) ~= Vector3_d then
        error("Vector3_d:Lerp: expected 'other' to be a Vector3_d")
    end
    if type(t) ~= "number" then
        error("Vector3_d:Lerp: expected 't' to be a number")
    end
    return Vector3_d.new(
        t * (other.x - self.x) + self.x,
        t * (other.y - self.y) + self.y,
        t * (other.z - self.z) + self.z
    )
end

setmetatable(Vector3_d, {__call = function(_, ...) return Vector3_d.new(...) end})

--[[  
    Vector4_d Library

    Provides a 4D vector type with selected operations and memory read functions.
]]
Vector4_d = {}
Vector4_d.__index = Vector4_d

--- Creates a new Vector4_d instance.
-- @param x (number, optional) The x-coordinate (defaults to 0).
-- @param y (number, optional) The y-coordinate (defaults to 0).
-- @param z (number, optional) The z-coordinate (defaults to 0).
-- @param w (number, optional) The w-coordinate (defaults to 0).
-- @return A new Vector4_d object.
function Vector4_d.new(x, y, z, w)
    if x ~= nil and type(x) ~= "number" then
        error("Vector4_d.new: expected 'x' to be a number, got " .. type(x))
    end
    if y ~= nil and type(y) ~= "number" then
        error("Vector4_d.new: expected 'y' to be a number, got " .. type(y))
    end
    if z ~= nil and type(z) ~= "number" then
        error("Vector4_d.new: expected 'z' to be a number, got " .. type(z))
    end
    if w ~= nil and type(w) ~= "number" then
        error("Vector4_d.new: expected 'w' to be a number, got " .. type(w))
    end
    return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Vector4_d)
end

--- Reads four floats from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector4_d instance with the read values.
function Vector4_d.read_floats_from_memory(address)
    if type(address) ~= "number" then
        error("Vector4_d.read_floats_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_float(address)
    local y = proc.read_float(address + 0x04)
    local z = proc.read_float(address + 0x08)
    local w = proc.read_float(address + 0x0C)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Vector4_d)
end

--- Reads four 32-bit integers from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector4_d instance with the read integer values.
function Vector4_d.read_ints_from_memory(address)
    if type(address) ~= "number" then
        error("Vector4_d.read_ints_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_int32(address)
    local y = proc.read_int32(address + 0x04)
    local z = proc.read_int32(address + 0x08)
    local w = proc.read_int32(address + 0x0C)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Vector4_d)
end

--- Metamethod for vector addition.
-- @param a (Vector4_d) The first vector.
-- @param b (Vector4_d) The second vector.
-- @return A new Vector4_d instance representing the sum.
function Vector4_d.__add(a, b)
    if getmetatable(a) ~= Vector4_d or getmetatable(b) ~= Vector4_d then
        error("Vector4_d.__add: both operands must be Vector4_d")
    end
    return Vector4_d.new(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)
end

--- Metamethod for vector subtraction.
-- @param a (Vector4_d) The first vector.
-- @param b (Vector4_d) The second vector.
-- @return A new Vector4_d instance representing the difference.
function Vector4_d.__sub(a, b)
    if getmetatable(a) ~= Vector4_d or getmetatable(b) ~= Vector4_d then
        error("Vector4_d.__sub: both operands must be Vector4_d")
    end
    return Vector4_d.new(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)
end

--- Metamethod for vector multiplication (scalar multiplication).
-- @param a (Vector4_d or number) A vector or a scalar.
-- @param b (Vector4_d or number) A vector or a scalar.
-- @return A new Vector4_d instance representing the product.
function Vector4_d.__mul(a, b)
    if type(a) == "number" and getmetatable(b) == Vector4_d then
        return Vector4_d.new(a * b.x, a * b.y, a * b.z, a * b.w)
    elseif type(b) == "number" and getmetatable(a) == Vector4_d then
        return Vector4_d.new(a.x * b, a.y * b, a.z * b, a.w * b)
    else
        error("Vector4_d.__mul: one operand must be a number and the other a Vector4_d")
    end
end

--- Metamethod for vector division (scalar division).
-- @param a (Vector4_d) The vector.
-- @param b (number) The scalar divisor.
-- @return A new Vector4_d instance representing the division result.
function Vector4_d.__div(a, b)
    if getmetatable(a) ~= Vector4_d then
        error("Vector4_d.__div: the first operand must be a Vector4_d")
    end
    if type(b) ~= "number" then
        error("Vector4_d.__div: the second operand must be a number")
    end
    return Vector4_d.new(a.x / b, a.y / b, a.z / b, a.w / b)
end

--- Metamethod to convert the vector to a string.
-- @return A string representation of the vector.
function Vector4_d.__tostring(self)
    return string.format("Vector4_d(%.2f, %.2f, %.2f, %.2f)", self.x, self.y, self.z, self.w)
end

--- Computes the magnitude (length) of the vector.
-- @return The magnitude as a number.
function Vector4_d:Magnitude()
    return math.sqrt(self.x^2 + self.y^2 + self.z^2 + self.w^2)
end

--- Normalizes the vector (scales it to a magnitude of 1).
-- @return A new normalized Vector4_d instance.
function Vector4_d:Normalize()
    local mag = self:Magnitude()
    if mag == 0 then
        return Vector4_d.new(0, 0, 0, 0)
    else
        return self / mag
    end
end

--- Computes the dot product with another vector.
-- @param other (Vector4_d) The other vector.
-- @return The dot product as a number.
function Vector4_d:Dot(other)
    if getmetatable(other) ~= Vector4_d then
        error("Vector4_d:Dot: expected 'other' to be a Vector4_d")
    end
    return self.x * other.x + self.y * other.y + self.z * other.z + self.w * other.w
end

--- Computes the distance between this vector and another.
-- @param other (Vector4_d) The other vector.
-- @return The Euclidean distance as a number.
function Vector4_d:DistTo(other)
    if getmetatable(other) ~= Vector4_d then
        error("Vector4_d:DistTo: expected 'other' to be a Vector4_d")
    end
    return (self - other):Magnitude()
end

--- Linearly interpolates between this vector and another.
-- @param other (Vector4_d) The target vector.
-- @param t (number) The interpolation factor between 0 and 1.
-- @return A new Vector4_d instance representing the interpolated vector.
function Vector4_d:Lerp(other, t)
    if getmetatable(other) ~= Vector4_d then
        error("Vector4_d:Lerp: expected 'other' to be a Vector4_d")
    end
    if type(t) ~= "number" then
        error("Vector4_d:Lerp: expected 't' to be a number")
    end
    return Vector4_d.new(
        t * (other.x - self.x) + self.x,
        t * (other.y - self.y) + self.y,
        t * (other.z - self.z) + self.z,
        t * (other.w - self.w) + self.w
    )
end

setmetatable(Vector4_d, {__call = function(_, ...) return Vector4_d.new(...) end})
