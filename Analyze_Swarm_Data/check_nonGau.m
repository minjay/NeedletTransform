% combine data from three satellites
% checking the original field may not be proper: consider the case of
% normal random variables with large magnitude + t-distributed random 
% variables with small magnitude

clear

% satellite A
dat = readtable('swarmA.txt');
% range
% lon in [-180, 180]
% lat in [-90, 90]
lon = dat.Var3;
lat = dat.Var4;
time = dat.Var1;
resid_x = dat.Var8;
resid_y = dat.Var9;
resid_z = dat.Var10;

% satellite B
dat = readtable('swarmB.txt');
lon = [lon; dat.Var3];
lat = [lat; dat.Var4];
time = [time; dat.Var1];
resid_x = [resid_x; dat.Var8];
resid_y = [resid_y; dat.Var9];
resid_z = [resid_z; dat.Var10];

% satellite C
dat = readtable('swarmC.txt');
lon = [lon; dat.Var3];
lat = [lat; dat.Var4];
time = [time; dat.Var1];
resid_x = [resid_x; dat.Var8];
resid_y = [resid_y; dat.Var9];
resid_z = [resid_z; dat.Var10];

% sort data
[time, index] = sort(time);
lon = lon(index);
lat = lat(index);
resid_x = resid_x(index);
resid_y = resid_y(index);
resid_z = resid_z(index);

%% Case 1: near the equator
% specify the region of interest
lon1 = 0;
lat1 = 0;
width = 5;
height = 5;
lon2 = lon1 + width;
lat2 = lat1 + height;

index = find((lon>=lon1) & (lon<=lon2) & (lat>=lat1) & (lat<=lat2));

subplot(2, 2, 1)
qqplot(resid_x(index))
title('Residual of B_x')
subplot(2, 2, 2)
qqplot(resid_y(index))
title('Residual of B_y')
subplot(2, 2, 3)
qqplot(resid_z(index))
title('Residual of B_z')

%% Case 2: in the polar region
% specify the region of interest
lon1 = 0;
lat1 = 80;
width = 5;
height = 5;
lon2 = lon1 + width;
lat2 = lat1 + height;

index = find((lon>=lon1) & (lon<=lon2) & (lat>=lat1) & (lat<=lat2));

subplot(2, 2, 1)
qqplot(resid_x(index))
title('Residual of B_x')
subplot(2, 2, 2)
qqplot(resid_y(index))
title('Residual of B_y')
subplot(2, 2, 3)
qqplot(resid_z(index))
title('Residual of B_z')
