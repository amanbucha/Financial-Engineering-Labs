
% question 1
err = 500: 500: 10000; 
N = 500: 500: 10000;
for i = 1: length(N)
    del_t = 1/N(i); 
    timepts = 0 + del_t : del_t : 1 - del_t; 
    N_ITR = 2000; 
    E = 1:N_ITR; 
    
    for j = 1 : N_ITR
        W = sqrt(del_t) * randn(length(timepts) , 1);
        X_tilde =         (0.75, 0.3, 307, del_t, timepts, W); 
        X_true =  f_BS(0.75, 0.3, 307, del_t, timepts, W); 
        E(j) = mean(abs(X_true - X_tilde));  
    end
    
    err(i) = mean(E); 
end

loglog(N, err, '-s'), hold on;
loglog(N, 1./sqrt(N)), hold off; 
legend('loglog N vs err','loglog N vs 1/sqrt(N)');




function X = f_BS(mu, sigma, X_init, del_t, timepts, W)
    X = zeros(size(timepts));
    n = length(timepts);
    
    for i = 1 : n
        if i == 1
            X(i) = X_init * exp((mu - 0.5 * sigma * sigma) * del_t + sigma * W(i));
        else
            X(i) = X(i - 1) * exp((mu - 0.5 * sigma * sigma) * del_t + sigma * W(i));
        end
        
    end
end


function [X_tilde] = Euler_Murayama_BS(mu, sigma, X_init, del_t, timepts, W) 
    n = length(timepts); 
    X_tilde = timepts; 
    
    for i = 1:n
        if i == 1
            X_tilde(i) = X_init + mu*X_init*del_t + sigma*X_init*W(i);
        else
            X_tilde(i) = X_tilde(i-1) + mu*X_tilde(i-1)*del_t + sigma*X_tilde(i-1)*W(i);
        end
    end
end

