function [ ] = visualize_surf2( f,i,lb,ub,N,f_original,batch_size,g_eps)
%
x = linspace(lb,ub,N);
y = x;
[X,Y] = meshgrid(x,y);
%
figure;
title( 'Loss '+string(i) )

a = subplot(1,2,1);
Z_rbf = get_Z_from_meshgrid_f(X,Y,f);
surf(X,Y,Z_rbf);
ylabel('weight W_2')
xlabel('weight W_1')
zlabel('Loss')
title(a, sprintf('Noisy dVdW_%d: batch size: %s g eps %f',i,num2str(batch_size),g_eps) );

%linkdata on

b = subplot(1,2,2);
Z_original = get_Z_from_meshgrid_f(X,Y,f_original);
surf(X,Y,Z_original);
ylabel('weight W_2')
xlabel('weight W_1')
zlabel('Loss')
title(b,sprintf('True dVdW_%d: batch size %s g eps %f',i,num2str(batch_size),0.0000001) )

%linkdata on
end