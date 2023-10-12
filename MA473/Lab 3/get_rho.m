function rho = get_rho(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m, idx)
    
    schemes = { @(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m) FTCS(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m),
            @(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m) BTCS(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m),
            @(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m) CrankNicolson(N, M, x, t, lambda, dx, dt, K, T, r, sigma, delta, f1, f2, g, a, b, c, d, m)};

    del_r = 0.001;
    
    U_plus = schemes{idx}(N, M, x, flip(t), lambda, dx, -dt, K, T, r + del_r, sigma, delta, f1, f2, g, a, b, c, d, m);
    U_minus = schemes{idx}(N, M, x, flip(t), lambda, dx, -dt, K, T, r - del_r, sigma, delta, f1, f2, g, a, b, c, d, m);
    
    [~, m] = size(U_plus); 
    rho = zeros(1, m-2); 
    
    for i = 2:m-1 
        rho(1, i-1) = (U_plus(end, i) - U_minus(end, i))/ (2*del_r); 
    end
    
end
