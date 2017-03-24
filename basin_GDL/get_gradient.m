function [ dU_dW ] = get_gradient( W,mu1,std1,mu2,std2 )
% dU_dw = beta1 (w - mu1) exp( -beta1 <w - mu1,w - mu1>) + beta2 (w - mu2) exp( -beta2 <w - mu2,w - mu2>)
beta1 = 1/(2*std1^2);
dG1dW = beta1*(W-mu1)*evaluate_basin( W,mu1,std1 );
beta2 = 1/(2*std2^2);
dG2dW = beta2*(W-mu2)*evaluate_basin( W,mu2,std2 );
dU_dW = dG1dW + dG2dW;
end

