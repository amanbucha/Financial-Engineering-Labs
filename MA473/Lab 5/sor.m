function x_sor = sor(A, b, omega, tolerance, maxIterations)
    n = length(b);
    x_sor = zeros(n, 1);

    for k = 1:maxIterations
        x_sor_new = zeros(n, 1);
        for i = 1:n
            x_sor_new(i) = (1 - omega) * x_sor(i) + (omega / A(i, i)) * (b(i) - A(i, 1:i-1) * x_sor_new(1:i-1) - A(i, i+1:end) * x_sor(i+1:end));
        end
        if norm(x_sor_new - x_sor) < tolerance
            break; % Convergence check
        end
        x_sor = x_sor_new;
    end
end
