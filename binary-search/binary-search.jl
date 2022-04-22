function comp(x,y, rev)
    !rev ? (return x ≤ y) : (return x ≥ y)
end

function binarysearch(pattern, item; by=identity, lt=<, rev=false)

    compare(x,y,rev) = !rev ? (x,y) -> x ≤ y : (x,y) -> x ≥ y

    low = 1
    high = length(pattern)

    while low <= high
        mid::Int = (low + high) ÷ 2
        item == pattern[mid] && return (mid:mid)
        comp(pattern[mid], item, rev) ? low = mid + 1 : high = mid-1

    end

    return(low:high)

end
