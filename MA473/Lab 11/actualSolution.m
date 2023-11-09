function X = actualSolution(X0,mu,sig,n,W,dt)
    X = zeros(n,1);
    X(1) = X0;
    for i = 2:n
        X(i) = X(i-1)*exp(sig*W(i)*sqrt(dt) + (mu -0.5*sig*sig)*dt);
    end
end