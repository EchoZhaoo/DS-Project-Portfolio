%%
% The PlotBmpImage plot image
%
% The parameters received are:
% - X (N x 3): Matrix for a color image RGB, where N is the number of
% pixels. 
% - w (1 x 1): width of the image, in pixels
% - h (1 x 1): height of the image, in pixels
%
function PlotBmpImage(X,h,w)
    image(reshape(X,h,w,3));
end
