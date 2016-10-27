dat = readtable('swarmA.txt');

lon = dat.Var3;
lat = dat.Var4;

% degree to radian
lon = lon/180*pi;
lat = lat/180*pi;

[HX, HY] = sph2hammer(lon, lat);

resid_B_x = dat.Var8;
resid_B_y = dat.Var9;
resid_B_z = dat.Var10;

for i = 1:5
    figure
    subplot('position',[0 0 1 1]);
    % take 5000 data points
    range = 5000*(i-1)+1:5000*i;
    scatter(HX(range), HY(range), [], resid_B_x(range), 'filled')
    colorbar('southoutside')
    colormap('jet')
    cmax = max(abs(resid_B_x(range)));
    caxis([-cmax cmax])
    hold on

    % draw contour
    th = linspace(-pi/2,pi/2,101);
    lam = -pi+0*th;
    [xh,yh] = sph2hammer(lam,th);
    plot(xh,yh,'k', 'LineWidth', 2);
    lam = pi+0*th;
    [xh,yh] = sph2hammer(lam,th);
    plot(xh,yh,'k', 'LineWidth', 2);

    axis equal
    axis tight
    axis off
end
