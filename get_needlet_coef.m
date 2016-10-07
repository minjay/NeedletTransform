%% Map of Radial component of Lithospheric field B_r (n>20) at Earth's surface, from CHAOS-6 field model

clear all;
close all;

rad = pi/180;
a = 6371.2; % Earth's mean spherical radius

% Load CHAOS-6 model
load 'CHAOS-6.mat'
N_C6 = 120; m_C6 = g; 

% Setup grid
Step = .5;
theta = [180-Step/2:-Step:0];
phi   = [-180+Step/2:Step:180-Step/2];

% Synthesize spherical harmonic model m_C6 into grid of B_r at Earth's surface
n_max = 120;
rho = (a+0)/a;
[B_r, B_theta, B_phi] = synth_grid(m_C6(1:n_max*(n_max+2)), rho, theta, phi);

