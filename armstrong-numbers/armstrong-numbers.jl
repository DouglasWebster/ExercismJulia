function isarmstrong(arm_no::Int)::Bool
    dgts = digits(arm_no) # forgot about digits in previous iteration. :(
    power = length(dgts)
    
    # leaving in a long form as it is faster than broadcasting with
    # something like sum(dgts.^power) == arm_no
    # for the armstrong number 1741725 it takes approx 2/3rd the time.
    total = 0
    for dgt in dgts
        total += dgt^power
    end  
    return total == arm_no
end


