function X = firstOrderMilstein(X0,mu,sig,n,W,dt)
    X = zeros(n,1);
    X(1) = X0;
    for i = 1:n-1
        X(i+1) = X(i) + mu*X(i)*dt + sig*X(i)*sqrt(dt)*W(i+1) + 0.5*sig*sig*dt*((W(i+1)^2) - 1); 
    end
end