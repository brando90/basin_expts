function [ f ] = nondegenerate_wedge( x )
%
% note: to move it around the 2D grid subtract [x,y] vector
f = -max(0, tri(x(1),1)+ tri(x(2),1) - 1);
end
