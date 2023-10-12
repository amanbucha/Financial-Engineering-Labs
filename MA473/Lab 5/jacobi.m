function x_jacobi = jacobi(A, b, tolerance, maxIterations)
    n = length(b);
    x_jacobi = zeros(n, 1);

    for k = 1:maxIterations
        x_jacobi_new = zeros(n, 1);
        for j = 1:n
            x_jacobi_new(j) = ((b(j) - A(j,[1:j-1,j+1:n]) * x_jacobi([1:j-1,j+1:n])) / A(j,j));
        end
        if norm(x_jacobi_new - x_jacobi) < tolerance
            break; % Convergence check
        end
        x_jacobi = x_jacobi_new;
    end
end
