using Ipopt
using JuMP
using Plots
using Random

function optimize_ddp(T, q, B0, B_min, B_max, iterations)
    model = Model(Ipopt.Optimizer)

    # Generating random values for P_L in the range [2.5, 4.0]
    P_L = [rand(2.5:0.01:4.0) for _=1:T]

    # Decision variables
    @variable(model, B_min <= B[1:T] <= B_max)  # SOC
    @variable(model, P_B[1:T])                  # Power to/from battery

    # Objective function
    @objective(model, Min, sum(q * (P_B[t] + P_L[t])^2 for t=1:T))

    # Constraints
    @constraint(model, B[1] == B0 + P_B[1])
    for t=2:T
        @constraint(model, B[t] == B[t-1] + P_B[t])
    end

    @constraint(model, B[T] == B0)

    # Iterate to improve the solution
    for iter=1:iterations
        optimize!(model)
        
        # Displaying the results for each iteration
        println("Iteration: ", iter)
        println("Objective Value: ", objective_value(model))
    end
    
    return value.(P_B), value.(B)
end

# Parameters
T = 3  # You can adjust this for the desired number of time steps
q = 1
B0 = 5
B_min = 2
B_max = 8
iterations = 3

P_B_values, B_values = optimize_ddp(T, q, B0, B_min, B_max, iterations);

println("Optimal P_B values: ", P_B_values)
println("Optimal B values: ", B_values)
