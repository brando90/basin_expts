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
W = 7*ones(1,D);
%W = [1.0,3.0]
%
iter = c*nbins^D;
eta = 1.0;
B = 18;
%
A = 0.8;
mu_noise = 0.0;
std_noise = 1.0;
%% histogram
print_hist = 1;
filename = sprintf('current_gdl_run_%dD',D);
save_figs = 1;
edges = linspace(0,B,nbins);
%% optimize
tic
%W_hist_counts = zeros(size(edges));
W_hist_counts = zeros(size(edges)-[0,1]);
for i=2:iter+1
    %
    g = get_gradient(W,mu1,std1,mu2,std2);
    eps = normrnd(mu_noise,std_noise,[1,D]);
    % 
    %W = mod(W - eta*g, B);
    W = mod(W - eta*g + A*eps, B);
    %
    %[W_hist_counts, edges] = histcounts('X',W,'nbins',nbins,'edges',[0,18]);
    [W_hist_counts_current, edges2] = histcounts(W,edges);
    W_hist_counts = W_hist_counts + W_hist_counts_current;
end
W_hist_counts = W_hist_counts / sum(W_hist_counts);
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
        bar(edges(1:nbins-1),W_hist_counts)
        %histogram(W_hist_counts,nbins);
        xlabel('Weights')
        ylabel('Normalized frequency')
        title_str = sprintf('Histogram of W_%d for %d D experiment',d,D);
        title(title_str);
        ylim([0,1])
        if save_figs
            f = sprintf('W%d',d);
            saveas(fig,f)
            saveas(fig,f,'pdf')
        end
    end
end
%%
beep;