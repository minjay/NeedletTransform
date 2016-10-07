function obs = get_obs_i(x_i, y_i, z_i, tp, Npix_curr)

obs = zeros(1, Npix_curr);
for k = 1:Npix_curr
    theta_xi = tp{k}(1);
    phi_xi = tp{k}(2);
    [x_xi, y_xi, z_xi] = sph2cart(phi_xi, pi/2-theta_xi, 1);
    obs(k) = sum([x_i y_i z_i].*[x_xi y_xi z_xi]);
    obs(k) = min(obs(k), 1);
    obs(k) = max(obs(k), -1);
end

end