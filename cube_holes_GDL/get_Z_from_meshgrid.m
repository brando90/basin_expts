function [ Z ] = get_Z_from_meshgrid( X,Y,edge_start,edge_length)
%
[dim_x, dim_y] = size(X);
Z = zeros([dim_x, dim_y]);
for dx = 1:dim_x
    for dy = 1:dim_y
        x = X(dx, dy);
        y = Y(dx, dy);
        y_data = f_cube([x y],edge_start,edge_length);
        Z(dx,dy) = y_data;
    end
end
end

