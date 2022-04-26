function collatz_steps(n::Int)
    n < 1 && throw(DomainError(collatz_steps))
    steps = 0
    while n != 1
       steps += 1
       iseven(n) ? n ÷= 2 : n = n * 3 + 1
    end 
    return steps
end
