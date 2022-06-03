include("permutations.jl")
#using InlineStrings


function solve(str::AbstractString)
    # str == "NO + NO + TOO == LATE" && return Dict(
    #     'N' => 7,
    #     'O' => 4,
    #     'T' => 9,
    #     'L' => 1,
    #     'A' => 0,
    #     'E' => 2
    # )
    # str == "HE + SEES + THE == LIGHT" && return Dict(
    #     'E' => 4,
    #     'G' => 2,
    #     'H' => 5,
    #     'I' => 0,
    #     'L' => 1,
    #     'S' => 9,
    #     'T' => 7
    # )
    # str == "SEND + MORE == MONEY" && return Dict(
    #     'S' => 9,
    #     'E' => 5,
    #     'N' => 6,
    #     'D' => 7,
    #     'M' => 1,
    #     'O' => 0,
    #     'R' => 8,
    #     'Y' => 2
    # )

    # str == "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE" && return Dict(
    #     'A' => 5,
    #     'D' => 3,
    #     'E' => 4,
    #     'F' => 7,
    #     'G' => 8,
    #     'N' => 0,
    #     'O' => 2,
    #     'R' => 1,
    #     'S' => 6,
    #     'T' => 9
    # )

    # str == ("THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES") && return Dict(
    #      'A' => 1,
    #     'E' => 0,
    #     'F' => 5,
    #     'H' => 8,
    #     'I' => 7,
    #     'L' => 2,
    #     'O' => 6,
    #     'R' => 3,
    #     'S' => 4,
    #     'T' => 9
    # )




    
    words = collect((match.match for match in eachmatch(r"(\w+)", str)))
    # collected_words = collect(words)
    initials = Set(word[begin] for word in words)

    chars = unique(string(words...))
    perms = permutations(0:9, length(chars))
    
    mappings = Dict{Char, Int}()
    for perm in perms
        valid = true
        for (c, i) in zip(chars, perm)
            in(c, initials) && i==0 && (valid = false; break)
            mappings[c] = i
        end
        
        !valid && continue
        # numstrings = replace.(words, mappings...)
        # condition = join(numstrings, "+", "==")

        # # condition = replace(str, mappings...)
        # eval(Meta.parse(condition)) && return mappings

        test_sum(mappings, collect(words)) && return mappings
    end
    return nothing
end

function test_sum(test_dict::Dict, numstrings::Array)
    total = 0
    for summand ∈ numstrings[begin:end-1]
        indices = length(summand) - 1
        for l in summand
            total += test_dict[l] * 10^indices
            indices -= 1
        end
    end

    ans = 0
    indices = length(numstrings[end]) - 1
    for l ∈ numstrings[end]
        ans += test_dict[l] * 10^indices
        indices -= 1
    end

    total == ans
end

# using  BenchmarkTools

# @benchmark 
solve("THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES")