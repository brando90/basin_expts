x = linspace(0,10,200);
%% plot step
figure;
offset = 1;
f = @(x) step(x,offset);
y = arrayfun(f,x);
plot(x,y)
%% plot triangle 
figure;
offset = 1;
%offset = 2;
f = @(x) tri(x,offset);
y = arrayfun(f,x);
plot(x,y)