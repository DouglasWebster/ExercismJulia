function score(x, y)
    # don't calculate the radius yourself use hypot it's safer.
    r = hypot(x, y)

    # take advantage of short circuit operators
    r > 10 && return 0
    r > 5 && return 1
    r > 1 && return 5
    return 10
end
