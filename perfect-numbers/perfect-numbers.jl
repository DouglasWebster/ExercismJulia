aliquot_sum(n::Int) = n < 1 && 
                        throw(DomainError("$n is not a positive natural number")) ||
                        sum([x for x in 1:n÷2 if n % x == 0])


isperfect(num::Int)::Bool = aliquot_sum(num) == num
isabundant(num::Int)::Bool = aliquot_sum(num) > num
isdeficient(num::Int)::Bool = aliquot_sum(num) < num
