function [x1, x, t, u_numerical, u_surface, u_num2] = CN(T, K, r, sigma,delta, S_min, S_max, method)
    h = 1;
    k = h^2/70;
    steps = (S_max - S_min)/h + 1;
    time = 1/k + 1;
    x1 = linspace(S_min,S_max,steps);
    [t, x] = meshgrid(linspace(S_min, S_max, steps), linspace(0,1, time));
    U = zeros(time, steps);
    for i = 1:time
        U(:,1) = K*exp(-r*(T - (i-1)*k));
        U(i, steps) = 0;
    end
    for i= 1:steps
        U(time,i) = max(0, -1*(i-1)*h + K);
    end
    
    for i=time-1:-1:1
        Y = zeros(steps, 1);
        M = zeros(steps, steps);
        M(1,1) = 1;
        Y(1,1) = K*exp(-r*(T - i*k));
        M(steps, steps) = 1;
        for j =2:steps-1
            t1 = (sigma*(j-1)*h)^2;
            t2 = (r - delta)*(j-1)*h;
            M(j,j-1) = (-0.25*t1*k)/h^2 + (t2*k*0.5)/h;
            M(j,j+1) = (-0.25*t1*k)/h^2 - (t2*k*0.5)/h;
            M(j,j) = 1 + 0.5*r*k + (0.5*t1*k)/h^2;
            Y(j) = (1 - 0.5*r*k)*U(i+1, j) + 0.25*k*t1*(U(i+1,j+1) + U(i+1,j-1) -2*U(i+1,j)) -0.5*t2*k*(U(i+1, j+1) - U(i+1, j-1));
        end
        U(i,:) = tridiagonal_matrix(M,Y, method);
    end

    u_numerical = U(1, :);
    u_num2 = U(time, :);
    u_surface = U;
end
