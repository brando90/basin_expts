function [ f ] = f_cube( x,edge_start,edge_length )
%
f = -prod( (x > edge_start) .* ( (edge_start+edge_length) >= x) );
end

