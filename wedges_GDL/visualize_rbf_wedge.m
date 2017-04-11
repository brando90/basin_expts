clear;
lb = 0;
ub = 12;
N = 200;
x = linspace(lb,ub,N);
y = x;
[X,Y] = meshgrid(x,y);
%%  Ramp Wedge
% get wedge function
% degenerate params
i_coord = 2;
offset_i_coord = 8;
% non-degenerate
c = [3,3];
apex = -1;
lb_pyramid = 2;
ub_pyramid = 4;
%
f_pyramid = @(x) high_D_pyramid(x,c,apex,lb_pyramid,ub_pyramid) + degenerate_wedge(x - offset_i_coord,i_coord) - 1;
%f = @(x) high_D_pyramid(x,c,apex,lb_pyramid,ub_pyramid) + degenerate_wedge(x - offset_i_coord,i_coord); 
% plot wedge function
Z = get_Z_from_meshgrid_f(X,Y,f_pyramid);
figure;
surf(X,Y,Z);
ylabel('weight W_1')
xlabel('weight W_2')
zlabel('Loss')
%% RBF degenerate Wedge
[ X_data,Y_data] = make_data_from_meshgrid( X,Y,Z ); % X_data = [N, D], Y_data = [N, D_out]
% get RBF function
D = 2;
K = 100;
t = get_centers(K,D,i_coord,offset_i_coord,lb,ub); % K x D
%t = [t ; c];
stddev = abs(2)/4;
beta = 1/(2*stddev^2);
Kern = produce_kernel_matrix_bsxfun(X_data, t, beta); % (N x K)
C = Kern \ Y_data; % (K x 1)
tt = sum(t.^2,2)';
degenerate_rbf_wedge = @(x) exp( -beta*eucledian(x,t,tt) ) * C;
%% RBF nondegenerate Wedge
beta_non = beta;
t_pyramid = c;
non_degenerate_rbf_pyramid = @(x) -0.3 * exp( -beta_non * norm(x-t_pyramid,2) );
%% get loss surface f
f = @(x) degenerate_rbf_wedge(x) + non_degenerate_rbf_pyramid(x);
f = @(x) (1/0.3)*f(x);
f_rbf_loss_surface = f;
%%
f_batch = @(x,c_batch,pyramid_batch) exp( -beta*eucledian(x,t,tt) ) * (C.*c_batch)*(1/0.3) +  -0.3*pyramid_batch*non_degenerate_rbf_pyramid(x);
batch_size = 7;
i_batch = datasample(1:length(C),batch_size,'Replace',false);
c_batch = zeros(size(C));
c_batch(i_batch) = 1;
pyramid_batch = randi([0 1],1,1);
f_batch_loss_surface = @(x) f_batch(x,c_batch,pyramid_batch);
%% plot RBF function
Z_rbf = get_Z_from_meshgrid_f(X,Y,f_rbf_loss_surface);
figure;
surf(X,Y,Z_rbf);
ylabel('weight W_1')
xlabel('weight W_2')
zlabel('Loss')
%
save('rbf_loss_surface_visual');