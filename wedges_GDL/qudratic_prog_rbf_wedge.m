function [ output_args ] = qudratic_prog_rbf_wedge( input_args )
%
H = Kern'*Kern;
f = -2*Y_data'*Kern;
A = zeros(1,K);b = zeros(1,1);
Aeq = zeros(1,K);beq = zeros(1,1);
lb_lp = -inf*ones(K,1); ub_lp = 0*ones(K,1);
C_ = quadprog(H,f,A,b,Aeq,beq,lb_lp,ub_lp)
end

