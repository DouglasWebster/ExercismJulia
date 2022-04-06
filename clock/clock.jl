import Base: +, -, show
import Dates

struct Clock
    hours::Int
    minutes::Int

    function Clock(hours, minutes)
        # get some interim hours and minutes from the minitues 
        (i_hours, minutes) = divrem(minutes, 60)
        if minutes < 0
            minutes += 60
            hours -= 1
        end
        hours += i_hours
        hours = hours % 24
        hours < 0 ? hours += 24 : hours
        new(hours, minutes)
    end

end

function +(clock::Clock, minute::Dates.Minute)
    Clock(clock.hours, clock.minutes + minute.value)
end

function -(clock::Clock, minute::Dates.Minute)
    Clock(clock.hours, clock.minutes - minute.value)
end

function show(io::IO, clock::Clock)
    print(io, "\"$(string(clock.hours, pad = 2)):$(string(clock.minutes, pad = 2))\"")
end