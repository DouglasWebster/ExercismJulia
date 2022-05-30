function solve(problem)
    problem = replace(problem, " " => "")
    letters = Dict{Char, Vector}()
    lhs = split(split(problem, "==")[1], "+")
    rhs = split(problem, "==")[2]
    length(rhs) == 1 && return nothing
    length(lhs) == 1 && lhs[1] ≠ rhs && return nothing

    # set up the possible values for each letter in the summands
    for summand ∈ lhs
        l = length(summand)
        l > length(rhs) && return nothing # test for leading zero
        first_letter = summand[1]               # it is the first letter so cannot be zero
        if haskey(letters, first_letter)        # encountered before
            letters[first_letter][1] == 0 &&    # but not as first letter so
            popfirst!(letters[first_letter])    # get rid of the zero if it exists
        else
            letters[first_letter] = [1:9...] 
        end

        for l ∈ summand[2:end]
            haskey(letters, l) && continue
            letters[l] = [0:9...]
        end
    end

    # set up the possible values for each letter in the total
    for (x, l)  in enumerate(rhs)
        if haskey(letters, l)
            x == 1 && letters[l][1] == 0 && 
            popfirst!(letters[l])  # get rid of the zero if it exists
        else
            x == 1 ? letters[l] = [1:9...] : letters[l] = [0:9...] 
        end 
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
    
    # find the letter with the shortest length of digits
    digit_count = 11
    letter = ' '
    for (k, v) in letters
        if length(v) < digit_count
            digit_count = length(v)
            letter = k
        end
    end
    
    


    
    return(letters, max_sum, digit_count, letter)

end

function do_sum(test_digits::Dict, lhs::Array, rhs:: String)
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

    return(total, ans)
end

# do_sum(Dict('I' => 1, 'B' => 9, 'L' => 0), ["I", "BB"], "ILL")
solve("SEND + MORE == MONEY")