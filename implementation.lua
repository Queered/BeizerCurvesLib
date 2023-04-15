-- It is not meant to work cuz just an implementation

local Bezier = loadstring(game:HttpGet("https://raw.githubusercontent.com/Queered/BeizerCurvesLib/main/lib.lua"))()

-- define the control points of the Bezier curve
local controlPoints = {
    Vector3.new(0, 0, 0),
    Vector3.new(1, 3, 0),
    Vector3.new(2, 0, 0),
    Vector3.new(3, 3, 0),
}

-- create the Bezier curve function
local curve = Bezier.createCurve(controlPoints)

-- draw the Bezier curve using a Part and a Custom Mesh
local curvePart = Instance.new("Part")
curvePart.Size = Vector3.new(0.1, 0.1, 0.1)
curvePart.Anchored = true
curvePart.CanCollide = false
curvePart.Position = Vector3.new(0, 5, 0)

local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.FileMesh
mesh.MeshId = "rbxassetid://1323306"
mesh.TextureId = "rbxassetid://1323308"
mesh.Scale = Vector3.new(0.1, 0.1, 0.1)
mesh.Parent = curvePart

for i = 0, 1, 0.01 do
    local point = curve(i)
    local segmentPart = curvePart:Clone()
    segmentPart.Position = point
    segmentPart.Parent = workspace
end
