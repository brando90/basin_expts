function [ vNumericalGrad ] = CalcNumericalGradient( hInputFunc, vInputPoint, epsVal )

numElmnts       = size(vInputPoint, 2);
vNumericalGrad  = zeros([1,numElmnts]);
vPertuElmnts    = zeros([1,numElmnts]);

refVal = hInputFunc(vInputPoint);

for ii = 1:numElmnts
    % Set the perturbation vector
    vPertuElmnts(ii) = epsVal;

    % Compute Numerical Gradient
    vNumericalGrad(ii) = (hInputFunc(vInputPoint + vPertuElmnts) - refVal) / epsVal;

    % Reset the perturbation vector
    vPertuElmnts(ii) = 0;
end

end