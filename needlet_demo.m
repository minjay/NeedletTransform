clear

subplot = @(m,n,p) subtightplot (m, n, p, [0.02 0.04], [0.01 0.05], [0.04 0.02]);

B = 2;
res = 1e3;

theta = linspace(0, pi, res/2);
phi = linspace(0, 2*pi, res);
[phi_mat, theta_mat] = meshgrid(phi, theta);
theta_vec = theta_mat(:);
phi_vec = phi_mat(:);

[L, T] = meshgrid(phi-pi, pi/2-theta);
[HX, HY] = sph2hammer(L, T);

for j = 1:6
    Nside = get_Nside(B, j);
    k = 12*Nside^2/2;
    [dist, psi] = get_psi(B, j, k, theta_vec, phi_vec);

    f = reshape(psi, res/2, res);

    subplot(2, 3, j);
    pcolor(HX, HY, f);
    axis equal
    axis tight
    axis off
    shading flat
    colorbar('southoutside')
    title(['j = ', num2str(j)])
    set(gca, 'FontSize', 12)
end