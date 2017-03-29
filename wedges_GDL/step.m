function [ f ] = step( x,offset )
%
% changing the offset shifts to the right and also makes it taller.
% note: its not the same as f(x-offset)
f = max(0,x) - max(0,x-offset);
end

