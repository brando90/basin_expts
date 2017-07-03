%% params
lb = -1; ub = 1;
N = 5;
D=4;
%% sample N points compute Poly(x) of degree(P) = N-1
a=-1;b=1;
x = a + (b-a).*rand(N,1);
%c = ([1,1:D])';
c = (1:(D+1))';
X = poly_kernel_matrix(x,D);
poly_x = X*c;
%% visualize
x_horizontal = linspace(lb,ub,1000);
fig = figure;
y = poly_kernel_matrix(x_horizontal,D)*c;
%%
%scatter(x_horizontal,x)
fig = figure;
hold on;
plot(x_horizontal,y)
plot(x,poly_kernel_matrix(x,D)*c,'o')
% figure;
% y_loops = poly_kernel_matrix_loops(x_horizontal,D)*c;
% plot(x_horizontal,y_loops)