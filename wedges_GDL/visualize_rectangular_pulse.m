%syms x
x = linspace(0,10,400);
%%
figure;
plot(x,rectangularPulse(1,2,x) + rectangularPulse(4,6,x))
figure;
y = zeros(length(x));
for i=1:length(x)
    y(i) = f_cube(x(i),1,1) + f_cube(x(i),4,2);
end
plot(x,y)
%fplot(rectangularPulse(1,2,x), [-1 1])