clear;
%%
filename = 'current_gdl_run';
load(filename)
%%
nbins = 30;
for d=1:D
    figure;
    histogram(W_history(:,d),nbins,'Normalization','probability')
end