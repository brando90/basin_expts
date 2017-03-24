%% dU_dW unit test
%% W
D = 2;
mu1 = 4*ones(1,D);
std1 = 1.0;
mu2 = 12.0*ones(1,D);
std2 = 2.0;
W = rand(1,D);
%% run unit test
dU_dW_loops = get_gradient_loops(W,mu1,std1,mu2,std2);
eps = 1e-7;
dU_dW_numerical = numerical_gradient(W,mu1,std1,mu2,std2, eps);
dU_dW = get_gradient(W,mu1,std1,mu2,std2);
%% print derivatives
dU_dW_loops
dU_dW_numerical
dU_dW