"""
    count_nucleotides(strand)

The count of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
function count_nucleotides(strand)
    A = count(i -> (i=='A'), strand)
    C = count(i -> (i=='C'), strand)
    G = count(i -> (i=='G'), strand)
    T = count(i -> (i=='T'), strand)
    if sum(A+C+G+T) != length(strand)
        throw(DomainError(0))
    else
        return Dict('A' => A, 'C' => C, 'G' => G, 'T' => T )
    end
end

print(count_nucleotides("GATTACA"))

