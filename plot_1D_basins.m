%% Plot 1D basins
%%
mu1 = 4.0;
std1 = 1.0;
mu2 = 12.0;
std2 = 2.0;
arg = struct('std1',std1,'mu1',mu1,'std2',std2,'mu2',mu2);
%% evaluate U
W = linspace(1,18,200)'; % N x D = (1 x N)' = (D x N)'
y = U(W,arg)'; % 1 x N
%% plot E^(-U/T)
T = 1;
y = exp(-y/T); % 1 x N
%% plot U
plot(W,y)