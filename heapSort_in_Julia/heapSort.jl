using Statistics
using Printf

include("heapify.jl")

function heapSort(a)
    # @printf("Original length of a is %d\n", length(a))
    a = heapify(a)
    # println("Heapified a = ", a)
    b = Vector{Int}()
    while length(a) >= 1
        push!(a, pop!(a))
        # println("Currently a is ", a)
        prepend!(b, popfirst!(a))
        # println("Currently b is ", b)
        heapify(a)
    end
    return b
end

# a = vec([10 15 7 5 6 17 12])
# println(a)
# b = heapSort(a)
# println(b)
