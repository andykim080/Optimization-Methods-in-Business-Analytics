
import Pkg
Pkg.add(["DataFrames", "CSV"])

Pkg.add("JuMP")
Pkg.add("GLPK")


using JuMP
using GLPK
using DataFrames, CSV

# Specify the path to your CSV file
csv_file_path = "/Users/andykim/Downloads/fooddata.xls"

data = DataFrame(CSV.File(csv_file_path))


# Read the CSV file into a DataFrame
data = CSV.File(csv_file_path) |> DataFrame

# Display the content of the DataFrame
@show data

# Extract data from the DataFrame using the column names
calories = data[!, :Calories]
fats = data[!, :Fat]
carbs = data[!, :Carbohydrate]
proteins = data[!, :Protein]
saturated_fats = data[!, "Saturated Fat"]

# Define the optimization model
m = Model(GLPK.Optimizer)

# Define decision variables
@variable(m, x >= 0)  # Calories

# Add constraints
@constraint(m, sum(fats[i] * x for i in 1:size(data, 1)) >= 50)
@constraint(m, sum(carbs[i] * x for i in 1:size(data, 1)) >= 300)
@constraint(m, sum(proteins[i] * x for i in 1:size(data, 1)) >= 60)
@constraint(m, sum(saturated_fats[i] * x for i in 1:size(data, 1)) <= 20)

# Set objective to minimize calories
@objective(m, Min, x)

# Solve the optimization problem
optimize!(m)