values = Dict(
    "black" => "0",
    "brown" => "1",
    "red" => "2",
    "orange" => "3",
    "yellow" => "4",
    "green" => "5",
    "blue" => "6",
    "violet" => "7",
    "grey" => "8",
    "white" => "9"
)

suffix = Dict(
    "black" => " ohms",
    "brown" => "0 ohms",
    "red" => "00 ohms",
    "orange" => " kiloohms",
    "yellow" => "0 kiloohms"
)


label(colors) = colors[2] == "black"  && colors[3] == "red"  ?
        value = values[colors[1]] * suffix["orange"] :
        value = values[colors[1]] * values[colors[2]] * suffix[colors[3]]

