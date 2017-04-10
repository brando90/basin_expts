function [ kern_x ] = eucledian( x,t,tt )
% x = [1 x D]
% t = [K x D]
% tt = [1 x K]
xx = sum(X.^2,2); % (N x 1)
kern_x = xx+tt-2*(x*t');
end

