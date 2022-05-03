import Base: +, -, *, /, ^, abs, numerator, denominator, ==, <, >, <=, >=, show
struct RationalNumber{T <: Int} <: Real
    num::T
    den::T

    function RationalNumber(n::Int, d::Int = 1)
        d == 0 && n == 0 &&
            throw( ArgumentError("Denominator and Numerator cannot both be zero"))
       d < 0 && (n *= -1; d *= -1)
        a = gcd(n, d)
        new{Int}(n/a, d/a)
    end
end

RationalNumber{Int}(num::Int) = RationalNumber(num, 1)
zero(::Type{RationalNumber{Int}}) = RationalNumber(0, 1)
one(::Type{RationalNumber{Int}}) = RationalNumber(1,1)

+(a::RationalNumber, b::RationalNumber) = 
                RationalNumber(a.num * b.den + b.num * a.den, a.den * b.den)
-(a::RationalNumber, b::RationalNumber) =
                RationalNumber(a.num * b.den - b.num * a.den, a.den * b.den)
*(a::RationalNumber, b::RationalNumber) =
                RationalNumber(a.num * b.num, a.den * b.den)
/(a::RationalNumber, b::RationalNumber) = 
                RationalNumber(a.num * b.den, a.den * b.num)
^(a::RationalNumber, e::Int) = e ≥ 0 ?
                RationalNumber(a.num ^ e, a.den ^ e) :
                RationalNumber(a.den ^ e, a.num ^ abs(e))
^(a::Real, e::RationalNumber) = a^(e.num/e.den)
==(a::RationalNumber, b::Int) = a == RationalNumber(b, 1)
==(a::RationalNumber, b::Rational) = a.num == b.num && a.den == b.den
<(a::RationalNumber, b::RationalNumber) = a.num/a.den < b.num/b.den
<(a::RationalNumber, b::Int) = (a.num / a.den) < b
>(a::RationalNumber, b::RationalNumber) = (a.num/a.den) > (b.num/b.den)
>(a::RationalNumber, b::Int) = (a.num / a.den) > b
<=(a::RationalNumber, b::RationalNumber) = a==b || a < b
<=(a::RationalNumber, b::Int) = a == b || a < b
>=(a::RationalNumber, b::RationalNumber) = a==b || a > b
>=(a::RationalNumber, b::Int) = a == b || a > b

abs(a::RationalNumber) = RationalNumber(abs(a.num), a.den)
numerator(a::RationalNumber) = a.num
denominator(a::RationalNumber) = a.den

show(io::IO, r::RationalNumber) = print(io, r.num, "//", r.den)
