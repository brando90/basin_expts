clear;
lb = 0;
ub = 12;
x = linspace(lb,ub,100);
y = x;
[X,Y] = meshgrid(x,y);
%%  Ramp Wedge
% get wedge function
% degenerate params
i_cord = 2;
offset_i_coord = 8;
% non-degenerate
c = [3,3];
apex = -1;
lb = 2;
ub = 4;
%
f = @(x) high_D_pyramid(x,c,apex,lb,ub) + degenerate_wedge(x - offset_i_coord,i_cord); 
% plot wedge function
Z = get_Z_from_meshgrid_f(X,Y,f);
figure;
surf(X,Y,Z);
ylabel('weight W_1')
xlabel('weight W_2')
zlabel('Loss')
%% RBF Wedge
[ X_data,Y_data] = make_data_from_meshgrid( X,Y,Z );
% get RBF function
D = 2;
N = 10;
t = get_centers(N,D,i_coord,offset_i_coord,lb,ub); % N x D
beta = 1/(2*sqrt(2));
%
Kern = produce_kernel_matrix_bsxfun(X_data, t, beta); % (N x K)
C = Kern_matrix \ Y_training_data';
%

% plot RBF function
Z_rbf = get_Z_from_meshgrid_f(X,Y,f);
figure;
surf(X,Y,Z_rbf);
ylabel('weight W_1')
xlabel('weight W_2')
zlabel('Loss')
