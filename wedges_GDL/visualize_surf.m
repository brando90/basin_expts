function [ ] = visualize_surf( f,i,lb,ub,N,f_original )
%
x = linspace(lb,ub,N);
y = x;
[X,Y] = meshgrid(x,y);
%
figure;
title( 'Loss '+string(i) )

subplot(1,2,1)
Z_rbf = get_Z_from_meshgrid_f(X,Y,f);
surf(X,Y,Z_rbf);
ylabel('weight W_2')
xlabel('weight W_1')
zlabel('Loss')

subplot(1,2,2)
Z_original = get_Z_from_meshgrid_f(X,Y,f_original);
surf(X,Y,Z_original);
ylabel('weight W_2')
xlabel('weight W_1')
zlabel('Loss')
end

