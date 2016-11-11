load('ss.mat')

subplot = @(m,n,p) subtightplot (m, n, p, [0.02 0.04], [0.01 0.05], [0.04 0.02]);

B = 2;
j_min = 2;
j_max = 4;

len_j = j_max-j_min+1;

grid_points = cell(len_j, 1);

[x, y, z] = sphere;
x = x*0.98;
y = y*0.98;
z = z*0.98;

for j = j_min:j_max
    index_j = j-j_min+1;
    % t needs to be odd
    % the quadrature formula is exact for all polynomials of degree<=t
    t = 2*floor(B^(j+1))+1;
    grid_points{index_j} = ss{degree_t==t};
    subplot(1, 3, index_j)
    surf(x, y, z, 'FaceColor', [0.680000 0.850000 0.900000], 'EdgeColor', 'none')
    hold on
    scatter3(grid_points{index_j}(:, 1), grid_points{index_j}(:, 2), grid_points{index_j}(:, 3), 10, 'filled')
    view(0, 15)
    axis equal
    axis tight
    axis off
    title(['j = ', num2str(j)])
    set(gca, 'FontSize', 12)
end
suptitle('Symmetric spherical t-designs')
