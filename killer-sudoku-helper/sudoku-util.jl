"""
    combinations(digits, n)

Generate all possible combinations of length n from the array of digits.
return a vector of arrays containing the possible combinations.

# Example
```julia-repl
julia> combinations([1,2,3], 2)
[1,2]
[1,3]
[2,3]
```
"""
function combinations(digits, n)
    possibles = [[]]
    for elem in digits, j in eachindex(possibles)
        push!(possibles, [possibles[j]; elem])
    end

    [c for c in possibles if length(c) == n]
end


"""
    fill_cage(digits, total, size)

Return the first of all possible combination of length `size` of the array `digits` that
sums to `total` or an empty array if no combination sums to `total`.
"""
function fill_cage(digits, total, size)
    possibles = combinations(digits, size)

    for possible in possibles
        if sum(possible) == total
            return possible
        end
    end

    return []
end


function combinations_in_cage(total::Int, cage_size::Int, excluded::AbstractArray=[])
    combinations = []
    possible_digits = setdiff([1:1:9;], excluded)
    a_solution = fill_cage(possible_digits, total, cage_size)

    while a_solution != []
        push!(combinations, a_solution)
        possible_digits = setdiff(possible_digits, a_solution)
        a_solution = fill_cage(possible_digits, total, cage_size)
    end

    return combinations |> sort
end
