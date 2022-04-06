"Lets tighten things down using array comprehension"
function rotate(r, input::String)
    
    return String([rotate(r, i) for i in input])
end

"This one was wordy too so it gets compressed as well."
function rotate(r, input::Char)
    if !(isletter(input))
         return input
    end
 
    c = lowercase(input)

    c = (c + r - 'a') % 26 + 'a'  
   
    isuppercase(input) ? (return uppercase(c)) : (return c)
end

macro R13_str(s) 
    return rotate(13, s)
end

for i in 0:26
    @eval begin
        macro $(Symbol('R', i, "_str"))(input)
            return rotate($i, input)
        end
    end
end
