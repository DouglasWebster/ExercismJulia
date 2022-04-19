
function annotate(grid::AbstractArray)
    ((rows = length(grid)) == 0 || (cols = length(grid[1])) == 0) && return grid
    chargrid = permutedims(reshape(collect(join(grid)), cols, rows))
    dummy = fill(' ', (rows+2, cols +2))
    mines = findall(c -> c=='*', chargrid)

    for mine in mines
        dummy[mine[1], mine[2]] == ' ' ? dummy[mine[1], mine[2]] = '1' : dummy[mine[1], mine[2]] += 1
        dummy[mine[1], mine[2]+1] == ' ' ? dummy[mine[1], mine[2]+1] = '1' : dummy[mine[1], mine[2]+1] += 1
        dummy[mine[1], mine[2]+2] == ' ' ? dummy[mine[1], mine[2]+2] = '1' : dummy[mine[1], mine[2]+2] += 1
        dummy[mine[1]+1, mine[2]] == ' ' ? dummy[mine[1]+1, mine[2]] = '1' : dummy[mine[1]+1, mine[2]] += 1
        dummy[mine[1]+1, mine[2]+2] == ' ' ? dummy[mine[1]+1, mine[2]+2] = '1' : dummy[mine[1]+1, mine[2]+2] += 1
        dummy[mine[1]+2, mine[2]] == ' ' ? dummy[mine[1]+2, mine[2]] = '1' : dummy[mine[1]+2, mine[2]] += 1
        dummy[mine[1]+2, mine[2]+1] == ' ' ? dummy[mine[1]+2, mine[2]+1] = '1' : dummy[mine[1]+2, mine[2]+1] += 1
        dummy[mine[1]+2, mine[2]+2] == ' ' ? dummy[mine[1]+2, mine[2]+2] = '1' : dummy[mine[1]+2, mine[2]+2] += 1
    end
    for mine in mines
        dummy[mine[1]+1, mine[2]+1] = '*'
    end

    required_values = [dummy[i, j] for i in 2:size(dummy, 1)-1, j in 2:size(dummy, 2)-1]
    output = [join(required_values[i, :]) for i in 1:size(required_values,1)]

    return output

end
