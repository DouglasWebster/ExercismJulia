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
    tail::Int       # The oldest (first?) element added
    count::Int      # The current number of elements in the buffer

    function CircularBuffer{T}(capacity::Integer) where {T}
        new(Vector{T}(undef, capacity), capacity, 1, 0)
    end
end


"""
convert an arbitrary index into the actual buffer index
""" 
@inline function _buffer_idx(cb::CircularBuffer, i::Int)
    c = cb.capacity
    idx = cb.tail + i - 1 
    idx > c && (idx -= c)
    return idx
end


"""
    push!(cb::CircularBuffer, item; overwrite=false)

Add an element to the back of the queue.

overwrite determines the action on attempting to add an element to a full queue
- overwrite == false:   Raise an BoundsError exception.
- overwrite == true:    overwrite the element at the front of the queue.
"""
function Base.push!(cb::CircularBuffer{T}, item; overwrite::Bool=false) where T
    cb.count == cb.capacity && !overwrite && throw(BoundsError(cb, cb.capacity +1))
    
    item = convert(T, item)
    
    if cb.count == cb.capacity
        cb.tail = (cb.tail == cb.capacity ? 1 : cb.tail + 1)
    else
        cb.count += 1
    end
    cb.buffer[_buffer_idx(cb,  cb.count)] = item
    return cb
end


"""
    popfirst!(cb::CircularBuffer)

Remove the first item in the buffer and return item
"""
function Base.popfirst!(cb::CircularBuffer)
    cb.count == 0 && throw(BoundsError(cb, 0))
    n = cb.tail
    cb.tail = (cb.tail + 1 > cb.capacity ? 1 : cb.tail +1)
    cb.count -= 1
    
    return cb.buffer[n] 
end


"""
    pop!(cb::CircularBuffer)

Remove the last item from the buffer and return item
"""
function Base.pop!(cb::CircularBuffer)
    cb.count == 0 && throw(BoundsError(cb, 0))
    n = cb.count
    cb.count -= 1
    
    return cb.buffer[_buffer_idx(cb, n)]   
end


"""
    pushfirst!(cb::CircularBuffer, item; overwrite=false)

Add an element to the front of the queue.

overwrite determines the action on attempting to add an element to a full queue
- overwrite == false:   Raise an BoundsError exception.
- overwrite == true:    overwrite the element at the back of the queue.
"""
function Base.pushfirst!(cb::CircularBuffer{T}, item::Int; overwrite::Bool=false) where T
    cb.count == cb.capacity && !overwrite && throw(BoundsError(cb, cb.capacity +1))
    item = convert(T, item)
    cb.tail = (cb.tail - 1 == 0 ? cb.capacity : cb.tail - 1)
    cb.count ≠ cb.capacity && (cb.count += 1)

    cb.buffer[_buffer_idx(cb, 1)] = item
    return cb   
end


"""
    empty!(cb::CircurlaBuffer)

Reset the state of the buffer to empty.
"""
function Base.empty!(cb::CircularBuffer)
    cb.count =0
    return cb
end


capacity(cb::CircularBuffer) = cb.capacity
isfull(cb::CircularBuffer) = cb.capacity == cb.count

Base.size(cb::CircularBuffer) = (cb.count,)
Base.length(cb::CircularBuffer) = cb.count
Base.first(cb::CircularBuffer) = cb.count == 0 ? throw(BoundsError(cb)) : cb.buffer[cb.tail]
Base.last(cb::CircularBuffer) = cb.count == 0 ? throw(BoundsError(cb)) :
            cb.buffer[_buffer_idx(cb, cb.count)]


"""
    append!(cb::CircularBuffer, items::Vector; overwrite=false)

Add the vector to the end of the buffer.  Attempting to add a vector of length
greater than the remaining capacity with `overwrite==false` will raise and error.
If `overwrite==true` then the items are all added with excess elements overwriting 
earlier items.
"""
function Base.append!(cb::CircularBuffer, items; overwrite::Bool=false)
    (cb.count + length(items)) > cb.capacity && overwrite == false && throw(BoundsError(cb, items))
    for i in items
        push!(cb, i; overwrite)
    end
end


Base.convert(::Type{Array}, cb::CircularBuffer{T}) where {T} = T[x for x in cb]


"""
    cb[i]

Get the i-th element of the CircularBuffer
"""
function Base.getindex(cb::CircularBuffer, i::Int)
    i > cb.capacity && throw(BoundsError(cb, i))
    cb.buffer[_buffer_idx(cb, i)]
end


"""
    setindex!(collection, value, index)

Store the given value at the given index within a within the buffer.
"""
function Base.setindex!(cb::CircularBuffer, item, i::Int)
    i > cb.capacity && throw(BoundsError(cb, i))
    cb.buffer[_buffer_idx(cb, i)] = item
    return cb
end
