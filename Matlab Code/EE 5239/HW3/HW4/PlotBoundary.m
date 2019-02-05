function PlotBoundary(A, b, w)
d = 0.02;
[X_1, X_2] = meshgrid(min(A(:, 1)):d:max(A(:, 1)),...
    min(A(:, 2)):d:max(A(:, 2)));

xGrid = [X_1(:), X_2(:)];
Z = xGrid * w(1:2) + ones(size(X_1(:))) * w(3);

figure;
scatter(A(:, 1), A(:, 2), 15, b+1, 'filled');
% text(A(:, 1), A(:, 2), num2str(b));
hold on
contour(X_1, X_2, reshape(Z, size(X_1)), [0, 0], 'k');
title_text = 'Decision Boundary';
title(sprintf('\\begin{tabular}{c} %s \\end{tabular}', title_text), 'Interpreter', 'latex')
xlabel('Intensity', 'Interpreter', 'latex')
ylabel('Symmetry', 'Interpreter', 'latex')
ax = gca;
ax.FontSize = 15;
end