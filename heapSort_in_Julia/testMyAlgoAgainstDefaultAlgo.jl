using Printf
using BenchmarkTools

include("heapSort.jl")

N = 1000
data1 = vec(rand(1:N, N, 1))

println("Testing for my implementation of Heap Sort\n")
@btime heapSort(data) setup=(data=data1)
println("Testing against Julia's native Insertion Sort\n")
@btime sort(data, alg=InsertionSort) setup=(data=data1)
println("Testing against Julia's native sort
(Quick Sort for Numeric Arrays, Merge Sort for others)\n")
@btime sort(data) setup=(data=data1)
