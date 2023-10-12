function surface_plot(x, t, u_numerical, h, k, scheme, method)
    m = 1/k + 1;
    [X,Y] = meshgrid(0:h:30,linspace(0,1,m));
    figure;
    surf(Y, X, u_numerical, 'EdgeColor', 'none');
    xlabel('t');
    ylabel('x');
    zlabel('V(x, t)');
    xlim([0, 1]);
    ylim([0, 30]);
    title(sprintf('Numerical Solution (%s), (%s)', scheme, method));
    pause(5);
end
