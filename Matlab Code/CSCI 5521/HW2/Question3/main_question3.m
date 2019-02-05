%% Load data

% read data: call ReadBmpImage (the function is already implemented)
%%%% YOUR CODE STARTS HERE
[X,w,h] = ReadBmpImage('stadium.bmp');
%%%%

Ks = [3,5,7];
%figure % <-- this line will create a new window to plot. You can change/remove if you want
for i=1:length(Ks)
    K = Ks(i);
    
    %% 3a) Executing MyKmeans
    % run kmeans on X, for K clusters, using MyKmeans
    %%%% YOUR CODE STARTS HERE
    [r,mu,J] = MyKMeans(X,K);
    %%%%

    % Generate new X_new with K colors resulting from MyKmeans
    % X_new will have same size as X, but with K colors only
    %%%% YOUR CODE STARTS HERE
    X_new = r * mu;
    %%%%
    figure
    %subplot(1,3,i); % <--- this line will create a subplot in the window created by "figure". You can change/remove if you want
    % View image using X_new, using PlotBmpImage (the function is already
    % implemented)
    %%%% YOUR CODE STARTS HERE
    PlotBmpImage(X_new,h,w);
    %%%%
    
    %% 3b) Plot reconstruction error
    %subplot(1,3,i); % <--- this line will create a subplot in the window created by "figure". You can change/remove if you want
    % Plot the reconstruction error J returned by MyKmeans, using PlotReconstructionError
    %%%% YOUR CODE STARTS HERE
    PlotReconstructionError(J);
    %%%%
    
end




