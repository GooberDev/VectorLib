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
    if x ~= nil and type(x) ~= "number" then
        error("Vector2.new: expected 'x' to be a number, got " .. type(x))
    end
    if y ~= nil and type(y) ~= "number" then
        error("Vector2.new: expected 'y' to be a number, got " .. type(y))
    end
    return setmetatable({x = x or 0, y = y or 0}, Vector2)
end

--- Reads two floats from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector2 instance with the read values.
function Vector2.read_floats_from_memory(address)
    if type(address) ~= "number" then
        error("Vector2.read_floats_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_float(address)
    local y = proc.read_float(address + 0x04)
    return setmetatable({x = x or 0, y = y or 0}, Vector2)
end

--- Reads two 32-bit integers from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector2 instance with the read integer values.
function Vector2.read_ints_from_memory(address)
    if type(address) ~= "number" then
        error("Vector2.read_ints_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_int32(address)
    local y = proc.read_int32(address + 0x04)
    return setmetatable({x = x or 0, y = y or 0}, Vector2)
end

--- Metamethod for vector addition.
-- @param a (Vector2) The first vector.
-- @param b (Vector2) The second vector.
-- @return A new Vector2 instance representing the sum.
function Vector2.__add(a, b)
    if getmetatable(a) ~= Vector2 or getmetatable(b) ~= Vector2 then
        error("Vector2.__add: both operands must be Vector2")
    end
    return Vector2.new(a.x + b.x, a.y + b.y)
end

--- Metamethod for vector subtraction.
-- @param a (Vector2) The first vector.
-- @param b (Vector2) The second vector.
-- @return A new Vector2 instance representing the difference.
function Vector2.__sub(a, b)
    if getmetatable(a) ~= Vector2 or getmetatable(b) ~= Vector2 then
        error("Vector2.__sub: both operands must be Vector2")
    end
    return Vector2.new(a.x - b.x, a.y - b.y)
end

--- Metamethod for vector multiplication (scalar multiplication).
-- @param a (Vector2 or number) A vector or a scalar.
-- @param b (Vector2 or number) A vector or a scalar.
-- @return A new Vector2 instance representing the product.
function Vector2.__mul(a, b)
    if type(a) == "number" and getmetatable(b) == Vector2 then
        return Vector2.new(a * b.x, a * b.y)
    elseif type(b) == "number" and getmetatable(a) == Vector2 then
        return Vector2.new(a.x * b, a.y * b)
    else
        error("Vector2.__mul: one operand must be a number and the other a Vector2")
    end
end

--- Metamethod for vector division (scalar division).
-- @param a (Vector2) The vector.
-- @param b (number) The scalar.
-- @return A new Vector2 instance representing the division result.
function Vector2.__div(a, b)
    if getmetatable(a) ~= Vector2 then
        error("Vector2.__div: the first operand must be a Vector2")
    end
    if type(b) ~= "number" then
        error("Vector2.__div: the second operand must be a number")
    end
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
    if mag == 0 then
        return Vector2.new(0, 0)
    else
        return self / mag
    end
end

--- Computes the dot product with another vector.
-- @param other (Vector2) The other vector.
-- @return The dot product as a number.
function Vector2:Dot(other)
    if getmetatable(other) ~= Vector2 then
        error("Vector2:Dot: expected 'other' to be a Vector2")
    end
    return self.x * other.x + self.y * other.y
end

--- Projects this vector onto another vector.
-- @param other (Vector2) The vector to project onto.
-- @return A new Vector2 instance that is the projection result.
function Vector2:Project(other)
    if getmetatable(other) ~= Vector2 then
        error("Vector2:Project: expected 'other' to be a Vector2")
    end
    local otherMagSq = other:Magnitude()^2
    if otherMagSq == 0 then
        error("Vector2:Project: cannot project onto a zero-magnitude vector")
    end
    return (self:Dot(other) / otherMagSq) * other
end

--- Computes the angle between this vector and another.
-- @param other (Vector2) The other vector.
-- @return The angle in radians.
function Vector2:AngleBetween(other)
    if getmetatable(other) ~= Vector2 then
        error("Vector2:AngleBetween: expected 'other' to be a Vector2")
    end
    local magProduct = self:Magnitude() * other:Magnitude()
    if magProduct == 0 then
        error("Vector2:AngleBetween: cannot compute angle with a zero-magnitude vector")
    end
    local cosine = math.max(-1, math.min(1, self:Dot(other) / magProduct))
    return math.acos(cosine)
end
--- Computes the distance to another vector.
-- @param other (Vector3) The other vector.
-- @return The distance as a number.
function Vector2:DistTo(other)
    if getmetatable(other) ~= Vector2 then
        error("Vector2:DistTo: expected 'other' to be a Vector2")
    end
    return (self - other):Magnitude()
end
--- Linearly interpolates between this vector and another.
-- @param other (Vector2) The target vector.
-- @param t (number) The interpolation factor between 0 and 1.
-- @return A new Vector2 instance representing the interpolated vector.
function Vector2:Lerp(other, t)
    if getmetatable(other) ~= Vector2 then
        error("Vector2:Lerp: expected 'other' to be a Vector2")
    end
    if type(t) ~= "number" then
        error("Vector2:Lerp: expected 't' to be a number")
    end
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
    if x ~= nil and type(x) ~= "number" then
        error("Vector3.new: expected 'x' to be a number, got " .. type(x))
    end
    if y ~= nil and type(y) ~= "number" then
        error("Vector3.new: expected 'y' to be a number, got " .. type(y))
    end
    if z ~= nil and type(z) ~= "number" then
        error("Vector3.new: expected 'z' to be a number, got " .. type(z))
    end
    return setmetatable({x = x or 0, y = y or 0, z = z or 0}, Vector3)
end

--- Reads three floats from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector3 instance with the read values.
function Vector3.read_floats_from_memory(address)
    if type(address) ~= "number" then
        error("Vector3.read_floats_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_float(address)
    local y = proc.read_float(address + 0x04)
    local z = proc.read_float(address + 0x08)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0}, Vector3)
end

--- Reads three 32-bit integers from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector3 instance with the read integer values.
function Vector3.read_ints_from_memory(address)
    if type(address) ~= "number" then
        error("Vector3.read_ints_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_int32(address)
    local y = proc.read_int32(address + 0x04)
    local z = proc.read_int32(address + 0x08)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0}, Vector3)
end

--- Metamethod for vector addition.
-- @param a (Vector3) The first vector.
-- @param b (Vector3) The second vector.
-- @return A new Vector3 instance representing the sum.
function Vector3.__add(a, b)
    if getmetatable(a) ~= Vector3 or getmetatable(b) ~= Vector3 then
        error("Vector3.__add: both operands must be Vector3")
    end
    return Vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
end

--- Metamethod for vector subtraction.
-- @param a (Vector3) The first vector.
-- @param b (Vector3) The second vector.
-- @return A new Vector3 instance representing the difference.
function Vector3.__sub(a, b)
    if getmetatable(a) ~= Vector3 or getmetatable(b) ~= Vector3 then
        error("Vector3.__sub: both operands must be Vector3")
    end
    return Vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
end

--- Metamethod for vector multiplication (scalar multiplication).
-- @param a (Vector3 or number) A vector or a scalar.
-- @param b (Vector3 or number) A vector or a scalar.
-- @return A new Vector3 instance representing the product.
function Vector3.__mul(a, b)
    if type(a) == "number" and getmetatable(b) == Vector3 then
        return Vector3.new(a * b.x, a * b.y, a * b.z)
    elseif type(b) == "number" and getmetatable(a) == Vector3 then
        return Vector3.new(a.x * b, a.y * b, a.z * b)
    else
        error("Vector3.__mul: one operand must be a number and the other a Vector3")
    end
end

--- Metamethod for vector division (scalar division).
-- @param a (Vector3) The vector.
-- @param b (number) The scalar.
-- @return A new Vector3 instance representing the division result.
function Vector3.__div(a, b)
    if getmetatable(a) ~= Vector3 then
        error("Vector3.__div: the first operand must be a Vector3")
    end
    if type(b) ~= "number" then
        error("Vector3.__div: the second operand must be a number")
    end
    return Vector3.new(a.x / b, a.y / b, a.z / b)
end

--- Metamethod to convert the vector to a string.
-- @return A string representation of the vector.
function Vector3.__tostring(self)
    return string.format("Vector3(%.2f, %.2f, %.2f)", self.x, self.y, self.z)
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
    if mag == 0 then
        return Vector3.new(0, 0, 0)
    else
        return self / mag
    end
end

--- Computes the dot product with another vector.
-- @param other (Vector3) The other vector.
-- @return The dot product as a number.
function Vector3:Dot(other)
    if getmetatable(other) ~= Vector3 then
        error("Vector3:Dot: expected 'other' to be a Vector3")
    end
    return self.x * other.x + self.y * other.y + self.z * other.z
end

--- Computes the cross product with another vector.
-- @param other (Vector3) The other vector.
-- @return A new Vector3 instance that is the cross product.
function Vector3:Cross(other)
    if getmetatable(other) ~= Vector3 then
        error("Vector3:Cross: expected 'other' to be a Vector3")
    end
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
    if getmetatable(other) ~= Vector3 then
        error("Vector3:DistTo: expected 'other' to be a Vector3")
    end
    return (self - other):Magnitude()
end

--- Projects this vector onto another vector.
-- @param other (Vector3) The vector to project onto.
-- @return A new Vector3 instance that is the projection result.
function Vector3:Project(other)
    if getmetatable(other) ~= Vector3 then
        error("Vector3:Project: expected 'other' to be a Vector3")
    end
    local otherMagSq = other:Magnitude()^2
    if otherMagSq == 0 then
        error("Vector3:Project: cannot project onto a zero-magnitude vector")
    end
    return (self:Dot(other) / otherMagSq) * other
end

--- Projects this vector onto a plane defined by a normal vector.
-- @param normal (Vector3) The normal vector of the plane.
-- @return A new Vector3 instance representing the projection onto the plane.
function Vector3:ProjectOnPlane(normal)
    if getmetatable(normal) ~= Vector3 then
        error("Vector3:ProjectOnPlane: expected 'normal' to be a Vector3")
    end
    return self - (self:Dot(normal) / (normal:Magnitude()^2)) * normal
end

--- Computes the angle between this vector and another.
-- @param other (Vector3) The other vector.
-- @return The angle in radians.
function Vector3:AngleBetween(other)
    if getmetatable(other) ~= Vector3 then
        error("Vector3:AngleBetween: expected 'other' to be a Vector3")
    end
    local magProduct = self:Magnitude() * other:Magnitude()
    if magProduct == 0 then
        error("Vector3:AngleBetween: cannot compute angle with a zero-magnitude vector")
    end
    local cosine = math.max(-1, math.min(1, self:Dot(other) / magProduct))
    return math.acos(cosine)
end

--- Linearly interpolates between this vector and another.
-- @param other (Vector3) The target vector.
-- @param t (number) The interpolation factor between 0 and 1.
-- @return A new Vector3 instance representing the interpolated vector.
function Vector3:Lerp(other, t)
    if getmetatable(other) ~= Vector3 then
        error("Vector3:Lerp: expected 'other' to be a Vector3")
    end
    if type(t) ~= "number" then
        error("Vector3:Lerp: expected 't' to be a number")
    end
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
    if x ~= nil and type(x) ~= "number" then
        error("Vector4.new: expected 'x' to be a number, got " .. type(x))
    end
    if y ~= nil and type(y) ~= "number" then
        error("Vector4.new: expected 'y' to be a number, got " .. type(y))
    end
    if z ~= nil and type(z) ~= "number" then
        error("Vector4.new: expected 'z' to be a number, got " .. type(z))
    end
    if w ~= nil and type(w) ~= "number" then
        error("Vector4.new: expected 'w' to be a number, got " .. type(w))
    end
    return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Vector4)
end

--- Reads four floats from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector4 instance with the read values.
function Vector4.read_floats_from_memory(address)
    if type(address) ~= "number" then
        error("Vector4.read_floats_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_float(address)
    local y = proc.read_float(address + 0x04)
    local z = proc.read_float(address + 0x08)
    local w = proc.read_float(address + 0x0C)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Vector4)
end

--- Reads four 32-bit integers from memory at the provided address.
-- @param address (number) The memory address to read from.
-- @return A new Vector4 instance with the read integer values.
function Vector4.read_ints_from_memory(address)
    if type(address) ~= "number" then
        error("Vector4.read_ints_from_memory: expected 'address' to be a number, got " .. type(address))
    end
    local x = proc.read_int32(address)
    local y = proc.read_int32(address + 0x04)
    local z = proc.read_int32(address + 0x08)
    local w = proc.read_int32(address + 0x0C)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Vector4)
end

--- Metamethod for vector addition.
-- @param a (Vector4) The first vector.
-- @param b (Vector4) The second vector.
-- @return A new Vector4 instance representing the sum.
function Vector4.__add(a, b)
    if getmetatable(a) ~= Vector4 or getmetatable(b) ~= Vector4 then
        error("Vector4.__add: both operands must be Vector4")
    end
    return Vector4.new(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)
end

--- Metamethod for vector subtraction.
-- @param a (Vector4) The first vector.
-- @param b (Vector4) The second vector.
-- @return A new Vector4 instance representing the difference.
function Vector4.__sub(a, b)
    if getmetatable(a) ~= Vector4 or getmetatable(b) ~= Vector4 then
        error("Vector4.__sub: both operands must be Vector4")
    end
    return Vector4.new(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)
end

--- Metamethod for vector multiplication (scalar multiplication).
-- @param a (Vector4 or number) A vector or a scalar.
-- @param b (Vector4 or number) A vector or a scalar.
-- @return A new Vector4 instance representing the product.
function Vector4.__mul(a, b)
    if type(a) == "number" and getmetatable(b) == Vector4 then
        return Vector4.new(a * b.x, a * b.y, a * b.z, a * b.w)
    elseif type(b) == "number" and getmetatable(a) == Vector4 then
        return Vector4.new(a.x * b, a.y * b, a.z * b, a.w * b)
    else
        error("Vector4.__mul: one operand must be a number and the other a Vector4")
    end
end

--- Metamethod for vector division (scalar division).
-- @param a (Vector4) The vector.
-- @param b (number) The scalar divisor.
-- @return A new Vector4 instance representing the division result.
function Vector4.__div(a, b)
    if getmetatable(a) ~= Vector4 then
        error("Vector4.__div: the first operand must be a Vector4")
    end
    if type(b) ~= "number" then
        error("Vector4.__div: the second operand must be a number")
    end
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
    if mag == 0 then
        return Vector4.new(0, 0, 0, 0)
    else
        return self / mag
    end
end

--- Computes the dot product with another vector.
-- @param other (Vector4) The other vector.
-- @return The dot product as a number.
function Vector4:Dot(other)
    if getmetatable(other) ~= Vector4 then
        error("Vector4:Dot: expected 'other' to be a Vector4")
    end
    return self.x * other.x + self.y * other.y + self.z * other.z + self.w * other.w
end

--- Computes the distance between this vector and another.
-- @param other (Vector4) The other vector.
-- @return The Euclidean distance as a number.
function Vector4:DistTo(other)
    if getmetatable(other) ~= Vector4 then
        error("Vector4:DistTo: expected 'other' to be a Vector4")
    end
    return (self - other):Magnitude()
end

--- Linearly interpolates between this vector and another.
-- @param other (Vector4) The target vector.
-- @param t (number) The interpolation factor between 0 and 1.
-- @return A new Vector4 instance representing the interpolated vector.
function Vector4:Lerp(other, t)
    if getmetatable(other) ~= Vector4 then
        error("Vector4:Lerp: expected 'other' to be a Vector4")
    end
    if type(t) ~= "number" then
        error("Vector4:Lerp: expected 't' to be a number")
    end
    return Vector4.new(
        t * (other.x - self.x) + self.x,
        t * (other.y - self.y) + self.y,
        t * (other.z - self.z) + self.z,
        t * (other.w - self.w) + self.w
    )
end

setmetatable(Vector4, {__call = function(_, ...) return Vector4.new(...) end})
