function [ vNumericalGrad ] = CalcNumericalDeriv( vInputPoint, hInputFunc, epsVal )

numElmnts       = size(vInputPoint, 2);
vNumericalGrad  = zeros([1,numElmnts]);

%% f(W) = set reference valyes
refVal = hInputFunc(vInputPoint);
for ii = 1:numElmnts
    %% W+eps = Set the perturbation vector
    refInVal = vInputPoint(ii);
    vInputPoint(ii) = refInVal + epsVal;
    
    %% (f(W+eps) - f(W))/eps = Compute Numerical Gradient
    vNumericalGrad(ii) = (hInputFunc(vInputPoint) - refVal) / epsVal;
    %vNumericalGrad(ii) = (hInputFunc(vInputPoint) - refVal);

    %% Reset the perturbation vector
    vInputPoint(ii) = refInVal;
end

end