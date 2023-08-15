using Plots
using LaTeXStrings
# Create a grid of (x, y) coordinates
N = 100;
x = LinRange(-2.5, 2.5, N);
y = LinRange(-2.5, 2.5, N);
# Compute g(x, y)
g = x.^2 .+ (y').^2;
k = 6;

plotg = plot!();
# Plot the bowl
surface!(plotg, x, y, g, 
Legend=L"g(x, y)",
color=:inferno,
alpha=0.7);


glvl = k.*ones(size(g));

surface!(plotg, x, y, glvl,
Legend=L"g(x, y) = k",
color=:inferno,
alpha=0.9);

plot(plotg, title=L"g(x, y) = x^2 + y^2",
xlabel=L"x",
ylabel=L"y",
zlabel=L"g(x, y)",
size = (800, 600))