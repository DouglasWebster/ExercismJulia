"""Calculate the number of grains on square `square`."""    
on_square(square) = (square < 1 || square > 64) ? throw(DomainError(square)) : big(2) ^ (square -1)    


"""Calculate the total number of grains after square `square`."""
total_after(square) = (square < 1 || square > 64) ? throw(DomainError(square)) : big(2) ^ square -1

