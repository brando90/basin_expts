function [ output_args ] = linear_prog_rbf_wedge( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
indices = Y_data ~= 0;
Kern = Kern(indices,:);
Y_data = Y_data(indices);

[N, ~] = size(Kern);
f = zeros(K,1);
A = Kern;b = 100*ones(N,1);
Aeq = A; beq = Y_data;
lb_lp = -inf*ones(K,1); ub_lp = 1*ones(K,1);
%C_ = linprog(f,A,b,Aeq,beq,lb_lp,ub_lp)
C_ = linprog(f,A,b,Aeq,beq)

end

