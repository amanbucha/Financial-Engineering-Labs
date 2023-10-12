r = 0.06;
delta = 0.05;
sigma = 0.3;
T = 1;
K = 10;
S_min = 0;
S_max = 30;
h = 1;
k = h^2/70;
%%% FTCS %%%
methods = {'jacobi', 'sor', 'gauss-seidel'};
for idx = 1:1
    [x1,x,t, u_numerical, u_surface, u_num2] = FTCS(T,K,r,sigma,delta,S_min, S_max, '');
    if(~isempty(x))
      line_plot(x1,u_numerical, u_num2, h, k, 'FTCS', '');
      surface_plot(x, t, u_surface, h, k, 'FTCS', '');
    end
end
for idx1 =1:3

    %%% BTCS %%%
    for idx = 1:1
        [x1,x,t, u_numerical, u_surface, u_num2] = BTCS(T,K,r,sigma,delta,S_min, S_max, methods{idx1});
        if(~isempty(x))
          line_plot(x1,u_numerical, u_num2, h, k, 'BTCS', methods{idx1});
          surface_plot(x, t, u_surface, h, k, 'BTCS', methods{idx1});
        end
    end

    %%% CN %%%
    for idx = 1:1
        [x1,x,t, u_numerical, u_surface, u_num2] = CN(T,K,r,sigma,delta,S_min, S_max, methods{idx1});
        if(~isempty(x))
          line_plot(x1,u_numerical, u_num2, h, k, 'CN', methods{idx1});
          surface_plot(x, t, u_surface, h, k, 'CN', methods{idx1});
        end
    end
end


