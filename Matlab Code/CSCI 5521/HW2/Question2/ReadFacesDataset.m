%%
% The ReadFacesDataset function reads the Faces dataset
%
% The parameters received are:
% - filename: string containing the data file path
%
% The function should return:
% - X (n x m): Training datapoints matrix, where n is the 
% number of images, and m is the number of pixels
%
% You should be able to test the function by executing:
% X = ReadFacesDataset('faces.txt')
%
function X = ReadFacesDataset(filename)
%%%% YOUR CODE STARTS HERE
    X = load(filename);
%%%%
end

