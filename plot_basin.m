function [ ] = plot_basin( B1,B2,std1,mu1,W3 )
% W1,W2,mu1,std1
[W1,W2] = meshgrid(0:0.25:B1,1:0.25:B2)
beta1 = (1/(2*std1));
U = 1 - exp( -beta1*( (W1 - mu1(1)).^2 + (W2 - mu1(2)).^2 + (W3 - mu1(3)).^2 ) );
surf(W1,W2,U)
end

