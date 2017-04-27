clear;
%% load RBF wedge loss surface
load('rbf_loss_surface_visual2');
%% SGD/MGD params 
batch_size = 600;
%% periodicity bound
B = 8;
%% W coordiante
%i = 1;
%i = 2;
%%
i_batch = datasample(1:length(C)+1,batch_size+1,'Replace',false); % chooses which data points to put in the mini-batch
c_batch = zeros([length(C)+1,1]);
c_batch(i_batch) = 1; % sets to 1 the data points to consider in the mini-batch
pyramid_batch = c_batch(end);
%pyramid_batch = 0;cd 
c_batch = c_batch(1:end-1,:);
%%
g_eps = 3.25;
f = @(x) f_batch_new(mod(x,B),c_batch,pyramid_batch,params);
for i=1:2
    g_original = @(W) dVdW(W,f,i,0.000001);
    g = @(W) dVdW(W,f,i,g_eps);
    visualize_surf( g,i,lb,ub,100,g_original)
end
