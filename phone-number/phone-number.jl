function clean(phone_number)
    dgts = reverse(digits(parse(Int, filter(isdigit, phone_number))))
    dgts[1] == 1 && (dgts = dgts[2:end])
    (length(dgts) ≠ 10 || dgts[1] < 2 || dgts[4] < 2) &&
            throw(ArgumentError("$dgts is not valid"))
    return join(string.(dgts))
end