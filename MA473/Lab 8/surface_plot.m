function surface_plot(x, tau, V, T, sigma, K)
    figure();
    S = K * exp(x);
    time = T - tau * 2 / sigma^2;
    
    surf(S', time', V');
    
    xlabel('S');
    ylabel('t');
    zlabel('V(S, t)');
    
    title('European Call option using piecewise-linear basis functions with Simpsons rule' );
end