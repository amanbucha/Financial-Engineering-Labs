schemes = {@(h,k,r,delta,sigma) FTCS(h,k,r,delta,sigma); 
           @(h,k,r,delta,sigma) BTCS(h,k,r,delta,sigma);
           @(h,k,r,delta,sigma) CN(h,k,r,delta,sigma)};

h = 0.05;
k = 0.00045;
r = 0.06;
delta = 0;
sigma = 0.3;
T = 1;
K = 10;
methods = {'FTCS', 'BTCS', 'CN'};

for i = 1:length(methods)
    [x1, x, t, u_numerical, u_surface] = schemes{i}(h, k,r,delta,sigma);
    if(~isempty(x))
      line_plot(x1,u_numerical, h, k, methods{i});
      surface_plot(x, t, u_surface, h, k, methods{i});
    end
end

function [x1, x, t, u_numerical, u_surface] = FTCS(h,k,r,delta,sigma)
    q_delta = (2*(r - delta))/(sigma*sigma);
    delta = k/(h*h);
    if delta > 0.5
        x = [];
        t =[];
        x1 = [];
        u_numerical = [];
        u_surface = [];
        disp('Scheme is unstable - r > 0.5');
    else 
        steps = 10/h + 1;
        tp = (sigma*sigma)/2;
        time = tp/k + 1;
        x1 = linspace(-5,5,steps);
        [t, x] = meshgrid(linspace(-5, 5, steps), linspace(0, power(sigma,2)/2, time));
        U = zeros(time, steps);
        U(:, 1) = 0;
        for i = 1:time
            U(i, steps) = exp(0.5*((steps -1)*h - 5)*(q_delta + 1) + 0.25*tp*(i-1)*k*(q_delta+1)*(q_delta + 1));
        end
        for i= 1:steps
            U(1,i) = max(0, exp((q_delta + 1)*0.5*(h*(i-1) - 5)) - exp((q_delta - 1)*0.5*(h*(i-1) -5)));
        end
        for i=2:time
           for j=2:steps-1
               U(i,j) = delta*U(i-1,j-1) + (1 - 2*delta)*U(i-1,j) + delta*U(i-1,j+1);
           end
        end
        u_numerical = U(time, :);
        u_surface = U;
    end
end

function [x1, x, t, u_numerical, u_surface] = BTCS(h, k,r,delta,sigma)
    q_delta = (2*(r - delta))/(sigma*sigma);
    tp = (sigma*sigma)/2;
    steps = 10 / h + 1;
    time = tp / k + 1;
    x1 = linspace(-5,5,steps);
    [t, x] = meshgrid(linspace(-5, 5, steps), linspace(0, power(sigma,2)/2, time));
    U = zeros(time, steps);
    U(:, 1) = 0;
    for i = 1:time
        U(i, steps) = exp(0.5*((steps -1)*h - 5)*(q_delta + 1) + 0.25*tp*(i-1)*k*(q_delta+1)*(q_delta + 1));
    end
    for i= 1:steps
        U(1,i) = max(0, exp((q_delta + 1)*0.5*(h*(i-1) - 5)) - exp((q_delta - 1)*0.5*(h*(i-1) -5)));
    end
    for i=2:time
       for j=2:steps-1
           U(i,j) = delta*U(i-1,j-1) + (1 - 2*delta)*U(i-1,j) + delta*U(i-1,j+1);
       end
    end
    alpha = k / (h * h);
    for i = 2:time
        Y = zeros(steps, 1);
        M = zeros(steps, steps);
        M(1,1) = 1;
        M(steps, steps) = 1;
        for j =2:steps-1
            M(j,j-1) = -alpha;
            M(j,j+1) = -alpha;
            M(j,j) = 1 + 2*alpha;
            Y(j) = U(i-1, j);
        end
        U(i,:) = tridiagonal_matrix(M,Y);
    end
    u_numerical = U(time, :);
    u_surface = U;
end

function [x1, x, t, u_numerical, u_surface] = CN(h, k,r,delta,sigma)
    q_delta = (2*(r - delta))/(sigma*sigma);
    tp = (sigma*sigma)/2;
    steps = 10 / h + 1;
    time = tp/ k + 1;
    x1 = linspace(0,1,steps);
    [t, x] = meshgrid(linspace(-5, 5, steps), linspace(0, power(sigma,2)/2, time));
    U = zeros(time, steps);
    U(:, 1) = 0;
    for i = 1:time
        U(i, steps) = exp(0.5*((steps -1)*h - 5)*(q_delta + 1) + 0.25*tp*(i-1)*k*(q_delta+1)*(q_delta + 1));
    end
    for i= 1:steps
        U(1,i) = max(0, exp((q_delta + 1)*0.5*(h*(i-1) - 5)) - exp((q_delta - 1)*0.5*(h*(i-1) -5)));
    end
    for i=2:time
       for j=2:steps-1
           U(i,j) = delta*U(i-1,j-1) + (1 - 2*delta)*U(i-1,j) + delta*U(i-1,j+1);
       end
    end
    alpha = k / (2 * h * h);
    for i = 2:time
        M = zeros(steps, steps);
        Y = zeros(steps, 1);
        M(1,1) = 1;
        M(steps, steps) = 1;
        for j =2:steps-1
            M(j,j-1) = -alpha;
            M(j,j+1) = -alpha;
            M(j,j) = 1 + 2*alpha;
            Y(j) = ((1 - 2*alpha)*U(i-1, j)) + alpha*(U(i-1, j-1) + U(i-1, j+1));
        end
        U(i,:) = tridiagonal_matrix(M,Y);
    end
    u_numerical = U(time, :);
    u_surface = U;
end

function line_plot(x, u_numerical, h, k, scheme)
    plot(x, u_numerical, 'r');
    xlabel('x');
    ylabel('Y(x, 0.045)');
    title(sprintf('Linear Plot (h = %.1e, k = %.1e, %s)', h, k, scheme));
    legend('Numerical');
    grid on;
end

function surface_plot(x, t, u_numerical, h, k, scheme)
    m = 0.045/k + 1;
    [X,Y] = meshgrid(-5:h:5,linspace(0,0.5*0.3^2,m));
    figure;
    surf(Y, X, u_numerical, 'EdgeColor', 'none');
    xlabel('t');
    ylabel('x');
    zlabel('Y(x, tau)');
    xlim([0, 0.045]);
    ylim([-5, 5]);
    title(sprintf('Numerical Solution (h = %.1e, k = %.1e, %s)', h, k, scheme));
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

