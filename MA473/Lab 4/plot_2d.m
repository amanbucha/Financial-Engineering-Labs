function plot_2d(x, U, idx, m)
    if m ~= ""
        m = " using " + m;
    end

    schemes = ["FTCS", "BTCS", "Crank-Nicolson"];
    figure();
    plot(x, U,'r')
    title("Line plot for dx = 0.01");
    subtitle(schemes(idx) + " scheme" + m);
    xlabel("x");
    ylabel("u(x,T)");
end