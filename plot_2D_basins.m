%% Plot 2D basins
D = 2;
mu1 = 4*ones(1,D);
std1 = 1.0;
mu2 = 12.0*ones(1,D);
std2 = 2.0;
arg = struct('std1',std1,'mu1',mu1,'std2',std2,'mu2',mu2);
%% evaluate U
N = 200; % number of samples
B = 18; % edge bound for compact set
W1 = linspace(0, B, N);
W2 = linspace(0, B, N);
y = U(W,arg);
%% plot E^(-U/T)
T = 1;
y = exp(-y/T);
%% plot U
plot(W,y)