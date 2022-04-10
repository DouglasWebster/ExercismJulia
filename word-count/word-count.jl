#=
Now lets try and do it with one regex expression!
    first get all words => \w+
    now the optional '{character} => ('\w)?
=#

function wordcount(sentence)
    occurances = Dict{String, Int64}()
    for m in eachmatch(r"\w+('\w)?", sentence)
        occurances[lowercase(m.match)] = get(occurances, lowercase(m.match), 0) + 1
    end
    return occurances
    
end

