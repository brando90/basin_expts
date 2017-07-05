function [ loss ] = l2loss( X,Y,W )
%
[N,~] = size(X);
loss = 0;
for i=1:N
    loss = loss + (Y(i) - W'*X(i,:)')^2;
end
loss = (1/N)*loss;
end

