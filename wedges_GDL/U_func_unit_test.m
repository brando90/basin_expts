function [ U ] = U_func_unit_test( W )
%U
D = length(W);
mu1 = 4*ones(1,D);
std1 = 1.0;
mu2 = 12.0*ones(1,D);
std2 = 2.0;
U = 1 - evaluate_basin(W,mu1,std1) - evaluate_basin(W,mu2,std2);
end

