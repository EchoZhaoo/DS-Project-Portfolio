%%
% The ReconstructFace reconstruct a face image from the project space to
% the original space
%
% The parameters received are:
% - W (m x k): Projection matrix, where m is the number of original 
% features and k the number of features in the new space
% - mu (m x 1): Vector containing the mean used when constructing W
% - z (k x 1): One face in the projected space
%
% The function should return:
% - x_recons (m x 1): Face in the original space, reconstructed
%
function x_recons = ReconstructFace(W,mu,z)
%%%% YOUR CODE STARTS HERE
    x_recons = W*z' + mu;
%%%%
end

