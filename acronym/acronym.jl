function acronym(phrase)
    phrase = replace.(uppercase(phrase), r"[_-]" => " ")
    join([x[1] for x in split(phrase)])

end
