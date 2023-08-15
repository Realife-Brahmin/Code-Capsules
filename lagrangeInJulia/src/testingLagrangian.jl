using Plots
using LaTeXStrings
# Create a grid of (x, y) coordinates
N = 100;
lb_x = -1.0;
ub_x = 1.0;
lb_y = -1.0;
ub_y = 1.0;
x = LinRange(lb_x, ub_x, N);
y = LinRange(lb_x, ub_y, N);
# Compute g(x, y)
g = x.^2 .+ (y').^2;

f = (y').* (x.^2)
k = 1;

plotg = plot!();
# Plot the bowl
surface!(plotg, x, y, g, 
label=L"g(x, y)",
color=:inferno,
alpha=0.7);


glvl = k.*ones(size(g));

surface!(plotg, x, y, glvl,
label=L"g(x, y) = k",
color=:inferno,
alpha=0.9);

using JuMP, Ipopt
model = Model(Ipopt.Optimizer)


@variable(model, lb_x <= x <= ub_x, start=0.5)
@variable(model, lb_y ≤ y ≤ ub_y, start=0.5)

@NLobjective(model, Max, y * x^2)

@constraint(model, x^2 + y^2 == k)
print(model)
optimize!(model)

x★ = value(x)
y★ = value(y)
f★ = objective_value(model)

println("Optimal Solutions:")
println("x = ", x★)
println("y = ", y★)
println("Max Value of f(x, y) = ", f★)

scatter!(plotg, [x★], [y★], [f★])

plot(plotg, title=L"g(x, y) = x^2 + y^2",
xlabel=L"x",
ylabel=L"y",
zlabel=L"g(x, y)",
legend=:outertopright,
size = (800, 600));

display(plotg)