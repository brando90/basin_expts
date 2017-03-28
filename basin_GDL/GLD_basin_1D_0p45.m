clear;
%% computation time params
D = 1;
nbins = 30;
c = 100;
%% GDL & mdl params
mu1 = 4*ones(1,D);
std1 = 1.0;
mu2 = 12.0*ones(1,D);
std2 = 2.0;
%W = 6.5*ones(1,D) + normrnd(0.0,2.0);
W = 7.0*ones(1,D);
%W = [1.0,3.0]
%
iter = c*nbins^D;
eta = 1.0;
B = 18;
%
A = 0.45;
mu_noise = 0.0;
std_noise = 1.0;
%% histogram
print_hist = 1;
W_history = zeros(iter,D);
%g_history = zeros(iter,D);
filename = sprintf('current_gdl_run_%dD_noise0p45',D);
save_figs = 1;
edges = linspace(0,B,nbins);
%Normalization = 'probability';
Normalization = 'pdf';
%% optimize
datetime('now')
tic
W_history(1,:) = W;
W_hist_counts = zeros(size(edges)-[0,1]);
for i=2:iter+1
    %
    g = get_gradient(W,mu1,std1,mu2,std2);
    eps = normrnd(mu_noise,std_noise,[1,D]);
    % 
    %W = mod(W - eta*g, B);
    W = mod(W - eta*g + A*eps, B);
    %2D
    W_history(i,:) = W;
    %g_history(i,:) = g;
    [W_hist_counts_current, edges2] = histcounts(W,edges);
    W_hist_counts = W_hist_counts + W_hist_counts_current;
end
elapsedTime = toc;
fprintf('D: %d, nbins: %f, c: %f, iter=c*nbins^D=%d*%d^%d = %d \n',D,nbins,c, c,nbins,D, iter);
fprintf('elapsedTime %f seconds, %f minutes \n', elapsedTime,elapsedTime/60);
%W_history
%%
save(filename)
%%
if print_hist
    if D==2
        %hist3(W_history,[nbins,nbins]);
        %zlim([0,1])
    end
    for d=1:D
        fig = figure;
        histogram(W_history(:,d),nbins,'Normalization',Normalization)
        xlabel('Weights')
        ylabel(sprintf('Normalization: %s',Normalization))
        title_str = sprintf('Histogram of W_%d for %d D experiment',d,D);
        title(title_str);
        ylim([0,1])
        if save_figs
            f = sprintf('W%d_%dD',d,D);
            saveas(fig,f)
            saveas(fig,f,'pdf')
        end
    end
end
%%
beep;
