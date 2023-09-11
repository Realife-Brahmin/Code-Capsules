using BenchmarkTools
using LinearAlgebra
using Revise
using Symbolics

@variables t x y;

M = [t+2t^2 6t; x+2t+2y y^2];

f, f! = build_function(M, [x, y, t], expression=Val{false);
# putting that third argument helped me bypass an error
# I don't truly understand what that does

@btime answer = let
        ef = eval(f)
        ef! = eval(f!)
        M = zeros(2, 2)
        inputs = [1.2, 3.4, 5.6]
        A = Float64[5 6; 7 8]
        ef!(A, inputs)
        (output=ef(inputs), M=M, A=A) # return not useful if you want to save
        # something from inside let block to an outside variable
end;


