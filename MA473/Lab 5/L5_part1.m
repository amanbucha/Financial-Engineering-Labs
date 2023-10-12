% Define the size of the square matrix
n = 4; % You can choose any value between 3 and 6

% Generate a random diagonally dominant square matrix A of size n x n
A = diag(10*rand(1,n)) + rand(n);
A = A + diag(sum(abs(A),2)) - 2*diag(diag(A)); % Ensure diagonally dominant

% Create a random vector b of size n
b = rand(n, 1);

% Define the tolerance for convergence
tolerance = 1e-7;

% Define the maximum number of iterations
maxIterations = 100000;

% Define the relaxation factor for SOR (you can adjust this value)
omega = 1.2;

% Measure time for Jacobi Iteration
tic;
x_jacobi = jacobi(A, b, tolerance, maxIterations);
jacobi_time = toc;

% Measure time for Gauss-Seidel Iteration
tic;
x_gauss_seidel = gauss_seidel(A, b, tolerance, maxIterations);
gauss_seidel_time = toc;

% Measure time for SOR Iteration
tic;
x_sor = sor(A, b, omega, tolerance, maxIterations);
sor_time = toc;

% Display the results and execution times
fprintf('Jacobi Iteration:\n');
disp(x_jacobi);
fprintf('Execution Time for Jacobi: %.6f seconds\n', jacobi_time);

fprintf('Gauss-Seidel Iteration:\n');
disp(x_gauss_seidel);
fprintf('Execution Time for Gauss-Seidel: %.6f seconds\n', gauss_seidel_time);

fprintf('SOR Iteration:\n');
disp(x_sor);
fprintf('Execution Time for SOR: %.6f seconds\n', sor_time);
