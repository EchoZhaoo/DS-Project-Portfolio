%%
% The ReadBmpImage read the bmp image
%
% The parameters received are:
% - image_filename: image filename
%
% The function returns:
% - X (n x 3): Matrix for a color image RGB, where n is the number of
% pixels. 
% - w (1 x 1): width of the image, in pixels
% - h (1 x 1): height of the image, in pixels
%
function [X,w,h] = ReadBmpImage(image_filename)
    [img, cmap] = imread(image_filename); % img: the data present image; cmap: the data present colour
    img_rgb = ind2rgb(img,cmap); % covert the indexed image to the truecolor image
    img_double = im2double(img_rgb); % convert the intensity image img_rgb to double precision
    [h,w,d] = size(img_double);
    X = reshape(img_double,w*h,d); % reshape img_double using the size vector, nrow = w*h, ncol = d
end

