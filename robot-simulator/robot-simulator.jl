@enum Heading NORTH EAST SOUTH WEST 

struct Point
    x::Int
    y::Int
end
mutable struct Robot
    x::Int
    y::Int
    heading::Heading

    function Robot(pos, facing::Heading)

        new(pos[1], pos[2], facing)
    end
end

position(marvin::Robot) = Point(marvin.x, marvin.y)
heading(marvin::Robot) = marvin.heading

function turn_right!(marvin::Robot)
    marvin.heading = (Int(marvin.heading) +1) % 4 |> Heading
    return marvin
end

function turn_left!(marvin::Robot)
    marvin.heading = (Int(marvin.heading) +3) % 4 |> Heading
    return marvin
end

function advance!(marvin::Robot)
    marvin.heading == NORTH && (marvin.y += 1)
    marvin.heading == EAST && (marvin.x += 1)
    marvin.heading == SOUTH && (marvin.y -= 1)
    marvin.heading == WEST && (marvin.x -= 1)
    return marvin
end

function move!(marvin::Robot, instruction::String) 
    for i in instruction
        i == 'A' && advance!(marvin)
        i == 'L' && turn_left!(marvin)
        i == 'R' && turn_right!(marvin)
    end
    return marvin
end
