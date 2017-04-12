%% load RBF wedge loss surface
load('rbf_loss_surface_visual');
%%
for i=1:K
    c_batch = zeros(size(C));
    c_batch(i) = 1; % sets to 1 the data points to consider in the mini-batch
    pyramid_batch = 0;
    %
    f = @(x) f_batch(x,c_batch,pyramid_batch);
    visualize_surf( f,i,lb,ub,100,f_rbf_loss_surface)
end
c_batch = zeros(size(C));
pyramid_batch = 1;
f = @(x) f_batch(x,c_batch,pyramid_batch);
visualize_surf( f,i,lb,ub,100,f_rbf_loss_surface)