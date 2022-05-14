function fermat_factors(n::Integer)
    n ≤ 0 && return n
    iseven(n) && return(n ÷ 2, 2)

    a::Int = ceil(sqrt(n))
    a^2 == n && return(a, a)

    b1::Int = 0
    b::Int = 0
    while(true)
        b1 = a^2 - n
        b = isqrt(b1) 
        if b^2 == b1
            break
        else 
            a += 1
        end
    end

    return[a-b, a+b]
    
end

function prime_factors(n::Int, p_factors = [])

    factors = fermat_factors(n)
    while 1 ∉ factors
        prime_factors(factors[1], p_factors)
        prime_factors(factors[2], p_factors)
        factors = (1,1)
    end
    factors[2] ≠ 1 && push!(p_factors, factors[2])
    
    return sort(p_factors)
end

println(prime_factors(901255))
