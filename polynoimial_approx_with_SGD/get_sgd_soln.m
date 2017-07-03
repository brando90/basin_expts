function [ output_args ] = get_sgd_soln( x,y, D,w_init,batch_size,B )
% x = [N x 1]
M = batch_size;
indices = 1:M;
W = w_init;
for i=2:iter+1
    %% mini-batch
    i_batch = datasample(indices,M,'Replace',false);
    x_batch = x(i_batch); % [M,1]
    y_batch = y(i_batch); % [M,1]
    %% get gradients
    delta = 2*(x_batch*W - y); % [M,1]
    g = delta.*x_batch; % [M,1] .* [M,D]
    %% SGD update
    W = mod(W - eta*g + A*gdl_eps, B);
end
end

