function line_plot(x, tau, V, T, sigma,K)
    S = K * exp(x);
    time = T - tau * 2 / sigma^2;
    
    figure();
    plot(S,V(:,81), 'r');
    xlabel('S');
    ylabel('V(S,T)');
    title('European Call option using piecewise-linear basis functions with Simpsons rule' );
    legend('Numerical');
    grid on;
end