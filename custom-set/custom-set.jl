import Base: isempty, length, iterate, push!
struct CustomSet{T} <: AbstractSet{T}
    atoms::Vector{T}

    CustomSet(obj::AbstractVector{T}) where T = new{T}(sort!(unique(obj)))
    
end

isempty(s::CustomSet) = length(s.atoms) == 0 ? true : false
length(s::CustomSet) = length(s.atoms)
iterate(s::CustomSet) = iterate(s.atoms)
iterate(s::CustomSet, x) = iterate(s.atoms,x)
disjoint(a::CustomSet, b::CustomSet) = length([x for x in a.atoms if x ∈ b.atoms]) == 0 ? true : false 
intersect!(a::CustomSet, b::CustomSet) = filter!(x -> x ∈ b.atoms, a.atoms)
intersect(a::CustomSet, b::CustomSet) = CustomSet([x for x in a.atoms if x ∈ b.atoms])
complement(a::CustomSet, b::CustomSet) = CustomSet([x for x in a.atoms if x ∉ b.atoms])
complement!(a::CustomSet, b::CustomSet) = filter!(x -> x ∉ b.atoms, a.atoms)
copy(s::CustomSet) = CustomSet(s.atoms)

function push!(s::CustomSet, i)
    in(i, s) && return s
    return push!(s.atoms, i)
end

