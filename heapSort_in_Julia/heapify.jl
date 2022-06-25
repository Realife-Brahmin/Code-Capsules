# using Printf
# using Statistics
include("swap.jl")

function heapify(a, currentHeapSize)
    n = currentHeapSize
    j = 2
    while j <= n
        i = j
        while i >= 2
            if a[i] > a[i ÷ 2]
                a = swap(a, i, i ÷ 2)
            end
            i = i ÷ 2
        end
        j += 1
    end
    return a
end

# a1 = [10 15 7 5 6 17 12]
# println(a1)
# a2 = heapify(a1)
# # Output should be a2 = [17 10 15 5 6 7 12]
# println(a2)
