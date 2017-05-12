function [ f_val ] = f_batch_new(x,ind_mini_batch,params) 
% evalates a batch of the loss surface
% x - value of x
% ind_mini_batch - indicator vector of which points were selected
% params - struct
t = params.t;
tt = params.tt;
C = params.C;
beta = params.beta;
%
t_p = params.t_p;
tt_p = params.tt_p;
C_p = params.C_p;
beta_p = params.beta_p;
%%
C_chosen = [C;C_p].*ind_mini_batch;
Kern_x = [exp( -beta*eucledian(x,t,tt) ) exp( -beta_p*eucledian(x,t_p,tt_p) )]';
%f_degen = (C.*ind_mini_batch)*exp( -beta*eucledian(x,t,tt) );
%
%f_nondegen = (C_p.*ind_mini_batch)*exp( -beta_p*eucledian(x,t_p,tt_p) );
%%
f_val = C_chosen' * Kern_x;
end

