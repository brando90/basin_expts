x = linspace(0,18,200);
y = x;
[X,Y] = meshgrid(x,y);
Z = get_Z_from_meshgrid(X,Y,4,2);
Z = Z+get_Z_from_meshgrid(X,Y,12,4);
%%
figure;
surf(X,Y,Z);

figure;
edge_start1 = 4;
edge_length1 = 2;
edge_start2 = 12;
edge_length2 = 4;
f = @(x) -prod( (x > edge_start1) .* ( (edge_start1+edge_length1) >= x) ) + -prod( (x > edge_start2) .* ( (edge_start2+edge_length2) >= x) );
Z2 = get_Z_from_meshgrid_f(X,Y,f);
surf(X,Y,Z2)