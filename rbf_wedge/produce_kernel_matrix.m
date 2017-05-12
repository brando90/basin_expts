function [ Kern ] = produce_kernel_matrix( X, t, beta )
%
X = X';
t = t';
X_T_2 = sum(X.^2,2) + sum(t.^2,2).' - (2*X)*t.'; % ||x||^2 + ||t||^2 - 2<x,t>
Kern =exp(-beta*X_T_2); %
end

