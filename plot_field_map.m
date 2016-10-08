function plot_field_map(field)

B_ref =  makerefmat('RasterSize', size(B_r), ...
    'Latlim', [-90 90], 'Lonlim', [-180 180]);

load coast

clf
C_max = 200;
dC = 50;
B_tmp = B_r;
filename_out = 'Map_Br_lithosphere_20_110_CHAOS-6.png';

% North pole
pole_width = .3;
axes('Position', [0  0.45 pole_width pole_width], 'Box', 'off')
axesm('MapProjection', 'ortho', 'Origin', [90 0], 'FLatLimit',[-Inf 40.01])
plotm(lat, long, '-k', 'Linewidth', 1)
meshm(B_tmp, B_ref, size(B_tmp))
gridm
tightmap
caxis(C_max*[-1 1])
set(gca, 'Box', 'off', 'Visible', 'off')

% South pole
axes('Position', [1-pole_width 0.45 pole_width pole_width ], 'Box', 'off')
axesm('MapProjection', 'ortho', 'Origin', [-90 0], 'FLatLimit',[-Inf 39.9])
plotm(lat, long, '-k', 'Linewidth', 1)
meshm(B_tmp, B_ref, size(B_tmp))
gridm
tightmap
caxis(C_max*[-1 1])
set(gca, 'Box', 'off', 'Visible', 'off')

% Hammer projection
axes('Position', [0 0 1 .5], 'Box', 'off')
axesm('MapProjection', 'hammer', 'Frame', 'off')
meshm(B_tmp, B_ref, size(B_tmp))
plotm(lat, long, '-k', 'Linewidth', 1)
gridm
tightmap
set(gca, 'Box', 'off', 'Visible', 'off')
caxis(C_max*[-1 1])
tightmap

% Colorbar
nio_colormap;
map=colormap;

axes('Position', [0.333 0.6 .333 .015], 'Box', 'off')
image([1:length(map)], 'XData', [-C_max C_max]);
set(gca,'XTick', [-C_max:dC:C_max], 'XtickLabel', [-C_max:dC:C_max], 'Xdir', 'Normal', 'FontWeight', 'normal', 'Xcolor', 'k', 'FontSize', 8, 'YTickLabel', {}, 'Ydir', 'Normal')
text(0.5, 2,' nT', 'Color', 'k', 'FontWeight','normal', 'FontSize', 10, 'Units', 'normalized', 'HorizontalAlignment', 'Center')
set(gcf, 'PaperOrientation', 'Portrait', 'PaperType', 'A4', 'PaperUnits', ...
    'centimeters', 'PaperPosition', [0.2 0.2 0.7*[30 30]]);

end