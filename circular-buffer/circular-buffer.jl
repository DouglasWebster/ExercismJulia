"""
    CircularBuffer{T}(n::Int)

The circular buffer implements a buffer of fixed capacity (n) where the newest
item is pushed at the back and items are removed oldest first.  It is in effect a 
First In First Out (FIFO) queue.

Allocate a buffer of undetermined elements of type `T` with a maximum capacity of `n`.

"""
mutable struct CircularBuffer{T}  <: AbstractVector{T}
    buffer::Vector{T}
    capacity::Int   # The size of the buffer
    tail::Int       # The oldest elemetn added
    count::Int      # The current number of elements in the buffer

    function CircularBuffer{T}(capacity::Integer) where {T}
        return new{T}(undef, capacity, 0, 0)
    end
end



# function items(cb::CircularBuffer) 
#     buffer::Array{Type(cb.buffer{Type})}
#     x = cb.tail
#     for i in 1:cb.countcount
#         pushfirst!(buffer, cb.buffer[x])
#         x -= 1
#         x== 0 && (x = cb.count)
#     end
#     return buffer
# end

"""
    push!(cb::CircularBuffer, item; overwrite=false)

Add an element to the back of the queue.

overwrite determines the action on attempting to add an element to a full queue
- overwrite == false:   Raise an BoundsError exception.
- overwrite == true:    overwrite the element at the front of the queue.
"""
function Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)
    cb.count == cb.capacity && !overwrite && throw(BoundsError(cb, cb.capacity +1))
    
    # converted_data = convert(T, item)
    
    if cb.count == cb.capacity
        cb.tail = (cb.tail == cb.capacity ? 1 : cb.tail + 1)
    else
        cb.tail += 1
    end
    cb.buffer[cb.tail] = converted_data
    return cb
end


function Base.popfirst!(cb::CircularBuffer)
    cb.count == 0 && throw(BoundsError(cb, 0))
    n = cb.tail
    cb.tail = (cb.tail + 1 > cb.capacity ? 1 : cb.tail +1)
    cb.count -= 1
    
    return cb.buffer[n] 
end


function Base.empty!(cb::CircularBuffer)
    cb.count =0
    return cb
end

capacity(cb::CircularBuffer) = cb.capacity
isfull(cb::CircularBuffer) = cb.capacity == cb.count

Base.size(cb::CircularBuffer) = (cb.count,)
Base.length(cb::CircularBuffer) = cb.count
Base.first(cb::CircularBuffer) = cb.count == 0 ? throw(BoundsError(cb)) : cb.buffer[cb.tail]
Base.last(cb::CircularBuffer) = cb.count == 0 ? throw(BoundsError(cb)) : cb.buffer[cb.head]
function Base.append!(cb::CircularBuffer, items; overwrite::Bool=false)
    for i in items
        push!(cb, i; overwrite)
    end
end

#=
cb = CircularBuffer{Int}(5)
push!(cb, 1)
append!(cb, 2:8; overwrite=true)



using Test

@testset "is subtype of AbstractVector" begin
    @test CircularBuffer <: AbstractVector
end

# Copied from DataStructures.jl and slightly modified.
@testset "Bonus test set taken from DataStructures.jl (CircularBuffer)" begin
    @testset "Core Functionality" begin
        cb = CircularBuffer{Int}(5)
        @testset "When empty" begin
            @test length(cb) == 0
            @test capacity(cb) == 5
            @test_throws BoundsError first(cb)
            @test_throws BoundsError last(cb)
            @test isempty(cb) == true
            @test isfull(cb) == false
            @test eltype(cb) == Int
            @test eltype(typeof(cb)) == Int
        end

        @testset "With 1 element" begin
            push!(cb, 1)
            @test length(cb) == 1
            @test capacity(cb) == 5
            @test isfull(cb) == false
            @test first(cb) == last(cb)
        end

        @testset "Appending many elements" begin
            append!(cb, 2:8; overwrite=true)
            @test length(cb) == capacity(cb)
            @test size(cb) == (length(cb),)
            @test isempty(cb) == false
            @test isfull(cb) == true
            @test convert(Array, cb) == Int[4,5,6,7,8]
        end
    end
end
=#