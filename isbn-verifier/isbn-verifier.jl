import Base: isvalid, string

struct ISBN <: AbstractString
    isbn::String
    
    function ISBN(code::String)
        isvalid(ISBN, code) || throw(DomainError(code))
        new(filter(x -> isdigit(x) || x == 'X', code))
    end
end


function isvalid(ISBN, code)
    d = [(isdigit(c) ? parse(Int, c) : 10) 
            for c in code if isdigit(c) || c == 'X']
    length(d) == 10 || return false
    isempty(findall(x -> x == 10 , d[1:end-1])) || return false
    t = 0
    s = 0
    for x in d
        t += x
        s += t
    end
    s % 11 == 0
end


macro isbn_str(code)
    ISBN(code)
end


string(s::ISBN) = s.isbn
