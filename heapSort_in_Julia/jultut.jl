using Printf
using Statistics

age = 12
if age >= 5 && age <= 6
    println("You're in Kindergarten\n")
elseif age>=7 && age <= 13
    println("You're in Middle School\n")
elseif age >= 14 && age <= 18
    println("You're in High School\n")
else
    println("Stay Home\n")
end

@printf("true || false = %s\n", true || false ? "true" : "false")
@printf("!true = %s\n", !true)
