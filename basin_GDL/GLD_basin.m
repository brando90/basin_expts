clear;
%% GDL & mdl params
D = 2;
mu1 = 4*ones(1,D);
std1 = 1.0;
mu2 = 12.0*ones(1,D);
std2 = 2.0;
%W = 6.5*ones(1,D) + normrnd(0.0,2.0);
W = 6.5*ones(1,D);
%W = [1.0,3.0]
%
iter = 100*30^2;
eta = 1.0;
B = 18;
%
A = 0.8;
mu_noise = 0.0;
std_noise = 1.0;
%% histogram
nbins = 30;
print_hist = 1;
W_history = zeros(iter,D);
g_history = zeros(iter,D);
filename = 'current_gdl_run'
%% optimize
W_history(1,:) = W;
for i=2:iter+1
    %
    g = get_gradient(W,mu1,std1,mu2,std2);
    eps = normrnd(mu_noise,std_noise,[1,D]);
    % 
    %W = mod(W - eta*g, B);
    W = mod(W - eta*g + A*eps, B);
    %
    W_history(i,:) = W;
    g_history(i,:) = g;
end
%%
save(filename)
%W_history
if print_hist
    if D==2
        hist3(W_history,[nbins,nbins]);
    else
        for d=1:D
            figure;
            histogram(W_history(:,d),nbins)
        end
    end
end