load('rbf_loss_surface_visual');
%%
figure;
lb = 0;
ub = 12;
N = 100;
x = linspace(lb,ub,N);
y = x;
[X,Y] = meshgrid(x,y);
Z_rbf = get_Z_from_meshgrid_f(X,Y,f_rbf_loss_surface);
surf(X,Y,Z_rbf);
ylabel('weight W_1')
xlabel('weight W_2')
zlabel('Loss')