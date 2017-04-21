function [ f_val ] = f_batch_new(x,c_batch,pyramid_batch,params) 
%
t = params.t;
tt = params.tt;
C = params.C;
beta = params.beta;
t_pyramid = params.t_pyramid;
beta_non = params.beta_non;
%
C_selected = (C.*c_batch)*(1/0.3);
pyramid_batch;
f_val = exp( -beta*eucledian(x,t,tt) )*C_selected + -pyramid_batch*exp( -beta_non * norm(x-t_pyramid,2) );
end

