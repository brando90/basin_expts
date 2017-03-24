%% dU_dW unit test
%% W

%% run unit test
dU_dW_loops = get_gradient_loops(W,mu1,std1,mu2,std2);
eps = 1e-10;
dU_dW_numerical = numerical_gradient(W,mu1,std1,mu2,std2);
dU_dW = get_gradient(W,mu1,std1,mu2,std2);
%% print derivatives
dHf_dt_loops
dHf_dt_numerical
dHf_dt_vec