function [ C ] = learn_RBF_linear_algebra( X_training_data, Y_training_data, t, beta )
%
Kern_matrix = produce_kernel_matrix_bsxfun(X_training_data, t, beta); % (N x K)
C = Kern_matrix \ Y_training_data';  % (K x D) = (N x K)' x (N x D)
end