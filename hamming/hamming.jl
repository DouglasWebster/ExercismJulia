"""
Given: Two DNA strings ```s``` and `t` of equal length (not exceeding 1 kbp).

Return: The Hamming distance ```dH(s,t)```
"""
function distance(a, b)
    msg = "Sequence lengths must be equal"
    length(a) != length(b)  && throw(ArgumentError(msg))

    map(!=, a, b) |> count
end

