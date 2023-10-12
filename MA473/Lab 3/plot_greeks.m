function plot_greeks(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m, idx, U)
    % This function plots the greeks for the corresponding inputs.
    % INPUT: x, y, z (representing the data points)
    % OUTPUT: different plots for all of the greeks; 
    schemes = [string('FTCS'), string('BTCS'), string('Crank-Nicolson')];
    [~, m] = size(U);
    
    greek_delta = get_delta(U, dx); 
    gamma = get_gamma(U, dx); 
    theta = get_theta(U, dt); 
    vega = get_vega(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m, idx);
    rho = get_rho(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m, idx);
    
    figure;
    
    subplot(2, 3, 1);
    plot(x(2:m-1), greek_delta(1, :), 'LineWidth', 2.3);
    title('delta');
    
    subplot(2, 3, 2);
    plot(x(2:m-1), gamma(1, :), 'LineWidth', 2.3);
    title('gamma');
    
    subplot(2, 3, 3);
    plot(x(2:m-1), theta(1, :), 'LineWidth', 2.3);
    title('theta');
    
    subplot(2, 3, 4);
    plot(x(2:m-1), vega(1, :), 'LineWidth', 2.3);
    title('vega');
    
    subplot(2, 3, 5);
    plot(x(2:m-1), rho(1, :), 'LineWidth', 2.3);
    title('rho');
    
    suptitle(['Greek Plots using ' char(schemes(idx))]);
end
