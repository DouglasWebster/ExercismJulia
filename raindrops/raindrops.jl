"""
raindrops - let's take advantage of the fact that julia stops processing a statement
once it is false! and that if no factor is found then the string is empty!
"""
function raindrops(number)
    output = ""

    number % 3 == 0 && (output *= "Pling")
    number % 5 == 0 && (output *= "Plang")
    number % 7 == 0 && (output *= "Plong")
    
    return output == "" ? string(number) : output

end
