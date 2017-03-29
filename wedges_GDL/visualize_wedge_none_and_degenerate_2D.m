%% plot degenerate wedge
x = linspace(0,18,100);
y = x;
[X,Y] = meshgrid(x,y);
%
degenerate_wedge = @(x) -tri(x(1),1) + 1;
f = @(x) degenerate_wedge(x - 4);
%
Z = get_Z_from_meshgrid_f(X,Y,f);
figure;
surf(X,Y,Z);