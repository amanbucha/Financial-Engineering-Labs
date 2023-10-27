quadrature_rules = {@(f, x_min, x_max, h, N, i, j, a, b) simpsons(f, x_min, x_max, h, N, i, j, a, b)};
                 
basis_functions = { @(x_min, x_max, h, N, i, x) linear_basis(x_min, x_max, h, N, i, x)};

basis_derivatives = { @(x_min, x_max, h, N, i, x, flag) derivative_linear_basis(x_min, x_max, h, N, i, x, flag)};


        fprintf('\nSolving BVP using %s\n\n", "Linear basis function and Simpsons rule');
        
        basis = basis_functions{1};
        quadrature = quadrature_rules{1};
        der_b = basis_derivatives{1};
        [x_min, x_max, N] = deal(0, 1, 100);
        h = (x_max - x_min)/N;
        
        X = linspace(x_min, x_max, N+1);
        [A_1, A_2, A_3] = deal(zeros(N+1, N+1));
        d = zeros(N+1, 1);
        
        for i = 1 : N - 1
            for j = 0 : N
                for k = 0 : N - 1
                    func1 = @(x_min, x_max, h, N, i, j, val, fl) der_b(x_min, x_max, h, N, i, val, fl) * der_b(x_min, x_max, h, N, j, val, fl);
                    A_1(i+1, j+1) = A_1(i+1, j+1) + quadrature(func1, x_min, x_max, X(k+2)-X(k+1), N, i, j, X(k+1), X(k+2));
                    
                    func2 = @(x_min, x_max, h, N, i, j, val, fl) p(val) * basis(x_min, x_max, h, N, i, val) * der_b(x_min, x_max, h, N, j, val, fl);
                    A_2(i+1, j+1) = A_2(i+1, j+1) + quadrature(func2, x_min, x_max, X(k+2)-X(k+1), N, i, j, X(k+1), X(k+2));

                    func3 = @(x_min, x_max, h, N, i, j, val, fl) q(val) * basis(x_min, x_max, h, N, i, val) * basis(x_min, x_max, h, N, j, val);
                    A_3(i+1, j+1) = A_3(i+1, j+1) + quadrature(func3, x_min, x_max, X(k+2)-X(k+1), N, i, j, X(k+1), X(k+2));

                    if j == 0
                        func4 = @(x_min, x_max, h, N, i, j, val, fl) f(val) * basis(x_min, x_max, h, N, i, val);
                        d(i + 1) = d(i + 1) + quadrature(func4, x_min, x_max, X(k+2)-X(k+1), N, i, j, X(k+1), X(k+2));
                    end
                end
            end
        end
        
        A = A_1 + A_2 + A_3;
        [A(1, 1), A(N + 1, N + 1)] = deal(1);
        U = A \ d;
        
        % Plot the solution
        figure();
        plot(X, U');
        xlabel('x');
        ylabel('u');
        title('Linear basis function and Simpsons rule');


function val = p(x)
    val = 2*x - 3;
end

function val = q(x)
    val = zeros(size(x));
end

function val = f(x)
    val = 2*x + 1;
end
