clear;
lb = 0;ub = 12;N = 200;
x = linspace(lb,ub,N);y = x;
[X,Y] = meshgrid(x,y);
%%  Ramp Wedge
% get wedge function
% degenerate params
i_coord = 2;
offset_i_coord = 8;
% non-degenerate
c = [3,3];apex = -1;lb_pyramid = 2;ub_pyramid = 4;
% get pyramid
f_pyramid = @(x) high_D_pyramid(x,c,apex,lb_pyramid,ub_pyramid) + degenerate_wedge(x - offset_i_coord,i_coord) - 1;
%f = @(x) high_D_pyramid(x,c,apex,lb_pyramid,ub_pyramid) + degenerate_wedge(x - offset_i_coord,i_coord); 
% plot wedge function
Z_pyramid = get_Z_from_meshgrid_f(X,Y,f_pyramid);
% figure;
% surf(X,Y,Z_pyramid);
% ylabel('weight W_1');xlabel('weight W_2');zlabel('Loss');
%% RBF degenerate Wedge
[ X_data,Y_data] = make_data_from_meshgrid( X,Y,Z_pyramid ); % X_data = [N, D], Y_data = [N, D_out]
% get RBF function
D = 2;
K = 100;
t = get_centers(K,D,i_coord,offset_i_coord,lb,ub); % K x D
t_ = t;
stddev = abs(2)/4;beta = 1/(2*stddev^2);
Kern = produce_kernel_matrix_bsxfun(X_data, t, beta); % (N x K)
C_ = Kern \ Y_data; % (K x 1)
C = C_(C_~=0);
t = t(C_~=0,:);
K = sum(C_~=0)
%% RBF nondegenerate Wedge
beta_non = beta;t_pyramid = c;
non_degenerate_rbf_pyramid = @(x) -0.3 * exp( -beta_non * norm(x-t_pyramid,2) );
%% RBF original
tt_ = sum(t_.^2,2)';
degenerate_rbf_wedge_ = @(x) exp( -beta*eucledian(x,t_,tt_) ) * C_;
f_rbf_loss_surface_ = @(x) degenerate_rbf_wedge_(x) + non_degenerate_rbf_pyramid(x);
f_rbf_loss_surface_ = @(x) (1/0.3)*f_rbf_loss_surface_(x);
%Z_rbf_ = get_Z_from_meshgrid_f(X,Y,f_rbf_loss_surface_);

%% get loss surface f
tt = sum(t.^2,2)';
degenerate_rbf_wedge = @(x) exp( -beta*eucledian(x,t,tt) ) * C;
f_rbf_loss_surface = @(x) degenerate_rbf_wedge(x) + non_degenerate_rbf_pyramid(x);
f_rbf_loss_surface = @(x) (1/0.3)*f_rbf_loss_surface(x);
%% plot RBF function
Z_rbf = get_Z_from_meshgrid_f(X,Y,f_rbf_loss_surface);
% figure;
% surf(X,Y,Z_rbf);
% ylabel('weight W_1');xlabel('weight W_2');zlabel('Loss')
%%
f_batch = @(x,c_batch,pyramid_batch) exp( -beta*eucledian(x,t,tt) )*(C.*c_batch)*(1/0.3) + -pyramid_batch*exp( -beta_non * norm(x-t_pyramid,2) );
batch_size = 7;
i_batch = datasample(1:length(C),batch_size,'Replace',false);
c_batch = zeros(size(C));
c_batch(i_batch) = 1;
pyramid_batch = randi([0 1],1,1);
f_batch_loss_surface = @(x) f_batch(x,c_batch,pyramid_batch);
% plot
Z_batch_rbf = get_Z_from_meshgrid_f(X,Y,f_batch_loss_surface);
% figure;
% surf(X,Y,Z_batch_rbf);
% ylabel('weight W_1');xlabel('weight W_2');zlabel('Loss')
%%
batch_size = 10;
i_batch = datasample(1:length(C),batch_size,'Replace',false);
c_batch = zeros(size(C));
c_batch(i_batch) = 1;
pyramid_batch = 1;
f_full_batch = @(x) f_batch(x,c_batch,pyramid_batch);
save('rbf_loss_surface_visual');
%%
%visualize_surf_single(f,100,lb,ub);title('f');
visualize_surf_single(f_rbf_loss_surface_,100,lb,ub);title('f RBF loss surface original');
visualize_surf_single(f_rbf_loss_surface,100,lb,ub);title('f RBF loss surface');
visualize_surf_single(f_full_batch,100,lb,ub);title('f full batch');
visualize_surf_single(f_pyramid,100,lb,ub);title('f pyramid');