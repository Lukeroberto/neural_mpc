using JuMP
using Ipopt
using Formatting


function build_model(x_up)
    # Model
    model = Model(with_optimizer(Ipopt.Optimizer, print_level=0))

    # Variables w/ constraints
    @variable(model, 0 <= x <= x_up)
    @variable(model, 0 <= y <= 30)

    # Other Constraints
    @constraint(model, con, x^2 + 5y <= 3)

    @objective(model, Max, 5x + 3y)

    model, [x, y]
end

macro var_print(arg)
    string(arg)
end

function print_optimized_model(opt_model, vars)
    x, y = vars[1], vars[2]

    printfmtln("Objective value: {:e}", string(objective_value(opt_model)))
    printfmtln("(x, y): ({:.2e}, {:e})", string(value(x)), string(value(y)))
end