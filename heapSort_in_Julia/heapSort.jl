using Statistics
using Printf

include("heapify.jl")
include("swap.jl")

function heapSort(a)
    # @printf("Original length of a is %d\n", length(a))
    n = length(a)
    a = heapify(a, n)
    # println("Heapified a = ", a)
    poppedElements = 0
    while poppedElements < n
        currentHeapSize = n - poppedElements
        swap(a, 1, currentHeapSize)
        poppedElements+=1
        #Extract the topmost element of the heap and put it just after the
        #last element of the current heap.
        #This element is now the at the correct sorted position in the array.
        #It will count as a 'popped element' i.e. no longer part of the heap
        a = heapify(a, currentHeapSize-1)
    end
    return a
end

# a = vec([10 15 7 5 6 17 12])
# N = 1000
# a = vec(rand(1:N, 1, N))
# println(a)
# b = heapSort(a)
# println(b)
