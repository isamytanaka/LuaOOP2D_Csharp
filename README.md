![](luacs.png)
# LuaOOP2D

[![License: MIT](https://img.shields.io/badge/License-MIT-FFD700?style=flat&logo=opensourceinitiative&logoColor=black)](https://opensource.org/licenses/MIT)
[![Issues](https://img.shields.io/badge/Issues-Open%20Issues-FF4500?style=flat&logo=github&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp/issues)
[![Commits](https://img.shields.io/badge/Commits-Activity-1E90FF?style=flat&logo=git&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp/commits)
[![Stars](https://img.shields.io/badge/Stars-Project%20Stars-FFD700?style=flat&logo=github&logoColor=black)](https://github.com/isamytanaka/LuaOOP2D_Csharp/stargazers)
[![Version](https://img.shields.io/badge/Version-Latest%20Release-DC143C?style=flat&logo=semver&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp/releases)
[![Last Release](https://img.shields.io/badge/Last%20Release-Date-8A2BE2?style=flat&logo=calendar&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp/releases)
[![Created](https://img.shields.io/badge/Created-Since%20Start-32CD32?style=flat&logo=github&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp)
[![Forks](https://img.shields.io/badge/Forks-Network%20Members-A9A9A9?style=flat&logo=git&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp/network/members)
[![Repo Size](https://img.shields.io/badge/Repo%20Size-Storage%20Used-1E90FF?style=flat&logo=databricks&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp)
[![Creator](https://img.shields.io/badge/Creator-Isamy-4169E1?style=flat&logo=github&logoColor=white)](https://github.com/isamytanaka)
[![Language](https://img.shields.io/badge/Languages-Lua%20%7C%20C%23-9932CC?style=flat&logo=lua&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp)
[![Downloads](https://img.shields.io/badge/Downloads-Total%20Downloads-00FA9A?style=flat&logo=download&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp/releases)
[![Last Commit](https://img.shields.io/badge/Last%20Commit-Date-FF6347?style=flat&logo=git&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp/commits)
[![Contributors](https://img.shields.io/badge/Contributors-People%20Helping-FF8C00?style=flat&logo=github&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp/graphs/contributors)
[![Releases](https://img.shields.io/badge/Releases-Total%20Count-DC143C?style=flat&logo=github&logoColor=white)](https://github.com/isamytanaka/LuaOOP2D_Csharp/releases)

A memory-efficient 2D object library for Lua with C# export capabilities.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Creating Classes](#creating-classes)
  - [Inheritance](#inheritance)
  - [Working with 2D Objects](#working-with-2d-objects)
  - [Vector2 Operations](#vector2-operations)
  - [C# Export](#c-export)
- [API Reference](#api-reference)
  - [Core Functions](#core-functions)
  - [Geometric Objects](#geometric-objects)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Introduction

LuaOOP2D is a lightweight, memory-efficient library that provides object-oriented programming capabilities for 2D graphics and geometry applications in Lua. It also includes functionality to export the classes to C#, allowing for cross-language development.

The library includes predefined geometric shapes (Circle, Rectangle, Triangle, Polygon) and supports inheritance, custom attributes, methods, and basic transformations like position, rotation, and scale.

## Features

- Full object-oriented programming paradigm in Lua
- Memory-efficient implementation
- Class inheritance system
- Predefined 2D geometric shapes
- Transform properties (position, rotation, scale)
- Export capabilities to C#
- Custom attributes and methods
- Unique ID system for object tracking

## Installation

You can install LuaOOP2D by downloading the `LuaOOP2D.lua` file from the repository and including it in your project.

### Using Git

```bash
git clone https://github.com/isamytanaka/LuaOOP2D_Csharp.git
```

### Manual Download

Download the latest release from the [releases page](https://github.com/isamytanaka/LuaOOP2D_Csharp/releases).

### Including in Your Project

```lua
-- Include LuaOOP2D in your project
local LuaOOP2D = require("LuaOOP2D")
```

## Usage

### Creating Classes

You can create custom classes using the `class` function:

```lua
local LuaOOP2D = require("LuaOOP2D")

-- Create a custom class
local Vehicle = LuaOOP2D.class("Vehicle")
    :attribute("speed", 0)
    :attribute("maxSpeed", 100)
    :method("accelerate", function(self, amount)
        self.speed = math.min(self.speed + amount, self.maxSpeed)
    end)
    :method("brake", function(self, amount)
        self.speed = math.max(self.speed - amount, 0)
    end)
    :method("init", function(self, maxSpeed)
        self.maxSpeed = maxSpeed or self.maxSpeed
    end)

-- Create an instance
local car = Vehicle:new(120)
car:accelerate(30)
print("Car speed:", car.speed)  -- Output: 30
```

### Inheritance

Classes can inherit from other classes:

```lua
-- Create a Car class that inherits from Vehicle
local Car = LuaOOP2D.class("Car")
    :extends(Vehicle)
    :attribute("model", "Generic")
    :attribute("doors", 4)
    :method("honk", function(self)
        return "Beep beep!"
    end)

-- Create an instance
local sedan = Car:new(150)
sedan.model = "Sedan"
sedan:accelerate(50)
print("Sedan speed:", sedan.speed)  -- Output: 50
print(sedan:honk())  -- Output: Beep beep!
```

### Working with 2D Objects

LuaOOP2D includes predefined geometric shapes:

```lua
-- Create a circle
local circle = LuaOOP2D.circle(5):new()
print("Circle area:", circle:area())  -- Output: ~78.54 (π * 5²)
print("Circle circumference:", circle:circumference())  -- Output: ~31.42 (2π * 5)

-- Create a rectangle
local rect = LuaOOP2D.rectangle(10, 5):new()
print("Rectangle area:", rect:area())  -- Output: 50 (10 * 5)
print("Rectangle perimeter:", rect:perimeter())  -- Output: 30 (2 * (10 + 5))

-- Create a triangle
local triangle = LuaOOP2D.triangle(3, 4, 5):new()
print("Triangle area:", triangle:area())  -- Output: 6 (Heron's formula)
print("Triangle perimeter:", triangle:perimeter())  -- Output: 12 (3 + 4 + 5)

-- Create a polygon
local polygon = LuaOOP2D.polygon():new()
polygon:addVertex(0, 0)
polygon:addVertex(10, 0)
polygon:addVertex(10, 10)
polygon:addVertex(0, 10)
print("Polygon vertex count:", polygon:vertexCount())  -- Output: 4
```

### Vector2 Operations

```lua
-- Create a vector
local position = LuaOOP2D.vector2(10, 20)
print("X:", position.x, "Y:", position.y)  -- Output: X: 10 Y: 20

-- Use with geometric objects
local circle = LuaOOP2D.circle(5):new()
circle.position = LuaOOP2D.vector2(100, 200)
print("Circle position:", circle.position.x, circle.position.y)  -- Output: Circle position: 100 200
```

### C# Export

You can export your Lua classes to C# using the `exportToCS` function:

```lua
-- Define your classes
LuaOOP2D.circle(5)
LuaOOP2D.rectangle(10, 5)

-- Export to C#
local success = LuaOOP2D.exportToCS()
if success then
    print("Classes exported to LuaOOP2D.cs")
else
    print("Failed to export classes")
end
```

The exported C# code will be saved to `LuaOOP2D.cs` in the same directory.

## API Reference

### Core Functions

#### `LuaOOP2D.class(name)`
Creates a new class with the specified name.

- **Parameters**:
  - `name` (string): The name of the class
- **Returns**: Class table with methods for defining attributes and methods

#### `Class:attribute(name, defaultValue)`
Adds an attribute to the class with an optional default value.

- **Parameters**:
  - `name` (string): The name of the attribute
  - `defaultValue` (any): The default value of the attribute
- **Returns**: Class table for method chaining

#### `Class:method(name, func)`
Adds a method to the class.

- **Parameters**:
  - `name` (string): The name of the method
  - `func` (function): The method function
- **Returns**: Class table for method chaining

#### `Class:extends(parent)`
Makes the class inherit from a parent class.

- **Parameters**:
  - `parent` (class or string): The parent class or its name
- **Returns**: Class table for method chaining

#### `Class:new(...)`
Creates a new instance of the class.

- **Parameters**:
  - `...`: Arguments to pass to the `init` method if it exists
- **Returns**: New instance of the class

#### `LuaOOP2D.vector2(x, y)`
Creates a new 2D vector.

- **Parameters**:
  - `x` (number): X coordinate (default: 0)
  - `y` (number): Y coordinate (default: 0)
- **Returns**: Vector2 table with x and y properties

#### `LuaOOP2D.exportToCS()`
Exports all registered classes to C# code.

- **Returns**: Boolean indicating success or failure

### Geometric Objects

#### `LuaOOP2D.circle(radius)`
Creates a Circle class.

- **Parameters**:
  - `radius` (number): The radius of the circle (default: 1)
- **Returns**: Circle class

#### `LuaOOP2D.rectangle(width, height)`
Creates a Rectangle class.

- **Parameters**:
  - `width` (number): The width of the rectangle (default: 1)
  - `height` (number): The height of the rectangle (default: 1)
- **Returns**: Rectangle class

#### `LuaOOP2D.triangle(a, b, c)`
Creates a Triangle class.

- **Parameters**:
  - `a` (number): Length of the first side (default: 1)
  - `b` (number): Length of the second side (default: 1)
  - `c` (number): Length of the third side (default: 1)
- **Returns**: Triangle class

#### `LuaOOP2D.polygon(vertices)`
Creates a Polygon class.

- **Parameters**:
  - `vertices` (table): Initial vertices (default: empty table)
- **Returns**: Polygon class

## Examples

### Creating a Custom Shape

```lua
local LuaOOP2D = require("LuaOOP2D")

-- Create a custom Ellipse class
local Ellipse = LuaOOP2D.class("Ellipse")
    :attribute("radiusX", 1)
    :attribute("radiusY", 0.5)
    :method("area", function(self)
        return math.pi * self.radiusX * self.radiusY
    end)
    :method("perimeter", function(self)
        -- Approximation of ellipse perimeter
        local a, b = self.radiusX, self.radiusY
        return math.pi * (3 * (a + b) - math.sqrt((3 * a + b) * (a + 3 * b)))
    end)
    :method("init", function(self, rx, ry)
        if rx then self.radiusX = rx end
        if ry then self.radiusY = ry end
    end)

-- Create an instance
local ellipse = Ellipse:new(3, 2)
print("Ellipse area:", ellipse:area())  -- Output: ~18.85 (π * 3 * 2)
```

### Game Object Example

```lua
local LuaOOP2D = require("LuaOOP2D")

-- Create a GameObject class
local GameObject = LuaOOP2D.class("GameObject")
    :attribute("name", "Object")
    :attribute("active", true)
    :attribute("velocity", LuaOOP2D.vector2(0, 0))
    :method("update", function(self, deltaTime)
        -- Update position based on velocity
        self.position.x = self.position.x + self.velocity.x * deltaTime
        self.position.y = self.position.y + self.velocity.y * deltaTime
    end)
    :method("enable", function(self)
        self.active = true
    end)
    :method("disable", function(self)
        self.active = false
    end)

-- Create a Player class that inherits from GameObject
local Player = LuaOOP2D.class("Player")
    :extends(GameObject)
    :attribute("health", 100)
    :attribute("speed", 5)
    :method("init", function(self, name)
        self.name = name or "Player"
    end)
    :method("moveLeft", function(self)
        self.velocity.x = -self.speed
    end)
    :method("moveRight", function(self)
        self.velocity.x = self.speed
    end)
    :method("jump", function(self)
        self.velocity.y = 10
    end)
    :method("takeDamage", function(self, amount)
        self.health = math.max(0, self.health - amount)
        if self.health == 0 then
            print(self.name .. " has been defeated!")
        end
    end)

-- Create and use a player
local player = Player:new("Hero")
player.position = LuaOOP2D.vector2(100, 0)
player:moveRight()
player:update(0.1)  -- Update with deltaTime of 0.1
print("Player position:", player.position.x, player.position.y)  -- Output: ~100.5, 0
player:takeDamage(30)
print("Player health:", player.health)  -- Output: 70
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/isamytanaka/LuaOOP2D_Csharp/blob/main/LICENSE) file for details.
