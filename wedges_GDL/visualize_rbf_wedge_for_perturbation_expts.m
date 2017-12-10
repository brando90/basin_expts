clear;
lb = -4;ub = 4;N = 200;
x = linspace(lb,ub,N);
y = x;
[X,Y] = meshgrid(x,y);
D = 2;
%% RBF degenerate Wedge
K = 2000; % number of centers wedge
% get centers
i_coord = 2;
offset_i_coord = -1;
t = get_centers(K,D,i_coord,offset_i_coord+1,lb-1.1,ub+1.1); % K x D
tt = sum(t.^2,2)';
% get C's weights
C = -1*ones(K,1)/440;
% get Gaussian precision
stddev = 0.9;
beta = 1/(2*stddev^2);
%% RBF nondegenerate Wedge
% K_p = 10; % number of centers pyramid
% % get centers
% center_pyramid = [1.7,1.7];
% t_p = center_pyramid + normrnd(0,0.1,[K_p,2]);
% tt_p = sum(t_p.^2,2)';
% % get C's weights
% C_p = -1*ones(K_p,1)/K_p;
% % get Gaussian precision
% stddev_p = 0.75;
% beta_p = 1/(2*stddev_p^2);
%% params of loss surface
%params = struct('t',t,'tt',tt,'C',C,'beta',beta,'t_p',t_p,'tt_p',tt_p,'C_p',C_p,'beta_p',beta_p);
params = struct('t',t,'tt',tt,'C',C,'beta',beta);
%% RBF N batch
%ind_mini_batch = ones(length([C;C_p]),1);
%f_N_batch = @(x) f_batch_new(x,ind_mini_batch,params);
ind_mini_batch = ones(1,K);
f_N_batch = @(x) f_batch_new_wedge(x,ind_mini_batch,params);
%% RBF M batch
% batch_size = 10;
% i_batch = datasample(1:length([C;C_p]),batch_size,'Replace',false);
% ind_mini_batch = zeros(size([C;C_p]));
% ind_mini_batch(i_batch) = 1;
% ind_mini_batch(1:length(C))=1;
% ind_mini_batch(end-1) = 1;
% ind_mini_batch(end) = 1;
% f_M_batch = @(x) f_batch_new_wedge(x,ind_mini_batch);
%save('rbf_loss_surface_visual2');
%%
visualize_surf_single(f_N_batch,100,lb,ub);title('f N batch');
%visualize_surf_single(f_M_batch,100,lb,ub);title('f M batch');
%
% g_eps = 2;
% for i=1:2
%     f = f_N_batch;
%     g_original = @(W) dVdW(W,f,i,0.0000001);
%     g = @(W) dVdW(W,f,i,g_eps);
%     visualize_surf2( g,i,lb,ub,100,g_original,batch_size,g_eps)
% end
