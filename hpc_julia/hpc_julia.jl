include("lap2d!.jl")
M = 4096
N = 4096
u = zeros(M, N)
# set boundary conditions
u[1,:] = u[end,:] = u[:,1] = u[:,end] .= 10.0
unew = copy(u);

for i in 1:50_000
    lap2d!(u, unew)
    # copy new computed field to old array
    u = copy(unew)
end

using Plots
heatmap(u)
