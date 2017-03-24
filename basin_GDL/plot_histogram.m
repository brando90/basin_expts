%%
filename = 'current_gdl_run';
load(filename)
%%
nbins = 55;
for d=1:D
    histogram(W_hist,nbins)
end