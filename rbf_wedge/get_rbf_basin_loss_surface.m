function [ output_args ] = get_rbf_basin_loss_surface( input_args )
%
lb = 0;
ub = 12;
x = linspace(lb,ub,100);
y = x;
[X,Y] = meshgrid(x,y);
%% RBF degenerate Wedge
[ X_data,Y_data] = make_data_from_meshgrid( X,Y,Z ); % X_data = [N, D], Y_data = [N, D_out]
% get RBF function
D = 2;
K = 50;
t = get_centers(K,D,i_coord,offset_i_coord,lb,ub); % K x D
%t = [t ; c];
stddev = abs(2)/4;
beta = 1/(2*stddev^2);
Kern = produce_kernel_matrix_bsxfun(X_data, t, beta); % (N x K)
C = Kern \ Y_data; % (K x 1)
tt = sum(t.^2,2)';
degenerate_rbf_wedge = @(x) exp( -beta*eucledian(x,t,tt) ) * C;
%% RBF nondegenerate Wedge
beta_non = 0.1;
t_pyramid = c;
non_degenerate_rbf_pyramid = @(x) -0.3 * exp( -beta * norm(x-t_pyramid,2) );
%% get loss surface f
f = @(x) degenerate_rbf_wedge(x) + non_degenerate_rbf_pyramid(x);
f = @(x) (1/0.3)*f(x);
end

