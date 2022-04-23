function encode(input)
    stripped_input = filter(c -> (isletter(c) || isdigit(c)), lowercase(input))
    output = ""
    
    for n in 1:length(stripped_input)
        x = stripped_input[n]
        isletter(x) ? y = 'm' - x + 'n' : y = x
        n % 5 == 0 ? output *= (y * ' ') : output *= y
    end

    return strip(output)

end

function decode(input)
    filter(c -> !isspace(c), encode(input))    
end