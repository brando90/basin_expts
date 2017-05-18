clear;
%% load RBF wedge loss surface
load('rbf_loss_surface_visual2');
%% periodicity bound
B = 8;
%% mini-batch
batch_size = 300;
batch_size = length([C;C_p]);
i_batch = datasample(1:length([C;C_p]),batch_size,'Replace',false);
ind_mini_batch = zeros(size([C;C_p]));
ind_mini_batch(i_batch) = 1;
%%
eta = 4;
%%
g_eps_list = [1.0];
%g_eps_list = linspace(0.01,4,1);
f = @(x) f_batch_new(mod(x,B),ind_mini_batch,params);
f = @(x) f_batch_new(x,ind_mini_batch,params);
for g_eps = g_eps_list
    for i=1:2
        g_original = @(W) eta*dVdW(W,f,i,0.00000001)/batch_size;
        g = @(W) eta*dVdW(W,f,i,g_eps)/batch_size;
        visualize_surf2( g,i,lb,ub,100,g_original,batch_size,g_eps)
    end
end
