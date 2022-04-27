function luhn(item::String)::Bool
    length(filter(c -> !isdigit(c) && !isspace(c), item)) > 0 && return false
    sequence = reverse([(c -'0') for c in item if isdigit(c)])
    k = length(sequence)
    k < 2 && return false
    for x ∈ 2:2:k
        i = sequence[x] * 2
        i > 9 && (i -= 9)
        sequence[x] = i
    end

    (sum(sequence) % 10) == 0 ? (return true) : (return false)
end
