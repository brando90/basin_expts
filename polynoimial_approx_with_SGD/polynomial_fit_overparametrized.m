clear;
close all;
%% params
lb = 0; ub = 1;
N = 5;
D_true= 4;
%D_mdl = 50;
D_mdl = D_true;
B=1000;
iter = 20000;
%% sample N points compute Poly(x) of degree(P) = N-1
%a=-1;b=1;
%x = a + (b-a).*rand(N,1);
%c_truth = (1:(D_true+1))';
x = linspace(lb,ub,5);
y = [0;1;0;-1;0];
X_truth = poly_kernel_matrix(x,D_true);
%y = X_truth*c_truth; % [N, 1] = [N, D] x [D, 1]
c_truth = pinv(X_truth)*y;
%% we want X*c_model = y
X_model = poly_kernel_matrix(x,D_mdl);
c_mdl = pinv(X_model)*y;
%%
D_sgd = D_mdl+1;
W = zeros(D_sgd,1);
W = W + normrnd(0,1,[D_sgd,1]);
A=0;gdl_mu_noise = 0.0;gdl_std_noise = 1.0;
eta=0.5*1;
batch_size=2;indices = 1:N;
%
W_history = zeros(iter,D_sgd);
W_history(1,:) = W;
%
eps = 0.00000001;
tic
for i=2:iter+1
    %% mini-batch
    i_batch = datasample(indices,batch_size,'Replace',false);
    x_batch = x(i_batch); % [M,1]
    x_batch = poly_kernel_matrix(x_batch,D_sgd-1);
    y_batch = y(i_batch); % [M,1]
    %f2 = @(c) (1/batch_size)*norm(y_batch - x_batch*c,2);
    %% get gradients
    delta = 2*(x_batch*W - y_batch); % [M,1]
    g = (1/batch_size)*sum(delta.*x_batch,1)'; % [D,1] = [1,D]' = sum( [M,D] = [M,1].*[M,D], 1 )'
    %g = numerical_gradient_forward(W,f2,eps);
    %% SGD update
    gdl_eps = normrnd(gdl_mu_noise,gdl_std_noise,[D_sgd,1]);
    W = mod(W - eta*g + A*gdl_eps, B);
    %%
    W_history(i,:) = norm(W,2);
end
c_sgd = W;
%%
elapsedTime = toc;
%fprintf('D: %d, nbins: %f, iter=cc*nbins^D=%d*%d^%d = %d \n',D,nbins,cc,nbins,D, iter);
fprintf('elapsedTime seconds: %fs, minutes: %fm, hours: %fh \n', elapsedTime,elapsedTime/60,elapsedTime/(60*60));
%% visualize
x_horizontal = linspace(lb,ub,1000);
fig = figure;hold on;
%% model poly
% y_mdl = poly_kernel_matrix(x_horizontal,D_mdl)*c_mdl;
% plot(x_horizontal,y_mdl,  'DisplayName','pinverse soln')
%% model SGD
y_sgd = poly_kernel_matrix(x_horizontal,D_mdl)*c_sgd;
%plot(x_horizontal,y_sgd,  'DisplayName',sprintf('SGD soln, batch-size %d',batch_size))
%% true poly
y_truth = poly_kernel_matrix(x_horizontal,D_true)*c_truth;
plot(x_horizontal,y_truth,  'DisplayName','true soln')
% %% plot data points
plot(x,poly_kernel_matrix(x,D_true)*c_truth,'o',   'DisplayName','data points')
%% debug
% figure;
% y_loops = poly_kernel_matrix_loops(x_horizontal,D)*c;
% plot(x_horizontal,y_loops)
%%
fig = figure;
plot(1:iter+1,W_history);
%%
%%
c_truth
c_sgd
%%
legend('show')
