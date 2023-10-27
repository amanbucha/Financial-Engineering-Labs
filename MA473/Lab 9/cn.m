function cn(T,r,sig,Rmax,dt,dr)
    m = 1 + (T/dt);
    n = 1 + (Rmax/dr);
    H = zeros(m,n);
    R = 0;
    for i = 1:n
        H(m,i) = max(0,1-(R/T));
        R = R + dr;
    end
    for i = m-1:-1:1
        X = zeros(n,n);
        y = zeros(n,1);
        R = dr;
        X(n,n) = 1;
        for j = 2:n-1
            X(j,j) = -1 - 0.5*sig*sig*R*R*(dt/(dr*dr));
            X(j,j-1) = 0.25*sig*sig*R*R*(dt/(dr*dr)) - 0.5*(dt/dr)*(1-r*R);
            X(j,j+1) = 0.25*sig*sig*R*R*(dt/(dr*dr)) + 0.5*(dt/dr)*(1-r*R);
            y(j,1) = -H(i+1,j) - 0.25*(dt/(dr*dr))*sig*sig*R*R*(H(i+1,j+1)-2*H(i+1,j)+H(i+1,j-1));
            R = R + dr;
        end
        X(1,1) = -1-(dt/dr);
        X(1,2) = dt/dr;
        y(1,1) = -H(i+1,1);
        H(i,:) = (X\y)';
    end
    [X,Y] = meshgrid(0:dr:Rmax,0:dt:T);
    surf(X,Y,H,'EdgeColor','none');
    xlabel('R');
    ylabel('t');
    zlabel('H(R,t)');
    title('H(R,t) vs R and t using crank nicholson');
end