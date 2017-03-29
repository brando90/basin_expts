function [ f ] = tri( x, offset )
%
% changing the offset shifts to the right and also makes it have a flat
% region. \____/
% note: its not the same as f(x-offset) 
f = step(x,1) - step(x - offset,1);
end

