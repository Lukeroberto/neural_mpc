using JuMP
using Ipopt


function build_model(x_up)
    # Model
    model = Model(with_optimizer(Ipopt.Optimizer))

    # Variables w/ constraints
    @variable(model, 0 <= x <= x_up)
    @variable(model, 0 <= y <= 30)

    # Other Constraints
    @constraint(model, con, x + 5y <= 3)

    @objective(model, Max, 5x + 3y)

    set_silent(model)

    model
end

macro var_print(arg)
    string(arg)
end

function print_optimized_model(opt_model, vars)
    x, y = vars[1], vars[2]

    println("Objective value: " * string(objective_value(opt_model)))
    println("(x, y): " * "(" * string(value(x)) * " " * string(value(y)) * ")")
end