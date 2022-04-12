function detect_anagrams(subject, candidates)
    s = sort(collect(lowercase(subject)))
    [c for c in candidates if (lowercase(c) != lowercase(subject))
        && (sort(collect(lowercase(c))) == s) ]
end
