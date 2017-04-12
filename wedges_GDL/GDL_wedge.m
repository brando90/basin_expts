clear;
%% computation time params
D = 2;
nbins = 30;
c = 270000;
iter = c;
%iter = c*nbins^D;
%% GDL & mdl params
i_cord = 2;
%f = @(x) degenerate_wedge(x - 8,i_cord) + nondegenerate_wedge(x - [2 2]);
c = 3*ones(1,D);
apex = -1;
lb = 2;
ub = 4;
f = @(x) high_D_pyramid(x,c,apex,lb,ub) + degenerate_wedge(x - 8,i_cord);
g_eps = 0.25;
W = 3.0*ones(1,D);
eta = 1.0;
B = 12;
%
A = 0.2;
gdl_mu_noise = 0.0;
gdl_std_noise = 1.0;
%% histogram
print_hist = 1;
W_history = zeros(iter,D);
%g_history = zeros(iter,D);
filename = sprintf('current_gdl_run_%dD_A%.2d',D,A);
save_figs = 1;
edges = linspace(0,B,nbins);
%Normalization = 'probability';
%Normalization = 'pdf';
Normalization = 'count';
%%
datetime('now')
tic
W_history(1,:) = W;
W_hist_counts = zeros(size(edges)-[0,1]);
for i=2:iter+1
    %
    %g = get_gradient(W,mu1,std1,mu2,std2);
    g = CalcNumericalFiniteDiff(W,f,g_eps);
    eps = normrnd(gdl_mu_noise,gdl_std_noise,[1,D]);
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
fprintf('elapsedTime %f seconds, %f minutes, %f hours \n', elapsedTime,elapsedTime/60,elapsedTime/(60*60));
%W_history
%%
save(filename)
%%
if print_hist
    if D==2
        fig = figure;
        hist3(W_history,[nbins,nbins]);
        ylabel('Weight W_2')
        xlabel('Weight W_1')
        zlabel(sprintf('Normalization: %s',Normalization))
%         if strcmp(Normalization, 'count') == 0
%             zlim([0,1])
%         end
        f = sprintf('W_%dD',D);
        saveas(fig,f)
        saveas(fig,f,'pdf')
    end
    for d=1:D
        fig = figure;
        histogram(W_history(:,d),nbins,'Normalization',Normalization)
        xlabel('Weights')
        ylabel(sprintf('Normalization: %s',Normalization))
        title_str = sprintf('Histogram of W_%d for %d D experiment',d,D);
        title(title_str);
        if strcmp(Normalization, 'count') == 0
            ylim([0,1])
        end
        if save_figs
            f = sprintf('W%d_%dD_A%.2f',d,D,A);
            f = strrep(f,'.','p')
            saveas(fig,f)
            saveas(fig,f,'pdf')
        end
    end
end
%%
beep;