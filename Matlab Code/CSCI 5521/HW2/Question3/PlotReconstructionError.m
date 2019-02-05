%%
% The PlotReconstructionError plot the reconstruction error in J, so that 
% even position have one color and odd positions another color (you can, 
% for example, call scatter twice).
%
% The parameters received are:
% - J (iter*2 x 1): Vector with all the reconstruction errors returned by 
% MyKMeans
%
function PlotReconstructionError(J)
%%%% YOUR CODE STARTS HERE
    n_step = size(J,1);
    figure 
    for i = 1:n_step
        if mod(i,2)
            scatter(i,J(i,:),[],'r');
            hold on
        else
            scatter(i,J(i,:),[],'b');
            hold on
        end
    end
    hold off
%%%%
end

