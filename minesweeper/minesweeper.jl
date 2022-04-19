
function annotate(grid)
    ((rows = length(grid)) == 0 || (cols = length(first(grid))) == 0) && return grid

    mines = findall([grid[x][y] == '*' for x in 1:rows, y in 1:cols])
    
    # create a dummy matrix with a border to accept out of range items
    dummy = fill(' ', (rows+2, cols +2))
 
    for mine in mines
        for x in 0:2
            for y in 0:2
                if x != 1 || y != 1
                    dummy[mine[1]+x, mine[2]+y] == ' ' ?
                        dummy[mine[1]+x, mine[2]+y] = '1' : 
                        dummy[mine[1]+x, mine[2]+y] += 1
                end
            end
        end
    end

    # replace the mines in the dummy matrix
    for mine in mines 
        dummy[mine[1]+1, mine[2]+1] = '*'
    end

    # now all we need is the center of the dummy with each row joined into a string
    map(join, eachrow([dummy[i, j] for i in 2:size(dummy, 1)-1, j in 2:size(dummy, 2)-1]))

end
