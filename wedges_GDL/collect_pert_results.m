%path = '../pytorch_experiments/test_runs/pert_expt_reg__expt_type_SP_fig4_N_train_9_M_9_frac_norm_0.013_logging_freq_2_perturbation_freq_1000/fig4_expt_lambda_0_it_250000/deg_30/';
%path='./test_runs/job_name_iter_14000_eta_0.01_mu_pert_0_std_pert_1perturbation_freq420/'
path='./test_runs/job_name_iter_24000_eta_0.01_mu_pert_0_std_pert_1.5perturbation_freq2000/'
data_filenames = dir(path);
logging_freq=1;
%% COUNT nb of files
nb_files = 0;
for file_struct = data_filenames'
    file_struct.name
    if ~( strcmp(file_struct.name,'.') || strcmp(file_struct.name,'..') || strcmp(file_struct.name,'.DS_Store' ) )
        %%load( [path file_struct.name] );
        nb_files = nb_files + 1;
    end
end
nb_files
%%
load([path 'GDL_pert_jid_9809600_satid_56.mat'])
%% collect all data in 1 matrix
[nb_iters,~] = size(train_errors);
w_norms_all = zeros( [nb_files,nb_iters] );
train_loss_list_WP_all = zeros( [nb_files,nb_iters] );
%test_loss_list_WP_all = zeros( [nb_files,nb_iters] );
index = 1;
for file_struct = data_filenames'
    if ~( strcmp(file_struct.name,'.') || strcmp(file_struct.name,'..') || strcmp(file_struct.name,'.DS_Store') )
        load( [path file_struct.name] );
        w_norms_all(index,:) = w_norms';
        train_loss_list_WP_all(index,:) = train_errors';
        %test_loss_list_WP_all(i,:) = test_loss_list_WP;
        index = index + 1;
    end
end
%% collect stats
%% means & stds
w_norms_means = zeros( size(w_norms) );
train_loss_list_WP_mean = zeros( size(train_errors) );
%test_loss_list_WP_mean = zeros( size(test_loss_list_WP) );
%grad_list_weight_sgd_mean
w_norms_stds = zeros( size(w_norms) );
train_loss_list_WP_stds = zeros( size(train_errors) );
%test_loss_list_WP_stds = zeros( size(test_loss_list_WP) );
%grad_list_weight_sgd_stds
for iter = 1:nb_iters
    w_norms_means(iter) = mean( w_norms_all(:,iter) );
    train_loss_list_WP_mean(iter) = mean( train_loss_list_WP_all(:,iter) );
    %test_loss_list_WP_mean(iter) = mean( test_loss_list_WP_all(:,iter) );
    %%
    w_norms_stds(iter) = std( w_norms_all(:,iter) );
    train_loss_list_WP_stds(iter) = std( train_loss_list_WP_all(:,iter) );
    %test_loss_list_WP_stds(iter) = std( test_loss_list_WP_all(:,iter) );
end
%%
x_axis = 1:nb_iters;
x_label_str = ['number of iterations/ ' num2str(logging_freq)];
fig = figure;
%errorbar(x_axis,w_norms_means,w_norms_stds);
plot(x_axis,w_norms_means);
title('W norm');
xlabel(x_label_str);
ylabel('l2 norm of W')
saveas(fig,'fig_W_norm')
saveas(fig,'fig_W_norm','pdf')
fig = figure;
plot(x_axis,train_loss_list_WP_mean);
title('Train/Test error vs iterations');
xlabel(x_label_str);
ylabel('l2 Error');
hold on;
%plot(x_axis,test_loss_list_WP_mean);
%errorbar(x_axis,w_norms_means,w_norms_stds)
saveas(fig,'fig_error_vs_iter')
saveas(fig,'fig_error_vs_iter','pdf')
beep;