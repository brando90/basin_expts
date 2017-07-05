clear;
%%
lb = 0; ub = 1;
D = 5;
batch_size = 5;
N=5;
x = linspace(lb,ub,N);
y = [0;1;0;-1;0];
%%
indices = 1:N;
i_batch = datasample(indices,batch_size,'Replace',false);
x_batch = x(i_batch); % [M,1]
x_batch = poly_kernel_matrix(x_batch,D-1);
X = x_batch;
y_batch = y(i_batch); % [M,1]
Y = y_batch;
%%
f = @(c) (1/batch_size)*norm(y_batch - x_batch*c,'fro')^2;
f2 = @(c) (1/batch_size)*norm(y_batch - x_batch*c,2)^2;
%%
%W = zeros(D,1);
%W = W + normrnd(0,1,[D,1]);
W = (1:D)';
%%
eps = 0.00000001;
%%
% l2_loss = l2loss( x_batch,y_batch,W )
% loss_f = f(W)
% loss_f2 = f2(W)
%% dfdx__forward
dfdx_forward = numerical_gradient_forward(W,f,eps)
dfdx_forward2 = numerical_gradient_forward(W,f2,eps)
%% dfdx_SO
%dfdx_SO = CalcNumericalDeriv(W,f,eps)
%% dfdx__forward_backard
dfdx_forward_backard = numerical_gradient(W,f,eps)
%dfdx_forward_backard = numerical_gradient(W,f2,eps)
%% l2 loss numerical
l2loss = @(W) l2loss(x_batch,y_batch,W);
dl2lossdx = numerical_gradient_forward(W,l2loss,eps)
%% analitic derivative loops
g_loops = dl2dw(x_batch,y_batch,W)
%% analitic derivative
delta = (x_batch*W - y_batch); % [M,1]
g = 2*(1/batch_size)*sum(delta.*x_batch,1)'
W