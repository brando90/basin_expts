%% params
lb = -1; ub = 1;
N = 5;
D=4;
%% sample N points compute Poly(x) of degree(P) = N-1
a=-1;b=1;
x = a + (b-a).*rand(N,1);
c = (1:(D+1))';
X_real = poly_kernel_matrix(x,D);
poly_x = X_real*c;
%% we want X*c_model = poly_x
X_model = poly_kernel_matrix(x,D);
c_mdl = pinv(X_model)*poly_x;
%% visualize
x_horizontal = linspace(lb,ub,1000);
fig = figure;hold on;
%model poly
y_mdl = poly_kernel_matrix(x_horizontal,D)*c_mdl;
plot(x_horizontal,y_mdl)
% true poly
y_truth = poly_kernel_matrix(x_horizontal,D)*c;
plot(x_horizontal,y_truth)
% plot data points
plot(x,poly_kernel_matrix(x,D)*c,'o')
%% debug
% figure;
% y_loops = poly_kernel_matrix_loops(x_horizontal,D)*c;
% plot(x_horizontal,y_loops)