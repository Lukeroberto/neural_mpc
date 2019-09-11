module Dynamics

"""
    ice_block_dynamics(x, u)

Simple second order sliding dynamics on ice (no friction).
"""
function ice_block_dynamics(x, u, p)
    m = p

    dx = x[2]
    ddx = (1/m) * u[1]

    dy = x[4]
    ddy = (1/m) * u[2]

    [dx, ddx, dy, ddy]
end

"""
    euler_forward(f, x_0, u, t, p)

Integrates dynamics model f forward for given input u over
the given time horizon t.
"""
function euler_forward(f, x_0, u, t, p)
    dt = t[2] - t[1]

    x = zeros(length(t), length(x_0))
    x[1, :] = x_0
    x_temp = x_0

    for n in 1:length(t)
        x_temp += f(x_temp, u[n, :], p) * dt
        x[n, :] = x_temp
    end

    x
end

end