import Pkg
Pkg.add("JuMP")
import Pkg
Pkg.add("HiGHS")
import Pkg; Pkg.add("GLPK")

using JuMP
using HiGHS
using GLPK

#Part 1

#Define our Model

m = Model(GLPK.Optimizer)

#Variable
    # NOTE THAT USING \_ ALLOWS SUBSCRIPTING JESUIS CHRIST
@variable(m,x₁₁>=0)
@variable(m,x₁₂>=0)
@variable(m,x₂₁>=0)
@variable(m,x₂₂>=0)
@variable(m,x₃₁>=0)
@variable(m,x₃₂>=0)

#constraints
@constraint(m,x₁₁+x₂₁+x₃₁<=24)
@constraint(m, x₁₂+x₂₁+x₃₂ <=24)
@constraint(m, x₁₁+2x₁₂<=15)
@constraint(m, 1.2x₂₁+3x₂₁ <=24)
@constraint(m, 2x₃₁+3x₃₂ <=18)

#objective
@objective(m, Max, x₁₁+2x₁₂+1.2x₂₁+3x₂₁+2x₃₁+ 3x₃₂)

@show m

optimize!(m)

println("Objective Value: ", objective_value(m))

#Part 2 

