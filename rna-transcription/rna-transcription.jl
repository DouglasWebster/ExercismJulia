"""
Given: DNA strand

Return: It's RNA compliment

The RNA compliment is given by

G -> C, C -> G, T -> A, A -> U

"""
function to_rna(dna)
    complement = Dict('G'=>'C', 'C'=>'G', 'T'=>'A', 'A'=>'U')
    rna = ""
    try
        [rna *= complement[x] for x in dna]
    catch
        throw(ErrorException("Invalid nucleotide"))
    end
    return rna
end
