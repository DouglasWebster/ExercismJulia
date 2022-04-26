function sieve(limit)
    s = fill(true, limit)
    s[1] = false
    for n=2:ceil(Int, sqrt(limit))
        if s[n]
            for k = 2n:n:limit
                s[k] = false
            end
        end
    end
    findall(s)
end

