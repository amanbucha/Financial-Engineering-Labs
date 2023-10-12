function plot_final_time_level(x, t, U, idx)
    % This function plots the greeks for the corresponding inputs.
    % INPUT: x, y, z (representing the data points)
    % OUTPUT: final time level plot
        
    schemes = [string('FTCS'), string('BTCS'), string('Crank-Nicolson')];
    figure(); 
    plot(x, U(1,:)); 
    title('Plot of solutions at final time level using '+ schemes(idx));
%     subtitle(schemes(idx) + ' scheme' + m);
    xlabel('x');
    ylabel('t');
end
