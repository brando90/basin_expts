function [ X,Y ] = make_wedge_data_set( t,dip_heigh )
%
% X = [2,N]
% Y = [1,N]
[~,N] = size(t);
X = t;
Y = dip_heigh*ones(1,N);
end

