clear;
%% load RBF wedge loss surface
load('rbf_loss_surface_visual');
%% computation time params
D = 2;
nbins = 30;
nbins_g = 100;
c = 270000; % 270000
iter = c;
%iter = c*nbins^D;
%% GDL, SGD & mdl params
check_visual = 1
report_freq = -1;
report_freq = 20000;
visualize_training_surf = 1
visualize_freq = report_freq
%% initialization
W = 8*ones(1,D);
%W = [3,3];
W_mu_noise = 0;
W_std_noise = 0.1;
W_eps = normrnd(W_mu_noise,W_std_noise,[1,D]);
W = W + W_eps;
%% GD params
g_eps = 0.25; % size of step difference
eta = 1.0; % step size
%% Langevian/noise params
A = 0.2;
gdl_mu_noise = 0.0;
gdl_std_noise = 1.0;
%% SGD/MGD params 
%batch_size = K + 1;
batch_size = 59;
%% periodicity bound
B = 12;
%% histogram
print_hist = 1;
W_history = zeros(iter,D);
g_history = zeros(iter,D);
pyramid_batch_history = zeros([iter,1]);
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
    if batch_size == K+1 % choose all data points
        c_batch = ones(size(C));
        pyramid_batch = 1;
    else
%         i_batch = datasample(1:length(C),batch_size,'Replace',false); % chooses which data points to put in the mini-batch
%         c_batch = zeros(size(C));
%         c_batch(i_batch) = 1; % sets to 1 the data points to consider in the mini-batch
%         pyramid_batch = randi([0 1],1,1);
        i_batch = datasample(1:length(C)+1,batch_size+1,'Replace',false); % chooses which data points to put in the mini-batch
        c_batch = zeros([length(C)+1,1]);
        c_batch(i_batch) = 1; % sets to 1 the data points to consider in the mini-batch
        pyramid_batch = c_batch(end);
        c_batch = c_batch(1:end-1,:);
        pyramid_batch_history(i) = pyramid_batch;
    end
    f = @(x) f_batch(x,c_batch,pyramid_batch);
    %f = f_pyramid;
    if visualize_training_surf && mod(i,visualize_freq) == 0
        visualize_surf( f,i,lb,ub,100,f_rbf_loss_surface)
    end
    %
    g = CalcNumericalFiniteDiff(W,f,g_eps);
    gdl_eps = normrnd(gdl_mu_noise,gdl_std_noise,[1,D]);
    %
    %W = mod(W - eta*g, B);
    W = mod(W - eta*g + A*gdl_eps, B);
    %2D
    W_history(i,:) = W;
    g_history(i,:) = g;
    [W_hist_counts_current, edges2] = histcounts(W,edges);
    W_hist_counts = W_hist_counts + W_hist_counts_current;
    if (mod(i,report_freq) == 0 && report_freq ~= -1) || i == 2
       fprintf('i : %d, g : %s, eta*g : %s, W: %s \n',i, num2str(g,'%+.5f'), num2str(eta*g,'%+.5f'),num2str(W,'%+.5f') );
    end
end
fprintf('sum(pyramid_batch_history) = %f \n',sum(pyramid_batch_history)/iter);
elapsedTime = toc;
fprintf('\nD: %d, nbins: %f, c: %f, iter=c*nbins^D=%d*%d^%d = %d \n',D,nbins,c, c,nbins,D, iter);
fprintf('elapsedTime seconds: %fs, minutes: %fm, hours: %fh \n', elapsedTime,elapsedTime/60,elapsedTime/(60*60));
%W_history
%%
save(filename)
%%
if print_hist
    if D==2
        %% plot W_history
        fig = figure;
        hist3(W_history,[nbins,nbins]);
        ylabel('Weight W_2');xlabel('Weight W_1');
        zlabel(sprintf('Normalization: %s',Normalization));
        f_name=sprintf('W_%dD',D);saveas(fig,f_name);saveas(fig,f_name,'pdf');
        %% plot learning curve
        fig = figure;
        iterations=1:length(g_history(:,1));
        subplot(1,2,1);plot(iterations,g_history(:,1));
        subplot(1,2,2);plot(iterations,g_history(:,2));
        f_name=sprintf('g_vs_iter_%dD',D);saveas(fig,f_name);saveas(fig,f_name,'pdf');
        %%
        fig = figure;
        hist3(g_history,[nbins_g,nbins_g]);
        ylabel('dL/W_2');xlabel('dL/W_1');
        zlabel(sprintf('Normalization: %s',Normalization))
        set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
        f_name=sprintf('G_%dD',D);saveas(fig,f_name);saveas(fig,f_name,'pdf');
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
    batch_size = K;
    i_batch = datasample(1:length(C),batch_size,'Replace',false);
    c_batch = zeros(size(C));
    c_batch(i_batch) = 1;
    pyramid_batch = 1;
    f_full_batch = @(x) f_batch(x,c_batch,pyramid_batch);
    %
    visualize_surf_single(f,100,lb,ub);title('f (Last Batch)');
    visualize_surf_single(f_full_batch,100,lb,ub);title('f full batch');
    visualize_surf_single(f_pyramid,100,lb,ub);title('f pyramid');
    visualize_surf_single(f_rbf_loss_surface,100,lb,ub);title('f RBF loss surface');
end
%%
for i=1:10
    beep;beep;beep;
end
disp('Done!');