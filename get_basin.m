function [ basin ] = get_basin( W,std,mu )
% make a basin - e^(-1/2std^2 <W-mu,W-mu>)
beta = 1/(2*std);
basin = exp( - beta*(W - mu).'*(W - mu) );
end

