function X = secondOrderMilstein(X0,mu,sig,n,W,dt)
    X = zeros(n,1);
    X(1) = X0;
    h = dt;
    cov = [h 0.5*h*h;0.5*h*h h*h*h/3];
    for i = 1:n-1
        rnd = mvnrnd([0 0]',cov);
        X(i+1) = X(i) + mu*X(i)*dt + sig*X(i)*rnd(1) + (mu*sig*X(i))*(rnd(1)*dt-rnd(2)) + mu*sig*X(i)*rnd(2) + 0.5*sig*sig*X(i)*(rnd(1)*rnd(1)-dt) + mu*mu*X(i)*h*h*0.5; 
    end
end