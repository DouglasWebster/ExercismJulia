function annotate(grid::AbstractArray)
    ((rows = length(grid)) == 0 || (cols = length(grid[1])) == 0) && return grid
    chargrid = [collect(grid[r]) for r in 1:rows]
    output = zeros(Int, rows, cols)

    for r in 1:rows
        for c in 1:cols
            r-1 > 0 && c-1 > 0 
        end
    end

    return output
end

minefield = ["   ",
" * ",
"   "]
annotate(minefield)