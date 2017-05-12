function [ dU ] = numerical_gradient_forward(W,f,eps)
%
%compute gradient or finite difference update numerically
[D1, D2] = size(W);
dU = zeros(D1, D2);
e = zeros([D1,D2]);
f_e0 = f(W);
for d1=1:D1
    for d2=1:D2
        e(d1,d2) = eps;
        f_e1 = f(W+e);
        numerical_difference = f_e1 - f_e0;
        dU(d1,d2) = numerical_difference;
    end
end
end

