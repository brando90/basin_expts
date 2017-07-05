function [ dU ] = numerical_gradient_forward(W,f,eps)
%
%compute gradient or finite difference update numerically
[D1, D2] = size(W);
dU = zeros(D1, D2);
e = zeros([D1,D2]);
f_e0 = f(W);
%disp('f_e0 %s \n',f_e0);
for d1=1:D1
    for d2=1:D2
        e = zeros([D1,D2]);
        e(d1,d2) = eps;
        f_e1_val = f(W+e);
        f_e1 = f_e1_val;
        dudw = (f_e1 - f_e0)/(eps);
        dU(d1,d2) = dudw;
    end
end
end

