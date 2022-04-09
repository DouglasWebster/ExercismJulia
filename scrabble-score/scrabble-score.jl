function score(str; double_letters="", triple_letters="", word_multiplier=1)
    function calc_letter_totals(letters)
        total = 0
        for c in uppercase(letters)
            in(c, "AEIOULNRST") && (total += 1)
            in(c, "DG") && (total += 2)
            in(c, "BCMP") && (total += 3)
            in(c, "FHVWY") && (total += 4)
            in(c, "K") && (total += 5)
            in(c, "JX") && (total += 8)
            in(c, "QZ") && (total += 10)
        end
        return total
    end

    score = calc_letter_totals(str)
    score += (calc_letter_totals(double_letters))
    score += (calc_letter_totals(triple_letters) * 2)
    
    return score * word_multiplier

end
