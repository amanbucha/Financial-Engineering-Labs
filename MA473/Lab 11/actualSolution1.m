function X = actualSolution1(X0,mu,sig,n,W,dt)
    X = zeros(n,1);
    X(1) = X0;
    for i = 2:n
        X(i) = exp(-mu*dt)*(X(i-1) + sig*W(i));
    end
end