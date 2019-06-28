%% subroutine of ATL12_read

%% Open the datasets.
LATFIELD_NAME=[track '/ssh_segments/latitude'];
lat_id=H5D.open(file_id, LATFIELD_NAME);

LONFIELD_NAME=[track '/ssh_segments/longitude'];
lon_id=H5D.open(file_id, LONFIELD_NAME);

DATAFIELD_NAME=[track '/ssh_segments/heights/h'];
height_id=H5D.open(file_id, DATAFIELD_NAME);

%% Read the datasets.
lat=H5D.read(lat_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL',...
                'H5P_DEFAULT');
lon=H5D.read(lon_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');
height=H5D.read(height_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');

%% Read the attributes.
ATTRIBUTE = 'units';
attr_id = H5A.open_name (height_id, ATTRIBUTE);
units_temp = H5A.read(attr_id, 'H5ML_DEFAULT');

ATTRIBUTE = 'long_name';
attr_id = H5A.open_name (height_id, ATTRIBUTE);
long_name_temp = H5A.read(attr_id, 'H5ML_DEFAULT');

%% Close and release resources.
H5A.close (attr_id)
H5D.close (height_id);
H5D.close (lon_id);
H5D.close (lat_id);




