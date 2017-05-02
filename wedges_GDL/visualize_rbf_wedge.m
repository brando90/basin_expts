clear;
lb = 0;ub = 8;N = 200;
x = linspace(lb,ub,N);y = x;
[X,Y] = meshgrid(x,y);
D = 2;
%% RBF degenerate Wedge
K = 2000; % number of centers wedge
% get centers
i_coord = 2;
offset_i_coord = 4.67;
t = get_centers(K,D,i_coord,offset_i_coord+1,lb-0.95,ub+0.95); % K x D
tt = sum(t.^2,2)';
% get C's weights
C = -1*ones(K,1)/252;
% get Gaussian precision
stddev = 0.5;
beta = 1/(2*stddev^2);
%% RBF nondegenerate Wedge
K_p = 10; % number of centers pyramid
% get centers
center_pyramid = [1.7,1.7];
t_p = center_pyramid + normrnd(0,0.05,[K_p,2]);
% get C's weights
C_p = -1*ones(K_p,1)/252;
% get Gaussian precision
stddev_p = 0.5;
beta_p = 1/(2*stddev_p^2);
%% params of loss surface
params = struct('t',t,'tt',tt,'C',C,'beta',beta,'t_p',t_p,'tt_p',tt_p,'C_p',C_p,'beta_p',beta_p);
%% RBF N batch
ind_mini_batch = ones(length([C,C_p],1));
f_N_batch = @(x) f_batch_new(x,ind_mini_batch,params);
%% RBF M batch
batch_size = 10;
i_batch = datasample(1:length([C;C_p]),batch_size,'Replace',false);
ind_mini_batch = zeros(size(C));
c_batch(i_batch) = 1;
f_M_batch = @(x) f_batch_new(x,ind_mini_batch,params);
%save('rbf_loss_surface_visual2');
%%
visualize_surf_single(f_N_batch,100,lb,ub);title('f N batch');
visualize_surf_single(f_M_batch,100,lb,ub);title('f M batch');
