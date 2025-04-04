-- LuaOOP2D: A memory-efficient 2D object library with C# export

local LuaOOP2D = {}
local classRegistry = {}
local instanceCounter = 0

local function deepCopy(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do
        res[k] = type(v) == 'table' and deepCopy(v) or v
    end
    return res
end

function LuaOOP2D.class(name)
    local newClass = {
        __name = name,
        __attributes = {},
        __methods = {},
        __parent = nil
    }
    
    classRegistry[name] = newClass
    
    function newClass:extends(parent)
        if type(parent) == "string" then
            parent = classRegistry[parent]
        end
        
        if parent then
            self.__parent = parent
            for k, v in pairs(parent.__attributes) do
                self.__attributes[k] = deepCopy(v)
            end
            for k, v in pairs(parent.__methods) do
                self.__methods[k] = v
            end
        end
        
        return self
    end
    
    function newClass:attribute(name, defaultValue)
        self.__attributes[name] = defaultValue
        return self
    end
    
    function newClass:method(name, func)
        self.__methods[name] = func
        return self
    end
    
    function newClass:new(...)
        local instance = {
            __class = self.__name,
            __id = instanceCounter,
            __position = {x = 0, y = 0},
            __rotation = 0,
            __scale = {x = 1, y = 1}
        }
        
        instanceCounter = instanceCounter + 1
        
        for k, v in pairs(self.__attributes) do
            instance[k] = deepCopy(v)
        end
        
        local instanceMethods = {}
        for k, v in pairs(self.__methods) do
            instanceMethods[k] = v
        end
        
        setmetatable(instance, {
            __index = function(t, key)
                if key == "position" then return t.__position end
                if key == "rotation" then return t.__rotation end
                if key == "scale" then return t.__scale end
                return instanceMethods[key]
            end,
            __newindex = function(t, key, value)
                if key == "position" then t.__position = value; return end
                if key == "rotation" then t.__rotation = value; return end
                if key == "scale" then t.__scale = value; return end
                rawset(t, key, value)
            end
        })
        
        if instanceMethods.init then
            instanceMethods.init(instance, ...)
        end
        
        return instance
    end
    
    return newClass
end

function LuaOOP2D.exportToCS()
    local output = "// Generated C# code from LuaOOP2D\n"
    output = output .. "using System;\n"
    output = output .. "using System.Collections.Generic;\n\n"
    output = output .. "namespace LuaOOP2D {\n\n"
    
    output = output .. "    public struct Vector2 {\n"
    output = output .. "        public float x;\n"
    output = output .. "        public float y;\n\n"
    output = output .. "        public Vector2(float x, float y) {\n"
    output = output .. "            this.x = x;\n"
    output = output .. "            this.y = y;\n"
    output = output .. "        }\n"
    output = output .. "    }\n\n"
    
    local processedClasses = {}
    
    local function processClass(className)
        if processedClasses[className] then return end
        processedClasses[className] = true
        
        local class = classRegistry[className]
        
        if class.__parent then
            processClass(class.__parent.__name)
        end
        
        output = output .. "    public class " .. className
        
        if class.__parent then
            output = output .. " : " .. class.__parent.__name
        end
        
        output = output .. " {\n"
        
        if not class.__parent then
            output = output .. "        public int Id { get; private set; }\n"
            output = output .. "        public Vector2 Position { get; set; }\n"
            output = output .. "        public float Rotation { get; set; }\n"
            output = output .. "        public Vector2 Scale { get; set; }\n\n"
        end
        
        for attr, default in pairs(class.__attributes) do
            local csType = "object"
            
            if type(default) == "number" then
                csType = "float"
            elseif type(default) == "string" then
                csType = "string"
            elseif type(default) == "boolean" then
                csType = "bool"
            elseif type(default) == "table" then
                if default.x ~= nil and default.y ~= nil then
                    csType = "Vector2"
                else
                    csType = "Dictionary<string, object>"
                end
            end
            
            output = output .. "        public " .. csType .. " " .. attr .. " { get; set; }\n"
        end
        
        output = output .. "\n        public " .. className .. "() {\n"
        if not class.__parent then
            output = output .. "            Id = GetNextId();\n"
            output = output .. "            Position = new Vector2(0, 0);\n"
            output = output .. "            Rotation = 0;\n"
            output = output .. "            Scale = new Vector2(1, 1);\n"
        end
        
        for attr, default in pairs(class.__attributes) do
            if type(default) == "number" then
                output = output .. "            " .. attr .. " = " .. default .. "f;\n"
            elseif type(default) == "string" then
                output = output .. "            " .. attr .. " = \"" .. default .. "\";\n"
            elseif type(default) == "boolean" then
                output = output .. "            " .. attr .. " = " .. tostring(default) .. ";\n"
            elseif type(default) == "table" then
                if default.x ~= nil and default.y ~= nil then
                    output = output .. "            " .. attr .. " = new Vector2(" .. (default.x or 0) .. "f, " .. (default.y or 0) .. "f);\n"
                else
                    output = output .. "            " .. attr .. " = new Dictionary<string, object>();\n"
                end
            end
        end
        
        output = output .. "        }\n\n"
        
        for method, _ in pairs(class.__methods) do
            if method ~= "init" then
                output = output .. "        public virtual void " .. method .. "() {\n"
                output = output .. "            // Method implementation\n"
                output = output .. "        }\n\n"
            end
        end
        
        if not class.__parent then
            output = output .. "        private static int idCounter = 0;\n"
            output = output .. "        private static int GetNextId() {\n"
            output = output .. "            return idCounter++;\n"
            output = output .. "        }\n"
        end
        
        output = output .. "    }\n\n"
    end
    
    for className, _ in pairs(classRegistry) do
        processClass(className)
    end
    
    output = output .. "}\n"
    
    local file = io.open("LuaOOP2D.cs", "w")
    if file then
        file:write(output)
        file:close()
        return true
    end
    return false
end

function LuaOOP2D.vector2(x, y)
    return {x = x or 0, y = y or 0}
end

-- 2D Objects
function LuaOOP2D.circle(radius)
    return LuaOOP2D.class("Circle")
        :attribute("radius", radius or 1)
        :method("area", function(self)
            return math.pi * self.radius * self.radius
        end)
        :method("circumference", function(self)
            return 2 * math.pi * self.radius
        end)
end

function LuaOOP2D.rectangle(width, height)
    return LuaOOP2D.class("Rectangle")
        :attribute("width", width or 1)
        :attribute("height", height or 1)
        :method("area", function(self)
            return self.width * self.height
        end)
        :method("perimeter", function(self)
            return 2 * (self.width + self.height)
        end)
end

function LuaOOP2D.triangle(a, b, c)
    return LuaOOP2D.class("Triangle")
        :attribute("sides", {a or 1, b or 1, c or 1})
        :method("area", function(self)
            local s = (self.sides[1] + self.sides[2] + self.sides[3]) / 2
            return math.sqrt(s * (s - self.sides[1]) * (s - self.sides[2]) * (s - self.sides[3]))
        end)
        :method("perimeter", function(self)
            return self.sides[1] + self.sides[2] + self.sides[3]
        end)
end

function LuaOOP2D.polygon(vertices)
    return LuaOOP2D.class("Polygon")
        :attribute("vertices", vertices or {})
        :method("addVertex", function(self, x, y)
            table.insert(self.vertices, {x = x, y = y})
        end)
        :method("vertexCount", function(self)
            return #self.vertices
        end)
end

return LuaOOP2D