function [ dU_dW ] = numerical_gradient(W,f,eps)
%compute GD update numerically
[D1, D2] = size(W);
dU_dW = zeros(D1, D2);
for d1=1:D1
    for d2=1:D2
        e = zeros([D1,D2]);
        e(d1,d2) = eps;
        f_e1 = f(W+e);
        f_e2 = f(W-e);
        %numerical_derivative = (f_e1 - f_e2)/(2*eps);
        numerical_derivative = f_e1 - f_e2;
        dU_dW(d1,d2) = numerical_derivative;
    end
end
end