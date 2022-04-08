function encode(s)
   code = ""

    for matched in eachmatch(r"(.)\1*", s)
        len = length(matched.match)
        code *= (len > 1 ? "$(len)" : "") * "$(matched[1])"
    end

    return code
end



function decode(s)
    code = ""
    for matches in eachmatch(r"(\d*)(\D)", s)
        len = (matches[1] == "" ? 1 : parse(Int64, matches[1]))
        code *= repeat(matches[2], len)
    end

    return code

end