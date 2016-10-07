function f = get_field(B, j_curr, beta_curr, theta, phi, n_dist)
%GET_FIELD   Computes the values of the field at locations (theta, phi).
%
%   f = get_field(B, j_curr, beta_curr, theta, phi, n_dist)
%
% Inputs:
%   B - the parameter
%   j_curr - the current frequency
%   beta_curr - the needlet coefficients, Npix_curr-by-1 vector
%   theta - the co-latitude of the locations, N-by-1 vector
%   phi - the longitude of the locations, N-by-1 vector
%   n_dist - the number of points on the fine grid
%
% Outputs:
%   f - the values of the field, N-by-1 vector
%
% Author: Minjie Fan, 2016

N = length(theta);
[x, y, z] = sph2cart(phi, pi/2-theta, 1);
l_max = floor(B^(j_curr+1));
% column vector
dist = linspace(-1, 1, n_dist)';
P = p_polynomial_value( n_dist, l_max, dist );

bl_vector = get_bl_vector(B, j_curr, l_max);

Nside_curr = get_Nside(B, j_curr);
Npix_curr = 12*Nside_curr^2;
sqrt_lambda = sqrt(4*pi/Npix_curr);
psi_curr = spneedlet_eval_fast(B, j_curr, bl_vector, P, dist, sqrt_lambda);

f = zeros(N, 1);

tp = pix2ang(Nside_curr, 'nest', false); 
parfor i = 1:N
    % get_obs_i is a helper function that calculates the distance between
    % [x(i), y(i), z(i)] and the needlet locations
    obs = get_obs_i(x(i), y(i), z(i), tp, Npix_curr)
    % a is a row vector
    a = interp1(dist, psi_curr, obs, 'spline');
    f(i) = a*beta_curr;
end

end