"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
function ispangram(input)
    input = lowercase(input)
    return size(unique([x for x in input if 123 >Int(x) > 96]), 1) == 26 ? true : false
end
