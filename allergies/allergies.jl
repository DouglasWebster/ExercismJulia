allergies = Dict(
    "eggs" => 1, 
    "peanuts" => 2,
    "shellfish" => 4,
    "strawberries" => 8,
    "tomatoes" => 16,
    "chocolate" => 32,
    "pollen" => 64,
    "cats" => 128)

function allergic_to(score, allergen)
    (allergies[allergen] & score) != 0  ? (return true) : (return false)
end

# Don't need to work out what allergies goes with a score
# just ask allergic_to if the score and allergy match 
function allergy_list(score)
    Set{String}([key for key in keys(allergies) if allergic_to(score, key)])
end

allergy_list(3)