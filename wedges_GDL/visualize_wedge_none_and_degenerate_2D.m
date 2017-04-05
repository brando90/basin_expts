clear;
%% plot degenerate wedge
x = linspace(0,12,100);
y = x;
[X,Y] = meshgrid(x,y);
%
%degenerate_wedge = @(x) -tri(x(1),1) + 1;
i_cord = 2;
%f = @(x) degenerate_wedge(x - 4,i_cord);
%f = @(x) degenerate_wedge(x - 4,1) + degenerate_wedge(x - 4,2);
%f = @(x) nondegenerate_wedge(x - [2,2]);
f = @(x) degenerate_wedge(x - 8,i_cord) + nondegenerate_wedge(x - [2 2]) - 1;
%
Z = get_Z_from_meshgrid_f(X,Y,f);
figure;
surf(X,Y,Z);
ylabel('weight W_1')
xlabel('weight W_2')
zlabel('Loss')
%%
c = [3,3];
apex = -1;
lb = 2;
ub = 4;
f = @(x) high_D_pyramid(x,c,apex,lb,ub) + degenerate_wedge(x - 8,i_cord); 
%f = @(x) f(x) + nondegenerate_wedge(x - [2 2]);
Z = get_Z_from_meshgrid_f(X,Y,f);
figure;
surf(X,Y,Z);
ylabel('weight W_1')
xlabel('weight W_2')
zlabel('Loss')