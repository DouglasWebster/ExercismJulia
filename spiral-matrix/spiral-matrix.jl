function spiral_matrix(size::Int)
    size == 0 && return Matrix{Int}(undef, 0, 0)
    spiral_matrix = zeros(Int, (size, size))
    top = 1; bottom = size; left = 1; right = size
    n = 1

    while true
        left > right && break
        for i ∈ left:right              # fill in the top row left to right
            spiral_matrix[top, i] = n
            n += 1
        end
        top += 1

        top > bottom && break
        for i ∈ top:bottom              # fill in the right col top to bottom
            spiral_matrix[i, right] = n
            n += 1
        end
        right -= 1

        left > right && break
        for i ∈ right:-1:left           # fill in the bottom row right to left
            spiral_matrix[bottom, i] = n
            n += 1
        end
        bottom -= 1

        top > bottom && break
        for i ∈ bottom:-1:top           # fill in the left row bottom to top
            spiral_matrix[i, left] = n
            n += 1
        end
        left += 1
    end

    return spiral_matrix
end
