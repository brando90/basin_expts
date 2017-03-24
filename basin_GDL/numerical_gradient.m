function [ dU_dW ] = numerical_gradient(W,mu1,std1,mu2,std2, eps)
%compute GD update numerically
[D1, D2] = size(W);
dU_dW = zeros(D1, D2);
for d1=1:D1
    for d2=1:D2
        e = zeros([D1,D2]);
        e(d1,d2) = eps;
        U_e1 = U_func(W+e,mu1,std1,mu2,std2);
        U_e2 = U_fun(W-e,mu1,std1,mu2,std2);
        numerical_derivative = (U_e1 - U_e2)/(2*eps);
        dU_dW(d1,d2) = numerical_derivative;
    end
end
end