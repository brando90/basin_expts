function [ dU_dW ] = get_gradient_loops( W,mu1,std1,mu2,std2 )
%
[D1,D2] = size(W);
dU_dW = zeros(D1,D2);
%
beta1 = 1/(2*std1^2);
beta2 = 1/(2*std2^2);
for d1=1:D1;
    dG1dW = beta1*(W(d1)-mu1(d1))*evaluate_basin( W,mu1,std1 );
    dG2dW = beta2*(W(d1)-mu2(d1))*evaluate_basin( W,mu2,std2 );
    dU_dW(d1) = dG1dW + dG2dW;
end
end

