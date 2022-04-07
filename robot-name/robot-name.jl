using Random

const allocated_names = Set{String}()

function allocate_name()
    nm = randstring('A':'Z', 2)
    nm *= randstring('0':'9', 3)
    while in(nm, allocated_names)
        nm = randstring('A':'Z', 2)
        nm *= randstring('0':'9', 3)
    end
    push!(allocated_names, nm)
    return nm
end
mutable struct Robot
    name::String

    function Robot() 
        robot = new()
        robot.name = ""
        robot
    end

end

function reset!(instance::Robot)
    instance.name = ""
end

function name(instance::Robot)

    if instance.name == ""
        instance.name = allocate_name()
    end

    return instance.name
end

r1 = Robot()
name(r1)

