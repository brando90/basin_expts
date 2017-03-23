function [ U ] = U( W, arg )
% get basin lost surface
E1 = evaluate_basin(W,arg.mu1,arg.std1);
E2 = evaluate_basin(W,arg.mu2,arg.std2);
U = 1 - E1 - E2;
%U = 1 - E1;
end

