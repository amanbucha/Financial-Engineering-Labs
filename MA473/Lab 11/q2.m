N = 500:500:7500;
n = length(N);
T = 1./(N-1);
err1 = zeros(n,1);
err2 = zeros(n,1);
for i = 1:n
    s = 0;
    s1 = 0;
    for j = 1:100
        rnd = randn(N(i),1);
        act = actualSolution1(307,0.75,0.3,N(i),rnd,T(i));
        fst = firstOrderMilstein1(307,0.75,0.3,N(i),rnd,T(i));
        scnd = secondOrderMilstein1(307,0.75,0.3,N(i),rnd,T(i));
        s = s + max(abs(act-fst));
        s1 = s1 + max(abs(act-scnd));
    end
    disp(i)
    err1(i) = s/N(i);
    err2(i) = s1/N(i);
end
loglog(N,1./N);
hold on
loglog(N,err1,'-s');
legend('N vs 1/N','N vs error')
title('Log log plot for first order milstein method')
figure
hold off
loglog(N,1./(N.^2));
hold on
loglog(N,err2,'-s');
title('Log log plot for second order milstein method')
legend('N vs 1/N^2','N vs error','Location','northwest')