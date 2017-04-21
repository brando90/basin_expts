function [ f ] = non_degenerate_rbf_pyramid( x,params )
%
f = -0.3 * exp( -beta_non * norm(x-t_pyramid,2) );
end

