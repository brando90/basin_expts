clear;
%%
load('rbf_loss_surface_visual2');
%%
f = @(x) exp(norm(x,2));
%f = @(x) f_batch_new(x,ind_mini_batch,params);
%%
D = 2
W = 7.0*rand(1,D);
%%
eps = 0.00000001;
%% dfdx__forward
dfdx_forward = numerical_gradient_forward(W,f,eps)
%% dfdx_SO
dfdx_SO = CalcNumericalDeriv(W,f,eps)
%% dfdx__forward_backard
dfdx_forward_backard = numerical_gradient(W,f,eps)