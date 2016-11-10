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
[X, Y, Z] = sph2cart(L, T, 1);

theta_xi = pi/2;
phi_xi = pi/2+pi/10;

for j = 1:6
    [dist, psi] = get_psi_loc(B, j, theta_xi, phi_xi, theta_vec, phi_vec);

    f = reshape(psi, res/2, res);

    subplot(2, 3, j);
    h = surf(X, Y, Z, f);
    view(0, 15)
    axis equal
    axis tight
    axis off
    shading flat
    view([0 15]);
    title(['j = ', num2str(j)])
    set(gca, 'FontSize', 12)
end