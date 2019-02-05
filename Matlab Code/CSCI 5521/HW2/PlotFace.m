%%
% The PlotFace plot a image. It can be used to print an eigenface of a face
%
% The parameters received are:
% - v (m x 1): Vector for one face, where m is the number of pixels
%
function PlotFace(v)
%%%% YOUR CODE STARTS HERE
%%%% Note: the image size is 60px x 64px
    imagesc(reshape(v,60,64));
%%%%
end

