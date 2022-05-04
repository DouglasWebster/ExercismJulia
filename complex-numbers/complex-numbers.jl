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

    #=
Now that we have implemented real and imag lets make sure that
the following are type safe
=#
*(a::ComplexNumber, b::ComplexNumber) = 
    ComplexNumber(real(a) * real(b) - imag(a) * imag(b), imag(a) * real(b) + imag(b) * real(a))
+(a::ComplexNumber, b::ComplexNumber) = 
    ComplexNumber(real(a) + real(b), imag(a) + imag(b))
-(a::ComplexNumber, b::ComplexNumber) = 
    ComplexNumber(real(a) - real(b), imag(a) - imag(b))
/(a::ComplexNumber, b::ComplexNumber) =  
    ComplexNumber((real(a) * real(b) + imag(a) * imag(b))/(real(b)^2 + imag(b)^2),
                  (imag(a) * real(b) - real(a) * imag(b))/(real(b)^2 + imag(b)^2))

real(z::ComplexNumber) = z.re
imag(z::ComplexNumber) = z.im

exp(z::ComplexNumber) = ComplexNumber(exp(real(z)) * cos(imag(z)), exp(real(z)) * sin(imag(z)))

abs(z::ComplexNumber) = hypot(real(z), imag(z))
conj(z::ComplexNumber) = ComplexNumber(real(z), -imag(z))

const jm = ComplexNumber(0, 1)