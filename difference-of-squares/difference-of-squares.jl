"""
Square the sum of the first `n` positive integers

The sum of the first n positive integers is given by ``n * (n + 1)/2``
which, when squared give ``(n^4 + 2n^3 n^2)/4``
"""
function square_of_sum(n::Int)
    return Int((n^4 + 2*n^3 + n^2)/4)
end

"""
Sum the squares of the first `n` positive integers

See [Square pyramidal number](https://en.wikipedia.org/wiki/Square_pyramidal_number)
"""
function sum_of_squares(n::Int)
    return Int((n * (n +1) * (2 * n + 1)) / 6 )
end

"Subtract the sum of squares from square of the sum of the first `n` positive ints"
function difference(n::Int)
    return Int(square_of_sum(n) - sum_of_squares(n))
end
