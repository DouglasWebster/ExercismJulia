function secret_handshake(code)
    output = []
    words = ["wink", "double blink", "close your eyes", "jump"]
    for x in 0:3
        (code >> x) & 1 == 1 && push!(output, words[x+1])
    end

   (code >> 4) & 1 == 1 ? reverse(output) : output
end

