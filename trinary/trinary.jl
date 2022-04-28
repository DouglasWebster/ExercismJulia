function trinary_to_decimal(str::String)
    isempty(filter(x -> (x < '0' || x > '2'), str)) || return 0
    i = 0
    result = 0
    for n ∈ reverse(str)
        result += (n - '0') * 3 ^i
        i += 1
    end
    result
end

