function [ Kern ] = produce_kernel_matrix_bsxfun( X, t, beta )
% X = [N x D]
% t = [K x D]
% beta = [1 x 1]
xx=sum(X.^2,2); % (N x 1)
tt=sum(t.^2,2)'; % (K x 1)
Kern = exp( -beta*( xx+tt-2*(X*t') ) ); % N x K
end