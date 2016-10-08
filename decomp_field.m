clear

addpath(genpath('/home/minjay/NeedMat'))
addpath(genpath('/home/minjay/NeedletTransform'))

load('beta_B.mat')

parpool(24)

j_min = 0;
j_max = 7;
B = 2;

% Get number of needlets at different j
len_j = j_max-j_min+1;
Nside = zeros(len_j, 1);
Npix = zeros(len_j, 1);
st = zeros(len_j, 1);
en = zeros(len_j, 1);
for j = j_min:j_max
    Nside(j-j_min+1) = get_Nside(B, j);
    Npix(j-j_min+1) = 12*Nside(j-j_min+1)^2;
    en(j-j_min+1) = sum(Npix(1:(j-j_min+1)));
    st(j-j_min+1) = en(j-j_min+1)-Npix(j-j_min+1)+1;
end

% Setup grid
Step = 0.5;
theta_grid = [180-Step/2:-Step:0];
phi_grid   = [-180+Step/2:Step:180-Step/2];
% Make sure that row represents theta and column represents phi
[phi_mat, theta_mat] = meshgrid(phi_grid, theta_grid);
theta_vec = theta_mat(:)/180*pi;
phi_vec = phi_mat(:)/180*pi;

f_B_r = cell(len_j, 1);
f_B_theta = cell(len_j, 1);
f_B_phi = cell(len_j, 1);
% Get field decomposition
for j = j_min:j_max
    disp(['j = ', num2str(j)])
    index = j-j_min+1;
    disp('Working on B_r...')
    f_B_r{index} = reshape(get_field(B, j, beta_B_r{j+1}, theta_vec, phi_vec, 1000), size(phi_mat));
    disp('Working on B_theta...')
    f_B_theta{index} = reshape(get_field(B, j, beta_B_theta{j+1}, theta_vec, phi_vec, 1000), size(phi_mat));
    disp('Working on B_phi...')
    f_B_phi{index} = reshape(get_field(B, j, beta_B_phi{j+1}, theta_vec, phi_vec, 1000), size(phi_mat));
end

filename = 'f_decomp.mat';
save(filename, 'f_B_r', 'f_B_theta', 'f_B_phi')
