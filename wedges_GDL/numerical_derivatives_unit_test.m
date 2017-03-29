D = 5
W = 7.0*ones(1,D);
%% f
%f = @(x) exp(x);
%f = @(x) polyval([1 2 3 4 5],x);
f = @U_func_unit_test
%% my der
eps = 0.001;
dfdx__forward_me = numerical_gradient_forward(W,f,eps)
%% SO der
dfdx_SO = CalcNumericalGradient(f,W,eps)
%%
dfdx_loops = eps*get_gradient_loops( W )
%% lib derivative
%[dfdx_lib,~] = derivest(f,W) 
%% compare
%dfdx_me == dfdx_their