using BenchmarkTools
using CSV
using DataFrames
using LinearAlgebra
using Revise
using Symbolics

@variables t x y;

M = [t+2t^2 6t; x+2t+2y y^2];

f, f! = build_function(M, [x, y, t], expression=Val{false});
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

function objFun(;getGradientToo=true)
        @variables A₀, A, τ, ω, α, ϕ
        x = [A₀, A, τ, ω, α, ϕ] 
        f = A₀ + A*exp(-t/τ)sin((ω+α*t)t + ϕ)
        ∇f = Symbolics.gradient(f, x)
        return f, ∇f
end

f, ∇f = objFun();

rawDataFolder = "rawData/";
filename = rawDataFolder*"FFD.csv";
df = CSV.File(filename) |> DataFrame;
rename!(df, [:t, :f])
