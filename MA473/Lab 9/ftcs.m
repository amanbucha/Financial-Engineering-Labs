function ftcs(T,r,sig,Rmax,dt,dr)
    m = 1 + (T/dt);
    n = 1 + (Rmax/dr);
    H = zeros(m,n);
    R = 0;
    for i = 1:n
        H(m,i) = max(0,1-(R/T));
        R = R + dr;
    end
    for i = m-1:-1:1
        R = dr;
        for j = 2:n-1
            H(i,j) = H(i+1,j) + 0.5*(dt/(dr*dr))*sig*sig*R*R*(H(i+1,j-1)-2*H(i+1,j)+H(i+1,j+1)) + (0.5*dt/dr)*(1-r*R)*(H(i+1,j+1)-H(i+1,j-1));
            R = R + dr;
        end
        H(i,1) = H(i+1,1) + (dt/dr)*(H(i+1,2)-H(i+1,1));
    end
    [X,Y] = meshgrid(0:dr:Rmax,0:dt:T);
    surf(X,Y,H,'EdgeColor','none');
    xlabel('R');
    ylabel('t');
    zlabel('H(R,t)');
    title('H(R,t) vs R and t using ftcs');
    figure
end