function triangle(n)
    seed = seed = [[1], [1, 1]]
    n < 0 && throw(DomainError(triangle))
    n == 0 && return []
    n == 1 && return [[1]]
    n == 2 && return seed
    for i in 3:n
            next_row = [1]
        for j in 2:(i -1)
            push!(next_row, seed[i-1][j-1]+ seed[i-1][j])
        end
        push!(next_row, 1)
        push!(seed, next_row)
    end

    return seed

end

function rec_triangle(n::Int)
    n<0 && throw(DomainError("Negative row"))
    n==0 && return []
    n==1 && return [[1]]
    t=triangle(n-1)
    push!(t, [t[end];0]+[0;t[end]])
end

using BenchmarkTools

@time triangle(200)
@time rec_triangle(200)