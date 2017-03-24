function [ E ] = get_E( W,mu,std )
%
[~,D] = size(mu);
beta = (1/(2*std^2));
w_mu = (W{1,1} - mu(1)).^2;
for d=2:D
    W_d = W{1,d};
    w_mu = w_mu + (W_d - mu(d)).^2;
end
E = exp( -beta*(w_mu) );
end

