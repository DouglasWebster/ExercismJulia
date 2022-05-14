inequal(side) = (side[1] + side[2]) > side[3]

function is_equilateral(sides):: Bool
    !inequal(sort(sides)) && return false
    length(unique(sides)) == 1
end

function is_isosceles(sides)
    !inequal(sort(sides)) && return false
    length(unique(sides)) < 3
end

function is_scalene(sides)
    !inequal(sort(sides)) && return false
    length(unique(sides)) == 3
end