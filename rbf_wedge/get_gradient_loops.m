function [ dU_dW ] = get_gradient_loops( W )
D = length(W);
mu1 = 4*ones(1,D);
std1 = 1.0;
mu2 = 12.0*ones(1,D);
std2 = 2.0;
%
[D1,D2] = size(W);
dU_dW = zeros(D1,D2);
%
beta1 = 1/(2*std1^2);
beta2 = 1/(2*std2^2);
for d2=1:D2
    dG1dW = 2*beta1*(W(d2)-mu1(d2))*evaluate_basin( W,mu1,std1 );
    dG2dW = 2*beta2*(W(d2)-mu2(d2))*evaluate_basin( W,mu2,std2 );
    dU_dW(d2) = dG1dW + dG2dW;
end
end

