%% Plot D basins
D = 3;
mu1 = 4*ones(1,D);
std1 = 1.0;
mu2 = 12.0*ones(1,D);
std2 = 2.0;
arg = struct('std1',std1,'mu1',mu1,'std2',std2,'mu2',mu2);
%% evaluate U
N = 4; % number of samples
B = 18; % edge bound for compact set
%W = (18-0)*rand([N,D]);
W = zeros(N,D);
W(:,1) = linspace(1,18,N);
W(:,2) = linspace(1,18,N);
W(:,3) = linspace(1,18,N);
y = U(W,arg);
%% plot E^(-U/T)
T = 1;
y = exp(-y/T);
%% plot U
figure;
plot(W(:,1),y)
figure;
plot(W(:,2),y)
figure;
plot(W(:,3),y)