using Plots
using LaTeXStrings
# Create a grid of (x, y) coordinates
n = 100;
x = LinRange(-1.5, 1.5, n);
y = LinRange(-1.5, 1.5, n);
# g = zeros(Float64, n, n)
# Compute g(x, y)
g = x.^2 .+ (y').^2

# Plot the bowl
surface(x, y, g, 
title=L"$g(x, y) = x^2 + y^2$",
xlabel=L"$x$",
ylabel=L"$y$",
zlabel=L"$g(x, y)$",
Legend=L"$g(x, y)$")

# Plot the intersection curve: g(x, y) = 1
# which is equivalent to y^2 = 1 - x^2
for xi in x
    if 1 - xi^2 >= 0
        yi = sqrt(1 - xi^2)
        plot!([xi], [yi], [1], seriestype=:scatter, color=:red, label=false)
        plot!([xi], [-yi], [1], seriestype=:scatter, color=:red, label=false)
    end
end

# Show the plot
plot!(xlabel="x", ylabel="y", zlabel="g(x, y)", legend=:outertopright)
