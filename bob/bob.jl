function bob(stimulus)
    stimulus = strip(stimulus)
    length(stimulus) == 0 && return "Fine. Be that way!"
    letters = filter(c -> islowercase(c) || isuppercase(c), stimulus)
    shout = length(letters) > 0 && all(c -> isuppercase(c), letters,)
    stimulus[end] == '?' && shout && return "Calm down, I know what I'm doing!"
    shout && return "Whoa, chill out!"
    stimulus[end] == '?' && return "Sure."
    "Whatever."
end