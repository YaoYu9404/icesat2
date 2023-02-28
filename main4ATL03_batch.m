%% main 4 ATL03 photon heights
% comment out line 40 in ATL03_sub1.m if not applying geophysical correction

% close all
clear
clc

%% batch process
h5file_address = '/Volumes/SWOT/Pacific/ATL03_h5/'
png_address = '/Volumes/SWOT/Pacific/ATL03_png/';
kml_address = '/Volumes/SWOT/Pacific/ATL03_kml/';
trk_address = '/Volumes/SWOT/Pacific/ATL03_trk/';

list = dir(fullfile(h5file_address,'ATL03*.h5'));
k=length(list);


for ind_file = 1:k
      fname = char(list(ind_file).name);
      FILE_NAME = strcat(h5file_address, fname);
      info = h5info(FILE_NAME);
      [track1, track2, track3, orient] = ATL03_read(FILE_NAME,fname,png_address);

%% track1/2/3: 3 columns
% lon; lat; corrected photon height with reference to WGS84
%% orient: 1-forward, r-strong beam; 0-background, l-strong beam

if (orient<0.5)
    or = 'l';
else
    or = 'r';
end


%{
figure; 
plot(track1(ind1,2), track1(ind1,3), '.','MarkerSize',0.5,'Color',[0 0 1]); hold on;
plot(track2(ind2,2), track2(ind2,3), '.','MarkerSize',0.5,'Color',[1 0 0]); hold on; 
plot(track3(ind3,2), track3(ind3,3), '.','MarkerSize',0.5,'Color',[1 1 0]);
legend(['1',or],['2',or],['3',or]);
xlabel('latitude','FontSize',14);
ylabel('photon height (m)','FontSize',14);
set(gca, 'FontSize',14)
%}

%% lon, lat to kml file 
for ind_out = 1:3
    kmlname = [kml_address,'track', int2str(ind_out),or,'_',fname(7:29),'.xy'];
    fid = fopen(kmlname,'w');
    track = eval(['track',int2str(ind_out)]);    
    ind = floor(linspace(1,size(track,1),1000));
    fprintf(fid,'%f %f \n',[track(ind,1)'; track(ind,2)']);
    fclose(fid);
end
% cd ../kml
% xy2kml.com


clear ind1 ind2 ind3 ind track*
end

