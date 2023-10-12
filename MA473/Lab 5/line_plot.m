function line_plot(x, u_numerical, u_num2, h, k, scheme, method)
    figure;
    plot(x, u_num2, 'g', x, u_numerical, 'r');
    xlabel('x');
    ylabel('V(x, t)');
    title(sprintf('Linear Plot (%s) (%s)', scheme, method));
    legend('At t = 1', 'At t = 0');
    grid on;
    pause(5);
end