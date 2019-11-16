%% subroutine of ATL03_read
% get geophysical corrections to photon height
% read 500 Hz geoid, ocean tide, dac
% interpolate and then add them together to get 10k Hz total correction
% return correction;
%
%% get id
GEOIDFIELD_NAME=[track '/geophys_corr/geoid'];
geoid_id=H5D.open(file_id, GEOIDFIELD_NAME);

OCEANTIDEFIELD_NAME=[track '/geophys_corr/tide_ocean'];
oceantide_id=H5D.open(file_id, OCEANTIDEFIELD_NAME);

DACFIELD_NAME=[track '/geophys_corr/dac'];
dac_id=H5D.open(file_id, DACFIELD_NAME);

TIME500FIELD_NAME=[track '/geophys_corr/delta_time'];
time500_id=H5D.open(file_id, TIME500FIELD_NAME);

%% read heophysical corrections, 500 Hz
geoid=H5D.read(geoid_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');  
oceantide=H5D.read(oceantide_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');         
dac=H5D.read(dac_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');   
         
time500 = H5D.read(time500_id,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', ...
             'H5P_DEFAULT');   
         
H5D.close (geoid_id);
H5D.close (oceantide_id);
H5D.close (dac_id);
H5D.close (time500_id);


%% make geophysical corrections
%% return correction;
% all the four corrections are pretty smooth. we dump those fillvalues
% (3.4028235e+38) and interpolate to match the 10k Hz photon height measurement.
n_10k = length(time10k);
corr_geoid = zeros(n_10k,1);
corr_oceantide = zeros(n_10k,1);
corr_dac = zeros(n_10k,1);
correction = zeros(n_10k,1);

% geoid
ind_geoid = find(abs(geoid) < 1000);
new_geoid = geoid(ind_geoid);
new_time = time500(ind_geoid);

corr_geoid = interp1(new_time, new_geoid, time10k,'spline');
clear ind_geoid new_geoid new_time

% ocean tide
ind_oceantide = find(abs(oceantide) < 1000);
new_oceantide = oceantide(ind_oceantide);
new_time = time500(ind_oceantide);

corr_oceantide = interp1(new_time, new_oceantide, time10k,'spline');
clear ind_oceantide new_oceantide new_time

% dac
ind_dac = find(abs(dac) < 1000);
new_dac = dac(ind_dac);
new_time = time500(ind_dac);

corr_dac = interp1(new_time, new_dac, time10k,'spline');
clear ind_dac new_dac new_time


correction = corr_geoid + corr_oceantide + corr_dac;
clear geoid oceantide dac time500
clear corr_geoid corr_oceantide corr_dac



