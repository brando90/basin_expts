function [ grad_out ] = dVdW( W,f,i,g_eps )
%
%grad = CalcNumericalFiniteDiff(W,f,g_eps);
grad = numerical_gradient(W,f,g_eps);
grad_out = grad(i);
end

