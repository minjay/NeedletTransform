% Script to apply fast needlet transform to the synthetic magnetic field.
%
% Dependencies:
% 1. S2Kit_Matlab
% 2. NeedMat
% They are available on Minjie's github: https://github.com/minjay.
%
% Steps:
% 1. Simulate the synthetic magnetic field.
% 2. Get the spherical harmonic coefficients using the quadrature formula.
% 3. Get the needlet coefficients using fast needlet transform.
%
% Assumption: the field is isotropic. Otherwise, the histogram of the 
% needlet coefficients would be meaningless.

clear
close all

%% Simulate the synthetic magnetic field
rad = pi/180;
a = 6371.2; % Earth's mean spherical radius

% Load CHAOS-6 model
load 'CHAOS-6.mat'
N_C6 = 120; m_C6 = g; 

% Synthesize spherical harmonic model m_C6 into grid of B_r at Earth's surface
n_max = 120;
rho = (a+0)/a;

% Use the equiangular grid in S2Kit
% See http://www.cs.dartmouth.edu/~geelong/sphere/s2-main.pdf
bandwidth = n_max+1;
index_all = 0:(2*bandwidth-1);
theta = 180*(2*index_all+1)/4/bandwidth;
phi = 360*index_all/2/bandwidth;
% -180<=phi<=180
phi(phi>180) = phi(phi>180)-360;

[B_r, B_theta, B_phi] = synth_grid(m_C6(1:n_max*(n_max+2)), rho, theta, phi);

B = 2;

%% Work on B_r
B_r_transpose = B_r';

% Use the quadrature formula to get the spherical harmonic coefficients
alm = spharmonic_tran_s2kit(B_r_transpose(:), bandwidth, '/Users/minjay/Documents/MATLAB/Needlets/S2Kit_Matlab');

% Use fast needlet transform to get the needlet coefficients
beta_B_r = spneedlet_tran(alm, n_max, B);

% Plot histogram
figure
for i = 1:8
    subplot(2, 4, i)
    histogram(beta_B_r{i})
    title(['j = ', num2str(i-1)])
end
suptitle('Histogram of needlet coefficients for B_r')

% Plot Q-Q plots
h = figure;
for i = 1:8
    subplot(2, 4, i)
    qqplot(beta_B_r{i})
    title(['j = ', num2str(i-1)])
end
suptitle('Q-Q plots of needlet coefficients for B_r')
set(h, 'Position', [0, 0, 700, 500]);

%% Work on B_theta
B_theta_transpose = B_theta';

% Use the quadrature formula to get the spherical harmonic coefficients
alm = spharmonic_tran_s2kit(B_theta_transpose(:), bandwidth, '/Users/minjay/Documents/MATLAB/Needlets/S2Kit_Matlab');

% Use fast needlet transform to get the needlet coefficients
beta_B_theta = spneedlet_tran(alm, n_max, B);

% Plot histogram
figure
for i = 1:8
    subplot(2, 4, i)
    histogram(beta_B_theta{i})
    title(['j = ', num2str(i-1)])
end
suptitle('Histogram of needlet coefficients for B_{\theta}')

% Plot Q-Q plots
h = figure;
for i = 1:8
    subplot(2, 4, i)
    qqplot(beta_B_theta{i})
    title(['j = ', num2str(i-1)])
end
suptitle('Q-Q plots of needlet coefficients for B_{\theta}')
set(h, 'Position', [0, 0, 700, 500]);

%% Work on B_phi
B_phi_transpose = B_phi';

% Use the quadrature formula to get the spherical harmonic coefficients
alm = spharmonic_tran_s2kit(B_phi_transpose(:), bandwidth, '/Users/minjay/Documents/MATLAB/Needlets/S2Kit_Matlab');

% Use fast needlet transform to get the needlet coefficients
beta_B_phi = spneedlet_tran(alm, n_max, B);

% Plot histogram
figure
for i = 1:8
    subplot(2, 4, i)
    histogram(beta_B_phi{i})
    title(['j = ', num2str(i-1)])
end
suptitle('Histogram of needlet coefficients for B_{\phi}')

% Plot Q-Q plots
h = figure;
for i = 1:8
    subplot(2, 4, i)
    qqplot(beta_B_phi{i})
    title(['j = ', num2str(i-1)])
end
suptitle('Q-Q plots of needlet coefficients for B_{\phi}')
set(h, 'Position', [0, 0, 700, 500]);

%% Save needlet coefficients
filename = 'beta_B.mat';
save(filename, 'beta_B_r', 'beta_B_theta', 'beta_B_phi')
