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
lon_c = 0;
lat_c = 0;
half_width = 2.5;
half_height = 2.5;
lon1 = lon_c - half_width;
lon2 = lon_c + half_width;
lat1 = lat_c - half_height;
lat2 = lat_c + half_height;

index = find((lon>=lon1) & (lon<=lon2) & (lat>=lat1) & (lat<=lat2));

figure
subplot(1, 3, 1)
qqplot(resid_x(index))
title('Residual of B_x')
axis square
subplot(1, 3, 2)
qqplot(resid_y(index))
title('Residual of B_y')
axis square
subplot(1, 3, 3)
qqplot(resid_z(index))
title('Residual of B_z')
axis square
suptitle('Small region near lon 0, lat 0 degree')

%% Case 2: in the north polar region
% specify the region of interest
lon_c = 0;
lat_c = 80;
half_width = 2.5;
half_height = 2.5;
lon1 = lon_c - half_width;
lon2 = lon_c + half_width;
lat1 = lat_c - half_height;
lat2 = lat_c + half_height;

index = find((lon>=lon1) & (lon<=lon2) & (lat>=lat1) & (lat<=lat2));

figure
subplot(1, 3, 1)
qqplot(resid_x(index))
title('Residual of B_x')
axis square
subplot(1, 3, 2)
qqplot(resid_y(index))
title('Residual of B_y')
axis square
subplot(1, 3, 3)
qqplot(resid_z(index))
title('Residual of B_z')
axis square

%% Case 3: in the south polar region
% specify the region of interest
lon_c = 0;
lat_c = -80;
half_width = 2.5;
half_height = 2.5;
lon1 = lon_c - half_width;
lon2 = lon_c + half_width;
lat1 = lat_c - half_height;
lat2 = lat_c + half_height;

index = find((lon>=lon1) & (lon<=lon2) & (lat>=lat1) & (lat<=lat2));

figure
subplot(1, 3, 1)
qqplot(resid_x(index))
title('Residual of B_x')
axis square
subplot(1, 3, 2)
qqplot(resid_y(index))
title('Residual of B_y')
axis square
subplot(1, 3, 3)
qqplot(resid_z(index))
title('Residual of B_z')
axis square
suptitle('Small region near lon 0, lat -80 degree')

%% Case 4: in the north hemisphere
% specify the region of interest
lon_c = 0;
lat_c = 30;
half_width = 2.5;
half_height = 2.5;
lon1 = lon_c - half_width;
lon2 = lon_c + half_width;
lat1 = lat_c - half_height;
lat2 = lat_c + half_height;

index = find((lon>=lon1) & (lon<=lon2) & (lat>=lat1) & (lat<=lat2));

figure
subplot(1, 3, 1)
qqplot(resid_x(index))
title('Residual of B_x')
axis square
subplot(1, 3, 2)
qqplot(resid_y(index))
title('Residual of B_y')
axis square
subplot(1, 3, 3)
qqplot(resid_z(index))
title('Residual of B_z')
axis square
suptitle('Small region near lon 0, lat 30 degree')
