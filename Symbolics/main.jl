using LinearAlgebra
using Revise
using Symbolics

@variables t x y u(..); # u is a real valued function. x, y, t are real values

M = [t+2t^2 6t; x+2t+2y y^2];

f, f! = build_function(M, [x, y, t])
func_f = eval(f)
result = f(1.0, 2.0, 3.0)

let ef = eval(f), ef! = eval(f!), M = zeros(2, 2), inputs = [1.2, 3.4, 5.6]
        ef!(M, inputs)
        ef(inputs), M
end