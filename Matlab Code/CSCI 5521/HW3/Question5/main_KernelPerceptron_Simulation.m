% Load simulation data using LoadSimulationData
%%%% YOUR CODE STARTS HERE
[X,y] = LoadSimulationData();
%%%%

sigma = 5; %% <----- change to the sigma (RBF parameter) you want to use

% Run the Kernel Perceptron using KernelPerceptron
%%%% YOUR CODE STARTS HERE
alphas = KernelPerceptron(X,y,sigma);
%%%%

% Predict the label for the X, using MakePredictions, and then
% calculate the error rate
%%%% YOUR CODE STARTS HERE
y_pred = MakePredictions(X, y, X, alphas,sigma);
error_rate = ErrorRate(y,y);
%%%%
disp(strcat('Simulation data error rate: ', num2str(error_rate)));

% Plot data and decision boundary using PlotDataWithDecisionBoundary
%%%% YOUR CODE STARTS HERE
PlotDataWithDecisionBoundary(X, y, alphas, sigma);
%%%%
