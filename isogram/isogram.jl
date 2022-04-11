function isisogram(s)
    alpha_characters = lowercase(replace(s, r"-| " => ""))
    length(Set{Char}([c for c in alpha_characters])) == length(alpha_characters)
end

