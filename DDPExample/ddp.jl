using Random

function compute_cost(P_B, P_L, q)
    return sum(q * (P_B[t] + P_L[t])^2 for t in 1:length(P_B))
end

function compute_gradient(P_B, P_L, q, B, B_min, B_max)
    grad = zeros(length(P_B))
    
    for t in 1:length(P_B)
        if t == 1
            prev_B = 5.0
        else
            prev_B = B[t-1]
        end
        
        # Constraint penalty for SOC
        penalty = 0.0
        if B[t] < B_min
            # penalty = -2.0 * (B[t] - B_min)
            B[t] = B_min
            grad[t] = 0.0
        elseif B[t] > B_max
            # penalty = 2.0 * (B[t] - B_max)
            B[t] = B_max
            grad[t] = 0.0
        else
            grad[t] = 2q * (P_B[t] + P_L[t])
        end
        
        # grad[t] = 2q * (P_B[t] + P_L[t]) + penalty
    end
    
    return grad
end

# Parameters
T = 10
q = 1
B0 = 5
B_min = 2
B_max = 8
iterations = 20
learning_rate = 0.01

P_L = [rand(2.5:0.01:4.0) for _=1:T]
P_B = zeros(T)
B = [B0 + P_B[1]]

for t=2:T
    push!(B, B[end] + P_B[t])
end

# Gradient Descent Loop
for iter=1:iterations
    grad = compute_gradient(P_B, P_L, q, B, B_min, B_max)
    
    for t=1:T
        P_B[t] -= learning_rate * grad[t]
    end
    
    # Recompute SOC
    B[1] = B0 + P_B[1]
    for t=2:T
        B[t] = B[t-1] + P_B[t]
    end
    
    println("Iteration: ", iter, " Cost: ", compute_cost(P_B, P_L, q))
end

println("Final P_B values: ", P_B)
println("Final B values: ", B)
