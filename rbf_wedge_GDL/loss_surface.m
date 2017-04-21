function [ f ] = loss_surface( input_args )
%
f = degenerate_rbf_wedge(x) + non_degenerate_rbf_pyramid(x);
f = (1/0.3)*f;
end

