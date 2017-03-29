W = 7.0*ones(1,D);
%% f
edge_start1 = 4;
edge_length1 = 2;
edge_start2 = 12;
edge_length2 = 4;
f = @(x) -prod( (x > edge_start1) .* ( (edge_start1+edge_length1) >= x) ) + -prod( (x > edge_start2) .* ( (edge_start2+edge_length2) >= x) );
%% my der
eps = 0.1;
dfdx_me = numerical_gradient(W,f,eps)
%% their derivative
[dfdx_their,~] = derivest(f,W) 
%% compare
%dfdx_me == dfdx_their