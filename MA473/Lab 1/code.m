h = [1e-2, 1e-3, 1e-4];
k = [5e-4, 1e-3, 1e-2];

schemes = {@(hh,kk) FTCS(hh, kk); 
           @(hh,kk) BTCS(hh, kk);
           @(hh,kk) CN(hh, kk)};
       
methods = {'FTCS', 'BTCS', 'CN'};
for i = 1:length(methods)
    for idx = 1:3
        [x1,x,t, u_actual, u_numerical, u_surface, u_act_surf] = schemes{i}(h(idx), k(idx));
        if(~isempty(x))
          line_plot(x1,u_actual,u_numerical, h(idx), k(idx), methods{i});
          surface_plot(x, t, u_act_surf, u_surface, h(idx), k(idx), methods{i});
        end
    end
end

function [x1, x, t, u_actual, u_numerical, u_surface, u_act_surf] = FTCS(h,k)
    r = k/(h*h);
    if r > 0.5
        x = [];
        t =[];
        x1 = [];
        u_actual = [];
        u_numerical = [];
        u_surface = [];
        u_act_surf = [];
        disp('Scheme is unstable - r > 0.5');
    else 
        time = 1/k + 1;
        steps = 1/h + 1;
        x1 = linspace(0,1,steps);
        [t, x] = meshgrid(linspace(0, 1, steps), linspace(0, 1, time));
        U = zeros(time, steps);
        u_act_surf = zeros(time,steps);
        U(:, 1) = 0;
        U(:, steps) = 0;

        for i= 2:steps-1
            U(1,i) = sin(pi*(i-1)*h);
        end
        for i=2:time
           for j=2:steps-1
               U(i,j) = r*U(i-1,j-1) + (1 - 2*r)*U(i-1,j) + r*U(i-1,j+1);
           end
        end

        for i=1:time
            for j = 1:steps
                u_act_surf(i,j) = exp(-pi^2*(i-1)*k)*sin(pi*(j-1)*h); 
            end
        end
        u_actual = exp(-pi*pi*1).*sin(pi*x1); 
        u_numerical = U(time, :);
        u_surface = U;
    end
end


function [x1, x, t, u_actual, u_numerical, u_surface, u_act_surf] = BTCS(h, k)
    steps = 1 / h + 1;
    time = 1 / k + 1;
    x1 = linspace(0, 1, steps);
    [t, x] = meshgrid(linspace(0, 1, steps), linspace(0, 1, time));
    U = zeros(time, steps);
    u_act_surf = zeros(time, steps);
    U(:, 1) = 0;
    U(:, steps) = 0;
    for i = 2:steps-1
        U(1, i) = sin(pi * (i - 1) * h);
    end

    r = k / (h * h);
    for i = 2:time
        M = zeros(steps, steps);
        Y = zeros(steps, 1);
        M(1,1) = 1;
        M(steps, steps) = 1;
        for j =2:steps-1
            M(j,j-1) = -r;
            M(j,j+1) = -r;
            M(j,j) = 1 + 2*r;
            Y(j) = U(i-1, j);
        end
        U(i,:) = tridiagonal_matrix(M,Y);
    end
    for i = 1:time
        for j = 1:steps
            u_act_surf(i, j) = exp(-pi^2 * (i - 1) * k) * sin(pi * (j - 1) * h);
        end
    end
    u_actual = exp(-pi * pi * 1) .* sin(pi * x1);
    u_numerical = U(time, :);
    u_surface = U;
end

function [x1, x, t, u_actual, u_numerical, u_surface, u_act_surf] = CN(h, k)
    steps = 1 / h + 1;
    time = 1 / k + 1;
    x1 = linspace(0, 1, steps);
    [t, x] = meshgrid(linspace(0, 1, steps), linspace(0, 1, time));
    U = zeros(time, steps);
    u_act_surf = zeros(time, steps);
    U(:, 1) = 0;
    U(:, steps) = 0;
    for i = 2:steps-1
        U(1, i) = sin(pi * (i - 1) * h);
    end
    r = k / (2 * h * h);
    for i = 2:time
        M = zeros(steps, steps);
        Y = zeros(steps, 1);
        M(1,1) = 1;
        M(steps, steps) = 1;
        for j =2:steps-1
            M(j,j-1) = -r;
            M(j,j+1) = -r;
            M(j,j) = 1 + 2*r;
            Y(j) = ((1 - 2*r)*U(i-1, j)) + r*(U(i-1, j-1) + U(i-1, j+1));
        end
        U(i,:) = tridiagonal_matrix(M,Y);
    end

    for i = 1:time
        for j = 1:steps
            u_act_surf(i, j) = exp(-pi^2 * (i - 1) * k) * sin(pi * (j - 1) * h);
        end
    end
    u_actual = exp(-pi * pi * 1) .* sin(pi * x1);
    u_numerical = U(time, :);
    u_surface = U;
end

function X = tridiagonal_matrix(mat, D)
    n = length(D);
    P = zeros(n,1);
    Q = zeros(n,1);
    P(1) = -mat(1,2) / mat(1,1);
    Q(1) = D(1) / mat(1,1);
    p = P(1);
    q = Q(1);
    for i = 2:n
        q = (D(i) - mat(i,i-1)*q) / (mat(i,i) + mat(i,i-1)*p);
        if i ~= n
            p = -mat(i,i+1) / (mat(i,i) + p*mat(i,i-1));
        else
            p = 0;
        end
        P(i) = p;
        Q(i) = q;
    end

    X = zeros(1,n);
    X(1, n) = Q(n);
    for i = n-1:-1:1
        X(1,i) = X(1, i+1)*P(i) + Q(i);
    end
end

function line_plot(x, u_actual, u_numerical, h, k, scheme)
    plot(x, u_actual, 'g', x, u_numerical, 'r');
    xlabel('x');
    ylabel('u');
    title(sprintf('Linear Plot (h = %.1e, k = %.1e, %s)', h, k, scheme));
    legend('Actual', 'Numerical');
    grid on;
end

function surface_plot(x, t, u_actual, u_numerical, h, k, scheme)
    figure;
    subplot(1, 2, 1);
    surf(t, x, u_actual, 'EdgeColor', 'none');
    xlabel('t');
    ylabel('x');
    zlabel('u(x, t)');
    title(sprintf('Exact Solution (h = %.1e, k = %.1e, %s)', h, k, scheme));
    xlim([0, 1]);
    ylim([0, 1]);
    
    subplot(1, 2, 2);
    surf(t, x, u_numerical, 'EdgeColor', 'none');
    xlabel('t');
    ylabel('x');
    zlabel('u(x, t)');
    xlim([0, 1]);
    ylim([0, 1]);
    title(sprintf('Numerical Solution (h = %.1e, k = %.1e, %s)', h, k, scheme));
    pause(5);
end
