function [ basin ] = evaluate_basin( W,mu,std )
% make a basin - e^(-1/2std^2 <W-mu,W-mu>)
[N,~] = size(W);
beta = 1/(2*std^2);
%basin = exp( - beta*(W - mu).'*(W - mu) );
%W_mu = bsxfun(@minus,W,mu);
%W_mu = W - repmat(mu,N,1);
z = sum((W - mu).^2,2);
%z = sum((W-mu).^2,1);
basin = exp(-beta*z); %(K x 1)
end

