function [track1, track2, track3, orient] = ATL03_read(FILE_NAME)


file_id = H5F.open (FILE_NAME, 'H5F_ACC_RDONLY', 'H5P_DEFAULT');

%% orbit info
%% orient: 1-forward, r-strong beam; 0-background, l-strong beam
ORIENTFIELD_NAME=['/orbit_info/sc_orient'];
orient_id=H5D.open(file_id, ORIENTFIELD_NAME);
orient=H5D.read(orient_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');   
H5D.close (orient_id);

if (orient < 0.5) %orient = 0
    track = 'gt1l';
    ATL03_sub1;
    track1=[ph_lon ph_lat ph_height_corrected];
    track = 'gt2l';
    ATL03_sub1;
    track2=[ph_lon ph_lat ph_height_corrected];
    track = 'gt3l';
    ATL03_sub1;
    track3=[ph_lon ph_lat ph_height_corrected];
else % orient = 1
    track = 'gt1r';
    ATL03_sub1;
    track1=[ph_lon ph_lat ph_height_corrected];
    track = 'gt2r';
    ATL03_sub1;
    track2=[ph_lon ph_lat ph_height_corrected];
    track = 'gt3r';
    ATL03_sub1;
    track3=[ph_lon ph_lat ph_height_corrected];
end
H5F.close (file_id);

% Create the graphics figure.
% show (signal) photon height with reference to WGS 84
f = figure('Name', [FILE_NAME], ...
           'Renderer', 'zbuffer', ...
           'Position', [0,0,800,600], ...
           'visible','off');

% Put title.
var_name = sprintf('%s', long_name_temp);
tstring = {FILE_NAME;track;var_name};
title(tstring,...
      'Interpreter', 'none', 'FontSize', 16, ...
      'FontWeight','bold');
axesm('MapProjection','eqdcylin','Frame','on','Grid','on', ...
      'MeridianLabel','on','ParallelLabel','on','MLabelParallel','south')

ind_plot = floor(linspace(1,size(ph_lon,1),10000));

scatterm(ph_lat(ind_plot), ph_lon(ind_plot), 1, ph_height(ind_plot));
h = colorbar();
units_str = sprintf('%s', char(units_temp));
set (get(h, 'title'), 'string', units_str, 'FontSize', 8, ...
                   'Interpreter', 'None', ...
                   'FontWeight','bold');

% Plot world map coast line.
coast = load('coast.mat');
plotm(coast.lat, coast.long, 'k');
tightmap;
saveas(f, [FILE_NAME '_' track '.m.png']);


end
