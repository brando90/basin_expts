function [ Kern ] = poly_kernel_matrix_loops( x,D )
%compute poly of degree d
% x = N x 1
% return Kern = N x 1
N = length(x);
Kern = zeros(N,D);
%%
%for each data point
for n=1:N
    %compute monomial
    for d=0:D
        Kern(n,d+1) = x(n)^d;
    end
end
end
