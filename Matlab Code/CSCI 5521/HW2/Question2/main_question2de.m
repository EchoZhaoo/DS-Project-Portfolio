%% Read Faces dataset

% read data: call ReadFacesDataset
%%%% YOUR CODE STARTS HERE
X = ReadFacesDataset('faces.txt');
%%%%

%% 2d) Plotting eigenface

% perform PCA using MyPCA (k=100 recommended)
%%%% YOUR CODE STARTS HERE
[W, mu] = MyPCA(X, 100);
%%%%

figure % <-- this line will create a new window to plot. You can change/remove if you want
subplot(1,2,1); % <--- this line will create a subplot in the window created by "figure". You can change/remove if you want
% plot first eigenface, using PlotFace
%%%% YOUR CODE STARTS HERE
PlotFace(W(:,1));
%%%%

subplot(1,2,2); % <--- this line will create a subplot in the window created by "figure". You can change/remove if you want
% plot second eigenface, using PlotFace
%%%% YOUR CODE STARTS HERE
PlotFace(W(:,2));
%%%%

%% 2e) Reconstruction
 % <-- this line will create a new window to plot. You can change/remove if you want
D = [10,50,100];
for i=1:length(D)
    %subplot(1,3,i); % <--- this line will create a subplot in the window created by "figure". You can change/remove if you want
    % project first face (first row of X) to W, using D(i) principal
    % components, using ProjectDatapoints. Then, reconstruct the face by
    % calling ReconstructFace, using the same D(i) first principal
    % componnets. Finally, plot the reconstructed face using PlotFace
    %%%% YOUR CODE STARTS HERE
    [W, mu] = MyPCA(X, D(i));
    Z = ProjectDatapoints(W,mu,X(1,:));
    x_recons = ReconstructFace(W,mu,Z);
    figure
    PlotFace(x_recons);
    %%%%
end
