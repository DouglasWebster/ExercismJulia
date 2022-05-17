"""
    matching_brackets(s)
    
Given a string `s` containing brackets `[]`, braces `{}`, parentheses `()`, 
or any combination thereof, return `true` ifany and all pairs are matched 
and nested correctly else `false`.
"""
function matching_brackets(s::String) :: Bool
    buffer = []
    for c ∈ s
        c == '[' && push!(buffer, ']')
        c == '{' && push!(buffer, '}')
        c == '(' && push!(buffer, ')')
        (c == ']' || c == '}' || c == ')') && 
        (isempty(buffer) || c ≠ pop!(buffer)) && return false
    end
    return isempty(buffer)
end

matching_brackets("{[]}")
