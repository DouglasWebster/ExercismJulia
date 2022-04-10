function transform(input::AbstractDict)
    output = Dict()
    for (key, letters) in input
        for letter in letters
            output[lowercase(letter)] = key
        end
    end

    return output

end
