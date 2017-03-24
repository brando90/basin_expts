function [ U ] = U_func( W,mu1,std1,mu2,std2 )
%U
U = 1 - evaluate_basin(W,mu1,std1) - evaluate_basin(W,mu2,std2);
end

