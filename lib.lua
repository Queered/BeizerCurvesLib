local Bezier = {}

-- calculates the point along a quadratic Bezier curve
local function quadraticBezier(p0, p1, p2, t)
    local u = 1 - t
    local uu = u * u
    local tt = t * t
    local p = uu * p0 + 2 * u * t * p1 + tt * p2
    return p
end

-- calculates the point along a cubic Bezier curve
local function cubicBezier(p0, p1, p2, p3, t)
    local u = 1 - t
    local uu = u * u
    local uuu = uu * u
    local tt = t * t
    local ttt = tt * t
    local p = uuu * p0 + 3 * uu * t * p1 + 3 * u * tt * p2 + ttt * p3
    return p
end

-- calculates the point along a Bezier curve of any degree using De Casteljau's algorithm
local function deCasteljau(points, t)
    local n = #points
    if n == 0 then
        error("Cannot create Bezier curve with 0 control points")
    elseif n == 1 then
        return points[1]
    elseif n == 2 then
        return (1 - t) * points[1] + t * points[2]
    end
    
    while n > 1 do
        for i = 1, n - 1 do
            points[i] = (1 - t) * points[i] + t * points[i+1]
        end
        n = n - 1
    end
    return points[1]
end

-- returns a function that calculates a point along a Bezier curve given a t value
function Bezier.createCurve(points)
    if not points or #points < 2 then
        error("Cannot create Bezier curve with less than 2 control points")
    end
    
    local n = #points - 1
    if n == 2 then
        return function(t)
            return quadraticBezier(points[1], points[2], points[3], t)
        end
    elseif n == 3 then
        return function(t)
            return cubicBezier(points[1], points[2], points[3], points[4], t)
        end
    else
        return function(t)
            return deCasteljau(points, t)
        end
    end
end

return Bezier
