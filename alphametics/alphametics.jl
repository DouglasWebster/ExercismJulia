include("permutations.jl")

function solve(problem)
    problem = replace(problem, " " => "") 
    letters = Dict{Char, Vector}()
    lhs = split(split(problem, "==")[1], "+")
    rhs = split(problem, "==")[2]
    (length(rhs) == 1 || length(lhs) == 1) && return nothing # indeterminate answer!

    # set the possible values for each letter in the summands as 0 - 9
    for summand ∈ lhs
        l = length(summand)
        l > length(rhs) && return nothing       # test for leading zero
        for l ∈ summand    
            haskey(letters, l) && continue
            letters[l] = [0:9...]
        end
    end
    
    # set up the possible values for each letter in the total as 0 - 9
    for l ∈ rhs
        letters[l] = [0:9...]
    end
    
    # get rid of 0 as a possible digit for all initial letters
    initials = Set(summand[begin] for summand in lhs)
    push!(initials, rhs[begin])
    for i ∈ initials
        popfirst!(letters[i])
    end
    
    # if possible get rid of the impossible digits for the first letter of the total 
    max_sum = 0
    for summand in lhs
        l = length(summand)
        max_sum += (10^l -1)
    end

    if length(rhs) == ndigits(max_sum)
        rhs_fist_digit = [1:digits(max_sum)[end]...]
        rhs_first_char = rhs[1]
        empty!(letters[rhs_first_char])
        for x in rhs_fist_digit
            push!(letters[rhs_first_char], x)
        end

    end
    
    # now comes the brute force attack!
    
    # set up the combination of digits
    test_letters = unique([c for c ∈ problem if isletter(c)])
    combos = permutations(0:9, length(test_letters))
    
    test_dict = Dict{Char, Int}()
    for combo in combos
        valid = true
        for (i, num) ∈ enumerate(combo)
            if num in letters[test_letters[i]] # test if it is a valid digit for the letter
                test_dict[test_letters[i]] = num
            else
                valid = false
                break
            end
        end

        valid && do_sum(test_dict, lhs, rhs) && (return test_dict)
    
    end

    return nothing
end



function do_sum(test_digits::Dict, lhs::Array, rhs)
    total = 0
    for summand ∈ lhs
        indices = length(summand) -1
        for l in summand
            total += test_digits[l] * 10^indices
            indices -= 1
        end
    end

    ans = 0
    indices = length(rhs) -1
    for l ∈ rhs 
        ans += test_digits[l] * 10^indices
        indices -= 1
    end

    total == ans
end
