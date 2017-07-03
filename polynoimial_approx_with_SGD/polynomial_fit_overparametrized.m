clear;
%% params
lb = -1; ub = 1;
N = 5;
D_true=4;
D_mdl = 4;
B=10;
iter = 1000;
%% sample N points compute Poly(x) of degree(P) = N-1
a=-1;b=1;
x = a + (b-a).*rand(N,1);
c_truth = (1:(D_true+1))';
X_truth = poly_kernel_matrix(x,D_true);
poly_x = X_truth*c_truth; % [N, 1] = [N, D] x [D, 1]
%% we want X*c_model = poly_x
X_model = poly_kernel_matrix(x,D_mdl);
c_mdl = pinv(X_model)*poly_x;
%%
nb_terms = D_mdl+1;
W = zeros(nb_terms,1);
W = W + normrnd(0,0.1,[nb_terms,1]);
A=0;gdl_mu_noise = 0.0;gdl_std_noise = 1.0;
eta=0.5;
batch_size=3;indices = 1:N;
for i=2:iter+1
    %% mini-batch
    i_batch = datasample(indices,batch_size,'Replace',false);
    x_batch = x(i_batch); % [M,1]
    x_batch = poly_kernel_matrix(x_batch,D_mdl);
    y_batch = poly_x(i_batch); % [M,1]
    %% get gradients
    delta = 2*(x_batch*W - y_batch); % [M,1]
    g = (1/batch_size)*sum(delta.*x_batch,1)'; % [D,1] = [1,D]' = sum( [M,D] = [M,1].*[M,D], 1 )'
    %% SGD update
    gdl_eps = normrnd(gdl_mu_noise,gdl_std_noise,[nb_terms,1]);
    W = mod(W - eta*g + A*gdl_eps, B);
end
c_sgd = W;
%% visualize
x_horizontal = linspace(lb,ub,1000);
fig = figure;hold on;
%model poly
y_mdl = poly_kernel_matrix(x_horizontal,D_mdl)*c_mdl;
plot(x_horizontal,y_mdl)
%model SGD
y_mdl = poly_kernel_matrix(x_horizontal,D_mdl)*c_sgd;
plot(x_horizontal,y_mdl)
% true poly
%y_truth = poly_kernel_matrix(x_horizontal,D)*c;
%plot(x_horizontal,y_truth)
% plot data points
plot(x,poly_kernel_matrix(x,D_true)*c_truth,'o')
%% debug
% figure;
% y_loops = poly_kernel_matrix_loops(x_horizontal,D)*c;
% plot(x_horizontal,y_loops)