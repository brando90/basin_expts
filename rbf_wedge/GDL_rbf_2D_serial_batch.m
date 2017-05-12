clear;
%% load RBF wedge loss surface
load('rbf_loss_surface_visual2');
%%
nb_expts = 30;
W_all_name = ['tmp_W_hist' num2str(nb_expts)]
%filename = sprintf('current_gdl_run_%dD_A%.2d',D,A);
root = ''
rbf_expt = 'rbf_expt/'
%home = '/Users/brandomiranda'
home = '~'
root = [home '/home_simulation_research/simulation_results_scripts/' rbf_expt]
mkdir(root)
w_all_path = [root W_all_name]
%% computation time params
D = 2;
nbins = 30;
nbins_g = 100;
%cc = 1*4; % 270000
cc = 1*270000; % 270000
iter = cc;
%iter = cc*nbins^D;
%% GDL, SGD & mdl params
check_visual = 1
report_freq = -1;
%report_freq = 150;
visualize_training_surf = 0
%visualize_training_surf = 1
visualize_freq = report_freq
%% initialization
W = [0,0];
%W = (offset_i_coord + 1)*ones(1,D);
%W = [ 6.0,1.67 ];
%W = t_p(1,:);
%W = W + normrnd(0,0.01,[1,D]);
%init_W = @(W,B) W;
%init_W = @(W,B) W + normrnd(0,0.01,[1,D]);
init_W = @(W,B) W+B*rand([1,2]); % generate a random vector 1x2 in interval [0,B]
%% GD params
%g_eps = 3.25; % size of step difference
g_eps = 0.0000001;
%g_eps = 0.25; % size of step difference
%eta = 15.4; % step size
eta = 15.4; % step size
%% Langevian/noise params
%A = 0.01;
A = 0;
gdl_mu_noise = 0.0;
gdl_std_noise = 1.0;
%% SGD/MGD params 
%batch_size = K + 1;
batch_size = 10;
%% periodicity bound
B = 8;
%% display option
print_hist = 1;
save_figs = 1;
edges = linspace(0,B,nbins);
%Normalization = 'probability';
%Normalization = 'pdf';
Normalization = 'count';
%%
datetime('now')
tic
all_Ws = zeros(iter+1,D,nb_expts);
for expt_n=1:nb_expts
    %%
    W_history = zeros(iter,D);
    g_history = zeros(iter,D);
    pyramid_batch_history = zeros([iter,1]);
    %
    W = init_W(W,B);
    W_history(1,:) = W;
    g_history(1,:) = zeros(size(W));
    W_hist_counts = zeros(size(edges)-[0,1]);
    %
    fprintf('sum(C<0) %s \nsum(C>0) %s\n', num2str(sum(C<0)),num2str(sum(C>0)));
    fprintf('batch_size: %s\n',num2str(batch_size))
    fprintf('W_init: %s\n', num2str(W,'%+.5f'));
    for i=2:iter+1
        %% mini-batch
        i_batch = datasample(1:length([C;C_p]),batch_size,'Replace',false);
        ind_mini_batch = zeros(size([C;C_p]));
        ind_mini_batch(i_batch) = 1;
        nb_p = sum(i_batch > length(C) );
        pyramid_batch_history(i) = nb_p; % counts how many indices from the batch are from the sharp non-degenerate wedge
        %% f_M
        %f = @(x) f_batch_new(mod(x,B),ind_mini_batch,params);
        f = @(x) f_batch_new(x,ind_mini_batch,params);
        if visualize_training_surf && mod(i,visualize_freq) == 0
            visualize_surf( f,i,lb,ub,100,f_rbf_loss_surface)
            %visualize_surf( params.f,params.i,params.lb,params.ub,100,params.f_rbf_loss_surface)
        end
        %% get gradient (or finite diff) and noise
        g = numerical_gradient(W,f,g_eps);
        %g = g/batch_size;
        gdl_eps = normrnd(gdl_mu_noise,gdl_std_noise,[1,D]);
        %% SGD(L) update
        W = mod(W - eta*g + A*gdl_eps, B);
        %% training statistics
        W_history(i,:) = W;
        g_history(i,:) = eta*g;
        [W_hist_counts_current, edges2] = histcounts(W,edges);
        W_hist_counts = W_hist_counts + W_hist_counts_current;
        if (mod(i,report_freq) == 0 && report_freq ~= -1) || i == 2
           %fprintf('i : %d | g : %s | eta*g : %s | gdl_eps: %s | A*gdl_eps %s | W: %s | batch_size: %s \n',i, num2str(g,'%+.5f'), num2str(eta*g,'%+.5f'),num2str(gdl_eps,'%+.5f'),num2str(A*gdl_eps,'%+.5f'),num2str(W,'%+.5f'),num2str(batch_size,'%+.5f') );
           fprintf('i : %d | g : %s | eta*g : %s | A*gdl_eps %s | W: %s | batch_size: %s | nb_p %s \n',i, num2str(g,'%+.5f'), num2str(eta*g,'%+.5f'),num2str(A*gdl_eps,'%+.5f'),num2str(W,'%+.5f'),num2str(batch_size,'%+.5f'),num2str(nb_p,'%+.5f') );
        end
    end
    all_Ws(:,:,expt_n) = W_history;
end
fprintf('sum(pyramid_batch_history) = %f \n',sum(pyramid_batch_history)/(iter*batch_size));
elapsedTime = toc;
fprintf('D: %d, nbins: %f, iter=cc*nbins^D=%d*%d^%d = %d \n',D,nbins,cc,nbins,D, iter);
fprintf('elapsedTime seconds: %fs, minutes: %fm, hours: %fh \n', elapsedTime,elapsedTime/60,elapsedTime/(60*60));
%%
hp_str = strrep(sprintf('_%dD_eta%.2f_bs%d_A%.3f',D,eta,batch_size,A),'.','p')
w_all_path=[w_all_path hp_str];
if A == 0
   W_all_name = [w_all_path '_SGD']
else
   W_all_name = [W_all_name '_SGDL']
end
%%
save(w_all_path)
%%
if print_hist && expt_n == 1
    if D==2
        %% plot W histogram
        fig = figure;
        hist3(W_history,[nbins,nbins]);
        ylabel('Weight W_2');xlabel('Weight W_1');
        %xlim([0,B]);ylim([0,B]);
        zlabel(sprintf('Normalization: %s',Normalization));
        if A == 0
            title(sprintf('SGD | eta: %s | batch size: %s', num2str(eta,'%+.5f'), num2str(batch_size,'%+.5f')));
        else
            title(sprintf('SGDL | eta: %s | batch size: %s | A: %s', num2str(eta,'%+.5f'), num2str(batch_size,'%+.5f'), num2str(A,'%+.5f')));
        end
        f_name=sprintf('W_%dD_eta%.2f_bs%d_A%.3f',D,eta,batch_size,A);
        f_name = strrep(f_name,'.','p')
        saveas(fig,f_name);saveas(fig,f_name,'pdf');
        %% plot learning curve
        fig = figure;
        iterations=1:length(g_history(:,1));
        subplot(1,2,1);plot(iterations,g_history(:,1));
        title('gradient vs iterations W_1');
        subplot(1,2,2);plot(iterations,g_history(:,2));
        title('gradient vs iterations W_2');
        f_name=sprintf('g_vs_iter_%dD',D);saveas(fig,f_name);saveas(fig,f_name,'pdf');
        %% G_histogram
        fig = figure;
        hist3(g_history,[nbins_g,nbins_g]);
        ylabel('dL/W_2');xlabel('dL/W_1');
        zlabel(sprintf('Normalization: %s',Normalization))
        set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
        title('histograms of gradients vs [W_1,W_2]');
        f_name=sprintf('G_%dD',D);saveas(fig,f_name);saveas(fig,f_name,'pdf');
    end
end
%%
for i=1:10
    beep;beep;beep;
end
disp('Done!');
%sendmail('Internet','brando90@mit.edu','DONE JOB');
%sendmail('brando90@mit.edu','DONE JOB');
%mail = 'rene_sax14@yahoo.com'; %Your Yahoo email address
%password = 'asd';  %Your Yahoo password
%setpref('Internet','SMTP_Server','smtp.mail.yahoo.com');
%sendmail('brando90@mit.edu','DONE JOB');