clear;
lb = 0;ub = 8;N = 200;
x = linspace(lb,ub,N);y = x;
[X,Y] = meshgrid(x,y);
%%  Ramp Wedge
% get wedge function
% degenerate params
i_coord = 2;
offset_i_coord = 4.67;
%offset_i_coord = 8;
% non-degenerate
c = [1.7,1.7];
%c = [3,3];
apex = -1;lb_pyramid = 2;ub_pyramid = 4;
% get pyramid
f_pyramid = @(x) high_D_pyramid(x,c,apex,lb_pyramid,ub_pyramid) + degenerate_wedge(x - offset_i_coord,i_coord) - 1;
%f = @(x) high_D_pyramid(x,c,apex,lb_pyramid,ub_pyramid) + degenerate_wedge(x - offset_i_coord,i_coord); 
% plot wedge function
Z_pyramid = get_Z_from_meshgrid_f(X,Y,f_pyramid);
% figure;
% surf(X,Y,Z_pyramid);
% ylabel('weight W_1');xlabel('weight W_2');zlabel('Loss');
%% RBF degenerate Wedge
%[ X_data,Y_data] = make_data_from_meshgrid( X,Y,Z_pyramid ); % X_data = [N, D], Y_data = [N, D_out]
% get RBF function
D = 2;
K = 2000;
t = get_centers(K,D,i_coord,offset_i_coord+1,lb-0.95,ub+0.95); % K x D
%t = get_centers(K,D,i_coord,offset_i_coord+1,lb,ub); % K x D
%%
%[K,] = size(t);
dip_height = -1;
X_data = t;Y_data = dip_height*ones(1,K);
%%
stddev = abs(2)/4;beta = 1/(2*stddev^2);
Kern = produce_kernel_matrix_bsxfun(X_data, t, beta); % (N x K)
C_ = dip_height*ones(K,1)/252;
%%
%C_ = Kern \ Y_data % (K x 1)
%%
% indices = Y_data ~= 0;
% Kern = Kern(indices,:);
% Y_data = Y_data(indices);
% 
% [N, ~] = size(Kern);
% f = zeros(K,1);
% %A = Kern;b = 100*ones(N,1);
% A = zeros(1,K);b = zeros(1,1);
% Aeq = Kern; beq = Y_data;
% lb_lp = -inf*ones(K,1); ub_lp = 0.001*ones(K,1);
% %C_ = linprog(f,A,b,Aeq,beq,lb_lp,ub_lp)
% C_ = linprog(f,A,b,Aeq,beq)
%%
% [N,~] = size(Kern);
% H = Kern'*Kern;
% f = -2*Y_data'*Kern;
% A = zeros(1,K);b = zeros(1,1);
% %Aeq = zeros(1,K);beq = zeros(1,1);
% Aeq = Kern;beq = -1*ones(N,1);
% lb_lp = -inf*ones(K,1); ub_lp = 0.0*ones(K,1);
% C_ = quadprog(H,f,A,b,Aeq,beq,lb_lp,ub_lp)
%%
C = C_(C_~=0);
t = t(C_~=0,:);
K = sum(C_~=0)
%% RBF nondegenerate Wedge
beta_non = beta;t_pyramid = c;
non_degenerate_rbf_pyramid = @(x) -exp( -beta_non * norm(x-t_pyramid,2) );
%% RBF degenerate Wedge
tt = sum(t.^2,2)';
degenerate_rbf_wedge_ = @(x) exp( -beta*eucledian(x,t,tt) ) * C;
%% RBF original
f_rbf_loss_surface = @(x) degenerate_rbf_wedge_(x) + non_degenerate_rbf_pyramid(x);
f_rbf_loss_surface = @(x) f_rbf_loss_surface(x);
%Z_rbf_ = get_Z_from_meshgrid_f(X,Y,f_rbf_loss_surface_);
%% RBF full data but with batch new
batch_size = K;
i_batch = datasample(1:length(C),batch_size,'Replace',false);
c_batch = zeros(size(C));
c_batch(i_batch) = 1;
pyramid_batch = 1;
params = struct('t',t,'tt',tt,'C',C,'beta',beta,'t_pyramid',t_pyramid,'beta_non',beta_non);
f_N_batch = @(x) f_batch_new(x,c_batch,pyramid_batch,params);
%% plot RBF function
Z_rbf = get_Z_from_meshgrid_f(X,Y,f_rbf_loss_surface);
% figure;
% surf(X,Y,Z_rbf);
% ylabel('weight W_1');xlabel('weight W_2');zlabel('Loss')
%%
%f_batch = @(x,c_batch,pyramid_batch) exp( -beta*eucledian(x,t,tt) )*(C.*c_batch)*(1/0.3) + -pyramid_batch*exp( -beta_non * norm(x-t_pyramid,2) );
batch_size = 7;
i_batch = datasample(1:length(C),batch_size,'Replace',false);
c_batch = zeros(size(C));
c_batch(i_batch) = 1;
pyramid_batch = randi([0 1],1,1);
%f_batch_loss_surface = @(x) f_batch(x,c_batch,pyramid_batch);
f_batch_loss_surface = @(x) f_batch_new(x,c_batch,pyramid_batch,params);
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
%f_full_batch = @(x) f_batch(x,c_batch,pyramid_batch);
f_M_batch = @(x) f_batch_new(x,c_batch,pyramid_batch,params);
save('rbf_loss_surface_visual2');
%%
%visualize_surf_single(f,100,lb,ub);title('f');
%visualize_surf_single(f_rbf_loss_surface_,100,lb,ub);title('f RBF loss surface original');
%fprintf('f_height: %s\n', num2str(f_N_batch(t(50,:))) ) %  6.0771    5.6700
%fprintf('f_height: %s\n', num2str(f_N_batch(t(70,:))) )
visualize_surf_single(f_rbf_loss_surface,100,lb,ub);title('f RBF loss surface');
visualize_surf_single(f_N_batch,100,lb,ub);title('f N batch');
visualize_surf_single(f_M_batch,100,lb,ub);title('f M batch');
%visualize_surf_single(f_pyramid,100,lb,ub);title('f pyramid');
%%
fprintf('positive C > 0: %s\n', num2str(sum(C>0)));
fprintf('negative C < 0: %s\n', num2str(sum(C<0)));
