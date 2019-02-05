%%
% Radial Basis Function (RBF) kernel
%
% The parameters received are:
% - X1 (N_1 x D): First set of samples, where N_1 is the number of samples
% and D the number of features. Notice that the function still works if N_1
% is 1
% - X2 (N_2 x D): Second set of samples, where N_2 is the number of samples
% and D the number of features. Notice that the function still works if N_2
% is 1
%
function C = RBF(X1,X2,sigma)
    C = exp(-(1/(2*sigma)) .* pdist2(X1,X2).^2);
end
