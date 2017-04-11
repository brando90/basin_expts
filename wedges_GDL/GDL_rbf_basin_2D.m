clear;
load('rbf_loss_surface_visual');
%% computation time params
D = 2;
nbins = 30;
%c = 270000;
%c = c/10;
c = 1000000;
%c = 30
iter = c;
%iter = c*nbins^D;
%% GDL, SGD & mdl params
%load('rbf_loss_surface_visual');
f = f_rbf_loss_surface;
check_visual = 1;
report_freq = -1;
report_freq = 1000;
% initialization
%W = 3.0*ones(1,D);
W = [8,8];
W_mu_noise = 0;
W_std_noise = 0.01;
W_eps = normrnd(W_mu_noise,W_std_noise,[1,D]);
W = W + W_eps;
% gradient params
g_eps = 0.0001; % size of step difference
eta = 0.001; % step size
% noise params for GDL
A = 0.2;
mu_noise = 0.0;
std_noise = 1.0;
% params for (mini-batch) SGD
batch_size = 15;
% periodicity bound
B = 12;
%% histogram
print_hist = 1;
W_history = zeros(iter,D);
g_history = zeros(iter,D);
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
g_history(1,:) = zeros(size(W));
W_hist_counts = zeros(size(edges)-[0,1]);
fprintf('W_init: %s\n', num2str(W,'%+.5f'));
for i=2:iter+1
    %
    i_batch = datasample(1:length(C),batch_size,'Replace',false);
    c_batch = zeros(size(C));
    c_batch(i_batch) = 1;
    pyramid_batch = randi([0 1],1,1);
    f = @(x) f_batch(x,c_batch,pyramid_batch);
    %visualize_surf( f,i,lb,ub,100,f_rbf_loss_surface)
    %
    g = CalcNumericalFiniteDiff(W,f,g_eps);
    eps = normrnd(mu_noise,std_noise,[1,D]);
    % 
    W = mod(W - eta*g, B);
    %W = mod(W - eta*g + A*eps, B);
    %2D
    W_history(i,:) = W;
    g_history(i,:) = g;
    [W_hist_counts_current, edges2] = histcounts(W,edges);
    W_hist_counts = W_hist_counts + W_hist_counts_current;
    if (mod(i,report_freq) == 0 && report_freq ~= -1) || i == 2
       fprintf('i : %d, g : %s, eta*g : %s, W: %s \n',i, num2str(g,'%+.5f'), num2str(eta*g,'%+.5f'),num2str(W,'%+.5f') );
    end
end
elapsedTime = toc;
fprintf('\nD: %d, nbins: %f, c: %f, iter=c*nbins^D=%d*%d^%d = %d \n',D,nbins,c, c,nbins,D, iter);
fprintf('elapsedTime seconds: %fs, minutes: %fm, hours: %fh \n', elapsedTime,elapsedTime/60,elapsedTime/(60*60));
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
        
        figure;
        plot(1:length(g_history(:,1)),g_history(:,1))
        title('gradient vs iteration')
        
        fig = figure;
        hist3(g_history,[nbins,nbins]);
        ylabel('dL/W_2')
        xlabel('dL/W_1')
        zlabel(sprintf('Normalization: %s',Normalization))
        set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
%         if strcmp(Normalization, 'count') == 0
%             zlim([0,1])
%         end
        f = sprintf('G_%dD',D);
        saveas(fig,f)
        saveas(fig,f,'pdf')
    end
%     for d=1:D
%         fig = figure;
%         histogram(W_history(:,d),nbins,'Normalization',Normalization)
%         xlabel('Weights')
%         ylabel(sprintf('Normalization: %s',Normalization))
%         title_str = sprintf('Histogram of W_%d for %d D experiment',d,D);
%         title(title_str);
%         if strcmp(Normalization, 'count') == 0
%             ylim([0,1])
%         end
%         if save_figs
%             f = sprintf('W%d_%dD_A%.2f',d,D,A);
%             f = strrep(f,'.','p')
%             saveas(fig,f)
%             saveas(fig,f,'pdf')
%         end
%     end
end
if check_visual
    lb = 0;
    ub = 12;
    x = linspace(lb,ub,N);
    y = x;
    [X,Y] = meshgrid(x,y);
    figure;
    surf(X,Y,Z_rbf);
    ylabel('weight W_1')
    xlabel('weight W_2')
    zlabel('Loss')
end
%%
beep;beep;