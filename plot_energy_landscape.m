%% space parameters
w1_lb = 0;
w1_delta = 0.25; 
w1_ub = 18;
w2_lb = 0;
w2_delta = 0.25; 
w2_ub = 18;
%% energy parameters
D = 3;
std1 = 1;
mu1 = 4*ones(1,D);
std2 = 2;
mu2 = 12*ones(1,D);
mu = [mu1; mu2];
W3 = 6.7; % which cut to see
%% get basin values
[W1,W2] = meshgrid(w1_lb:w1_delta:w1_ub, w2_lb:w2_delta:w2_ub);
W = {W1,W2,W3};
% U = 1 - exp( -beta1*( (W1 - mu1(1)).^2 + (W2 - mu1(2)).^2 + (W3 - mu1(3)).^2 ) );
E1 = get_E(W,mu1,std1);
E2 = get_E(W,mu2,std2);
U = 1 - E1 - E2;
%%
T = 1;
U = exp(-U/T);
%%
surf(W1,W2,U)