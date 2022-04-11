using Unicode

const TEST_GRAPHEMES = true

# now lets make it concises the julia way by collecting the individual
# graphemes, passing them to reverse and then rejoining
# and because it's concise by using the assignment form

myreverse(sentence::String) = graphemes(sentence) |> collect |> reverse |> join

