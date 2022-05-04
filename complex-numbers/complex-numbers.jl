import Base: real, imag, convert, promote_rule, *, +, -, /, abs, conj, exp

struct ComplexNumber{T<:Real} <: Number
    re::T
    im::T
end

ComplexNumber(re::Real, im::Real) = ComplexNumber(promote(re, im)...)
ComplexNumber(re::Real) = ComplexNumber(re, zero(re))

convert(::Type{ComplexNumber{T}}, x::Real) where {T <: Real} = ComplexNumber{T}(x, 0)
convert(::Type{ComplexNumber{T}}, z::ComplexNumber) where {T <: Real} = 
    ComplexNumber{T}(real(z), imag(z))

promote_rule(::Type{ComplexNumber{T}}, ::Type{ComplexNumber{S}}) where 
    {T<:Real, S<:Real} = ComplexNumber{promote_type(T,S)}
promote_rule(::Type{ComplexNumber{T}}, ::Type{S}) where 
    {T<:Real, S<:Real} = ComplexNumber{promote_type(T, S)}

*(a::ComplexNumber, b::ComplexNumber) = 
    ComplexNumber(a.re * b.re - a.im * b.im, a.im * b.re + b.im * a.re)
+(a::ComplexNumber, b::ComplexNumber) = 
    ComplexNumber(a.re + b.re, a.im + b.im)
-(a::ComplexNumber, b::ComplexNumber) = 
    ComplexNumber(a.re - b.re, a.im - b.im)
/(a::ComplexNumber, b::ComplexNumber) =  
    ComplexNumber((a.re * b.re + a.im * b.im)/(b.re^2 + b.im^2),
                  (a.im * b.re - a.re * b.im)/(b.re^2 + b.im^2))

abs(z::ComplexNumber) = hypot(z.re, z.im)
conj(z::ComplexNumber) = ComplexNumber(z.re, -z.im)

real(z::ComplexNumber) = z.re
imag(z::ComplexNumber) = z.im

exp(z::ComplexNumber) = ComplexNumber(exp(z.re) * cos(z.im), exp(z.re) * sin(z.im))

const jm = ComplexNumber(0, 1)