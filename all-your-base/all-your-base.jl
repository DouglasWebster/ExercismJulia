# Implement number base conversion

function all_your_base(digits, base_in, base_out)
    (base_in < 2 || base_out < 2 ) && 
        throw(DomainError("", "Invalid base conversion from base $base_in to base $base_out."))
    isempty(digits) && return [0]
    max_exp = length(digits) - 1
    max_exp == 0 && (digits[1] == 0 || digits[1] == 1) && (return [digits[1]])
    tot_base_ten = 0
    for x in digits
        (x ≥ base_in || x < 0) && throw(DomainError("$x - Invalid digit for input for an input base of $base_in."))
        tot_base_ten += x * base_in^max_exp
        max_exp -=1
    end
    tot_base_ten == 0 && return [0]
    base_out_digits = []
    while tot_base_ten ≠ 0
        tot_base_ten, r = divrem(tot_base_ten, base_out)
        pushfirst!(base_out_digits, r)
    end
    return base_out_digits 
end

