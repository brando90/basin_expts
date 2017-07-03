function [ dU ] = numerical_gradient(W,f,eps)
%compute gradient or finite difference update numerically
[D1, D2] = size(W);
dU = zeros(D1, D2);
for d1=1:D1
    for d2=1:D2
        e = zeros([D1,D2]);
        e(d1,d2) = eps;
        f_e1 = f(W+e);
        f_e2 = f(W-e);
        numerical_derivative = (f_e1 - f_e2)/(2*eps);
        dU(d1,d2) = numerical_derivative;
        %numerical_difference = f_e1 - f_e2;
        %dU(d1,d2) = numerical_difference;
    end
end
end