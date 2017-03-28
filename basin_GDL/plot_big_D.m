clear;
%%
D = 3;
for d=1:D
    %% load file
    filename = sprintf('current_gdl_run_%dD',d)
    load(filename)
    %%
    %Normalization = 'probability';
    Normalization = 'pdf';
    nbins = 30;
    D = 3;
    %% plot figure
    figure;
    histogram(W_history(:,1),nbins,'Normalization',Normalization)
    xlabel('Weights')
    ylabel(sprintf('Normalization: %s',Normalization))
    title_str = sprintf('Histogram of W_%d for %d D experiment',d,D);
    title(title_str);
    ylim([0,1])
end