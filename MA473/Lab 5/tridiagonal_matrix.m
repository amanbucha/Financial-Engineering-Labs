function X = tridiagonal_matrix(mat, D, method)
    omega = 1.2;
    % method: 'jacobi', 'gauss_seidel', 'sor'

    n = length(D);
    P = zeros(n, 1);
    Q = zeros(n, 1);
    P(1) = -mat(1, 2) / mat(1, 1);
    Q(1) = D(1) / mat(1, 1);
    p = P(1);
    q = Q(1);

    for i = 2:n
        q = (D(i) - mat(i, i - 1) * q) / (mat(i, i) + mat(i, i - 1) * p);
        if i ~= n
            p = -mat(i, i + 1) / (mat(i, i) + p * mat(i, i - 1));
        else
            p = 0;
        end
        P(i) = p;
        Q(i) = q;
    end

    X = zeros(1, n);
    X(1, n) = Q(n);
    for i = n - 1:-1:1
        X(1, i) = X(1, i + 1) * P(i) + Q(i);
    end

    % Apply the specified method
    if strcmp(method, 'jacobi')
        X = jacobi_iteration(mat, D, X, omega);
    elseif strcmp(method, 'gauss_seidel')
        X = gauss_seidel_iteration(mat, D, X);
    elseif strcmp(method, 'sor')
        X = sor_iteration(mat, D, X, omega);
    end
end

function X = jacobi_iteration(mat, D, X, ~)
    n = length(D);
    X_new = zeros(1, n);

    for i = 1:n
        X_new(i) = (D(i) - sum(mat(i, [1:i-1, i+1:end]) .* X([1:i-1, i+1:end]))) / mat(i, i);
    end

    X = X_new;
end

function X = gauss_seidel_iteration(mat, D, X)
    n = length(D);

    for i = 1:n
        X(i) = (D(i) - sum(mat(i, [1:i-1, i+1:end]) .* X([1:i-1, i+1:end]))) / mat(i, i);
    end
end

function X = sor_iteration(mat, D, X, omega)
    n = length(D);

    for i = 1:n
        X(i) = (1 - omega) * X(i) + (omega / mat(i, i)) * (D(i) - sum(mat(i, [1:i-1, i+1:end]) .* X([1:i-1, i+1:end])));
    end
end
