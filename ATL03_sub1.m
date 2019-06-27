%% subroutine of ATL03_read

%% Open the datasets.
LATFIELD_NAME=[track '/heights/lat_ph'];
lat_id=H5D.open(file_id, LATFIELD_NAME);

LONFIELD_NAME=[track '/heights/lon_ph'];
lon_id=H5D.open(file_id, LONFIELD_NAME);

DATAFIELD_NAME=[track '/heights/h_ph'];
temp_id=H5D.open(file_id, DATAFIELD_NAME);

%% Read the datasets.
lat=H5D.read(lat_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL',...
                'H5P_DEFAULT');
lon=H5D.read(lon_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');
temp=H5D.read(temp_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');

%% Read the attributes.
ATTRIBUTE = 'units';
attr_id = H5A.open_name (temp_id, ATTRIBUTE);
units_temp = H5A.read(attr_id, 'H5ML_DEFAULT');

ATTRIBUTE = 'long_name';
attr_id = H5A.open_name (temp_id, ATTRIBUTE);
long_name_temp = H5A.read(attr_id, 'H5ML_DEFAULT');

%% Close and release resources.
H5A.close (attr_id)
H5D.close (temp_id);
H5D.close (lon_id);
H5D.close (lat_id);



