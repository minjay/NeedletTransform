clear

subplot = @(m,n,p) subtightplot (m, n, p, [0.02 0.04], [0.01 0.05], [0.04 0.2]);

B = 2;
res = 1e3;

theta = linspace(0, pi, res/2);
phi = linspace(0, 2*pi, res);
[phi_mat, theta_mat] = meshgrid(phi, theta);
theta_vec = theta_mat(:);
phi_vec = phi_mat(:);

[L, T] = meshgrid(phi-pi, pi/2-theta);
[X, Y, Z] = sph2cart(L, T, 1);

theta_xi = pi/2;
phi_xi = pi/2+pi/10;

psi_all = cell(6, 1);
min_value = 1;
for j = 1:6
    [dist, psi] = get_psi_loc(B, j, theta_xi, phi_xi, theta_vec, phi_vec);
    cmax = max(abs(psi));
    psi_all{j} = psi/cmax;
    if min(psi_all{j})<min_value
        min_value = min(psi_all{j});
    end
end

for j = 1:6
    
    f = reshape(psi_all{j}, res/2, res);

    subplot(2, 3, j);
    surf(X, Y, Z, f)
    view(0, 15)
    axis equal
    axis tight
    axis off
    shading flat
    view([0 15]);
    colormap(jet)
    caxis([min_value 1])
    title(['j = ', num2str(j)])
    set(gca, 'FontSize', 12)
end
h = colorbar;
set(h, 'Position', [.85 0.1 .05 .75]);