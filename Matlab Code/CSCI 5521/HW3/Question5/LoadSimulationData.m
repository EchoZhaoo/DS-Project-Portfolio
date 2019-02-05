%%
% Load simulation data
%
function [X, y] = LoadSimulationData()
    rng(1); % For reproducibility
    r = sqrt(rand(100,1));
    t = 2*pi*rand(100,1); 
    X1 = [r.*cos(t), r.*sin(t)]; % Points in class 1
    r2 = sqrt(3*rand(100,1)+2); 
    t2 = 2*pi*rand(100,1); 
    X2 = [r2.*cos(t2), r2.*sin(t2)]; % Points in class 2
    X = [X1;X2];
    y = ones(200,1); % Labels
    y(1:100) = -1;
end
