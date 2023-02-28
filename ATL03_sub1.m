%% subroutine of ATL03_read
% read the photon height (in ref to WGS 84)
% choose to do geophysical correction or not (comment ATL03_sub2 or not)
%
%% Open the datasets. 10k Hz
LATFIELD_NAME=[track '/heights/lat_ph'];
lat_id=H5D.open(file_id, LATFIELD_NAME);

LONFIELD_NAME=[track '/heights/lon_ph'];
lon_id=H5D.open(file_id, LONFIELD_NAME);

DATAFIELD_NAME=[track '/heights/h_ph'];
height_id=H5D.open(file_id, DATAFIELD_NAME);

CONFIELD_NAME=[track '/heights/signal_conf_ph'];
confidence_id=H5D.open(file_id, CONFIELD_NAME);

TIME10KFIELD_NAME=[track '/heights/delta_time'];
time10k_id=H5D.open(file_id, TIME10KFIELD_NAME);


%% Read the datasets, 10k Hz
% conf (confidence level): 5 rows indicate signal finding for each surface type
% land, ocean, sea ice, land ice and inland water
% for each type: 0-noise, 1-buffer, 2-low, 3-medium, 4-high
%
lat=H5D.read(lat_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL',...
                'H5P_DEFAULT');
lon=H5D.read(lon_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');
height=H5D.read(height_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');
conf=H5D.read(confidence_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');
time10k=H5D.read(time10k_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');

%% apply geophysical corrections, 500 Hz

ATL03_sub2;

%% return only signals
conf_ocean = conf(2,:)'; clear conf;
ind = find(conf_ocean>-1);  
% ind = find(conf_ocean>2); 
ph_lat = lat(ind);
ph_lon = lon(ind);
ph_time = time10k(ind);
ph_height = height(ind);
ph_height_corrected = height(ind) - correction(ind);


%% Read the attributes.
ATTRIBUTE = 'units';
attr_id = H5A.open_name (height_id, ATTRIBUTE);
units_temp = H5A.read(attr_id, 'H5ML_DEFAULT');

ATTRIBUTE = 'long_name';
attr_id = H5A.open_name (height_id, ATTRIBUTE);
long_name_temp = H5A.read(attr_id, 'H5ML_DEFAULT');

%% Close and release resources.
H5A.close(attr_id)
H5D.close(height_id);
H5D.close(lon_id);
H5D.close(lat_id);
H5D.close(confidence_id);
H5D.close(time10k_id);








