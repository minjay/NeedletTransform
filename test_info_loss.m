% Script testing the information loss due to the needlet transformation
% The information loss may be caused by
% 1. the approximate quadrature formula
% 2. the approximate evaluation of needlets
% Note that the spherical harmonic transform is almost accurate

clear

load('f_decomp.mat')
% Ignore a00*Y00(x) since it is almost zero
B_r_tot = f_B_r{1};
B_theta_tot = f_B_theta{1};
B_phi_tot = f_B_phi{1};
for i = 2:length(f_B_r)
    B_r_tot = B_r_tot + f_B_r{i};
    B_theta_tot = B_theta_tot + f_B_theta{i};
    B_phi_tot = B_phi_tot + f_B_phi{i};
end

rad = pi/180;
a = 6371.2; % Earth's mean spherical radius

% Load CHAOS-6 model
load 'CHAOS-6.mat'
N_C6 = 120; m_C6 = g; 

% Setup grid
Step = 0.5;
theta = [180-Step/2:-Step:0];
phi   = [-180+Step/2:Step:180-Step/2];

% Synthesize spherical harmonic model m_C6 into grid of B_r at Earth's surface
n_max = 120;
rho = (a+0)/a;
[B_r, B_theta, B_phi] = synth_grid(m_C6(1:n_max*(n_max+2)), rho, theta, phi);

figure
plot_field_map(B_r_tot, 200)
print('f_B_r_tot.eps', '-depsc')
figure
plot_field_map(B_r, 200)

figure
plot_field_map(B_theta_tot, 200)
print('f_B_theta_tot.eps', '-depsc')
figure
plot_field_map(B_theta, 200)

figure
plot_field_map(B_phi_tot, 200)
print('f_B_phi_tot.eps', '-depsc')
figure
plot_field_map(B_phi, 200)