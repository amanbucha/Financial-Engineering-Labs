function x_gauss_seidel = gauss_seidel(A, b, tolerance, maxIterations)
    n = length(b);
    x_gauss_seidel = zeros(n, 1);

    for k = 1:maxIterations
        x_gauss_seidel_new = zeros(n, 1);
        for i = 1:n
            x_gauss_seidel_new(i) = (b(i) - A(i, 1:i-1) * x_gauss_seidel_new(1:i-1) - A(i, i+1:end) * x_gauss_seidel(i+1:end)) / A(i, i);
        end
        if norm(x_gauss_seidel_new - x_gauss_seidel) < tolerance
            break; % Convergence check
        end
        x_gauss_seidel = x_gauss_seidel_new;
    end
end
