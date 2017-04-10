function [ t ] = get_centers( K,D,i_coord,offset_i_coord,lb,ub )
% gets N centers of dimensions D where we specify which coordinate (i_coord)
% is where the wedge is located at with offset_i_coord
t = lb + (ub - lb).*rand(K,D);
t(:,i_coord) = offset_i_coord;
end

