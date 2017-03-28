clear;
%%
D = 1;
filename = sprintf('current_gdl_run_%dD',D)
load(filename)
%Normalization = 'probability';
Normalization = 'pdf';
%%
nbins = 30;
for d=1:D
    figure;
    histogram(W_history(:,d),nbins,'Normalization',Normalization)
    ylim([0,1])
end