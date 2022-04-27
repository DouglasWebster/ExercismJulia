function to_roman(number::Int)
    number < 1 && throw(ErrorException("Must be 1 or greater"))

    ms, ds = divrem(number, 1000)
    ds, cs = divrem(ds, 500)
    cs, ls = divrem(cs, 100)
    ls, xs = divrem(ls, 50)
    xs, vs = divrem(xs, 10)
    vs, is = divrem(vs, 5)

    numerals = repeat("M", ms)
    ds == 1 && cs == 4 ?
        (numerals *= "CM"; cs = 0) :
        ds == 1 && (numerals *= "D")
    cs == 4 ?
        numerals *= "CD" :
        numerals *= repeat("C", cs)
    ls == 1 && xs == 4 ?
        (numerals *= "XC"; xs = 0) :
        ls == 1 && (numerals *= "L")
    xs == 4 ?
        numerals *= "XL" :
        numerals *= repeat("X", xs)
    vs == 1 && is == 4 ?
        (numerals *= "IX"; is = 0) :
        vs == 1 && (numerals *= "V")
    is == 4 ?
        numerals *= "IV" :
        numerals *= repeat("I", is)

    return numerals

end


