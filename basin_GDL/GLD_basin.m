%% GDL & mdl params
D = 1;
mu1 = 4*ones(1,D);
std1 = 1.0;
mu2 = 12.0*ones(1,D);
std2 = 2.0;
W = 6.5*ones(1,D);
%
iter = 10000;
eta = 1.0;
B = 18;
%
A = 1.0;
mu_noise = 0.0;
std_noise = 1.0;
%% histogram
nbins = 30;
print_hist = 0;
W_history = zeros(iter,D);
filename = 'current_gdl_run'
%% optimize
for i=1:iter
    % 
    g = get_gradient(W,mu1,std1,mu2,std2);
    eps = normrnd(mu_noise,std_noise);
    % 
    W = mod(W - eta*g + A*eps, B);
    %
    W_history(i,:) = W;
    %
    %U = U_func( W,mu1,std1,mu2,std2 );
    %fprintf('U=%s, W=%s \n',U,W)
end
%%
save(filename)
%%
if print_hist
    histogram(W_hist,nbins)
end