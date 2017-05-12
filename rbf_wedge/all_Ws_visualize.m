clear;
%
load('all_Ws.mat');
%%
[iter,D,nb_expts] = size(all_Ws)
%%
%Normalization = 'probability';
%Normalization = 'pdf';
Normalization = 'count';
nbins = 30;
for i=1:1
    W_history = all_Ws(:,:,i);
    %W_history = reshape(all_Ws,[iter*nb_expts,D]);
    %all_Ws = all_Ws(:,:,1:2);
    %W_history = reshape(all_Ws,[iter*2,D]);
    %W_history = [all_Ws(:,:,1) ; all_Ws(:,:,2) ];
    W_history = all_Ws(:,:,1);
    for j=2:nb_expts
        W_history = [W_history ; all_Ws(:,:,j)];
    end
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
    end
end
