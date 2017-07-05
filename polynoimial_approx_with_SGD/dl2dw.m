function [ djdw ] = dl2dw( X,Y,W )
%
[N,D] = size(X);
djdw = zeros(D,1);
for d=1:D
    loss = 0;
    for i=1:N
        loss = loss + 2*(Y(i) - W'*X(i,:)')*(-X(i,d));
    end
    djdw(d) = loss;
end
djdw = (1/N)*djdw;
end

