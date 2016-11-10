clear

subplot = @(m,n,p) subtightplot (m, n, p, [0.02 0.04], [0.01 0.05], [0.04 0.02]);

res = 1e3;

theta = linspace(0, pi, res/2);
phi = linspace(0, 2*pi, res);
[phi_mat, theta_mat] = meshgrid(phi, theta);
theta_vec = theta_mat(:);
phi_vec = phi_mat(:);

[L, T] = meshgrid(phi-pi, pi/2-theta);
[HX, HY] = sph2hammer(L, T);

% when m=0, SH is real
for l = 1:6
    Y = spharmonic_eval(l, 0, theta_vec, phi_vec);
    f = reshape(Y, res/2, res);

    subplot(2, 3, l);
    pcolor(HX, HY, f);
    axis equal
    axis tight
    axis off
    shading flat
    colorbar('southoutside')
    title(['l = ', num2str(l), ', m = 0'])
    set(gca, 'FontSize', 12)
end