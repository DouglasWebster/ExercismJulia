mutable struct CircularBuffer{T}  <: AbstractArray{T, 1}
    buffer::Array{T}
    capacity::Int
    head::Int
    tail::Int
    count::Int

    function CircularBuffer{T}(capacity::Integer) where {T}
        new(Vector{T}(undef, capacity), capacity, 0, 0, 0)
    end
end

function items(cb::CircularBuffer) 
    buffer::Array{Type(cb.buffer{Type})}
    x = cb.tail
    for i in 1:cb.countcount
        pushfirst!(buffer, cb.buffer[x])
        x -= 1
        x== 0 && (x = cb.count)
    end
    return buffer
end


function Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)
    cb.count == cb.capacity && !overwrite && throw(BoundsError(cb, cb.capacity +1))
    if cb.count == cb.capacity
        cb.head = cb.tail-1
        cb.tail = (cb.tail += 1) % cb.capacity
        cb.count -= 1
    end
    cb.buffer[cb.head+1] = item
    cb.head = (cb.head += 1) % cb.capacity
    cb.count += 1
    cb.count == 1 && (cb.tail = cb.head)
    return cb
end


function Base.popfirst!(cb::CircularBuffer)
    cb.count == 0 && throw(BoundsError(cb, 0))
    item = cb.buffer[cb.tail+1]
    cb.tail = (cb.tail += 1) % cb.capacity
    cb.count -= 1
    cb.count == 0 && empty!(cb)
    return item 
end


function Base.empty!(cb::CircularBuffer)
    cb.head = 0
    cb.tail = 0
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