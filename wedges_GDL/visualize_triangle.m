x = linspace(0,12,200);
%% plot step
% figure;
% offset = 1;
% f = @(x) step(x,offset);
% y = arrayfun(f,x);
% plot(x,y)
%% plot triangle 
% figure;
% offset = 1;
% f = @(x) tri(x,offset) + tri(x,offset);
% y = arrayfun(f,x);
% plot(x,y)
%% plot twi triangles
figure;
offset1 = 2;
offset2 = 8;
%offset = 2;
f = @(x) tri(x-2,1) + tri(x-8,1);
y = arrayfun(f,x);
plot(x,y)