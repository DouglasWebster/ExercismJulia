function pythagorean_triplets(n::Int)
    triplets = []
    for x ∈ 1:n÷3+1
        for y ∈ x+1:n÷2+1
            z = n - x - y
            z^2 == (x^2 + y^2) && push!(triplets, (x, y, z))
        end
    end

    return triplets

end
