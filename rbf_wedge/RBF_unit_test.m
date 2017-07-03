D = 3;
N = 5;
X = rand(D,N);
t = rand(D,N);
beta = 0.123;
%%
Kern1 = produce_kernel_matrix( X, t, beta )
Kern2 = produce_kernel_matrix_bsxfun( X, t, beta )