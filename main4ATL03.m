%% main 4 ATL03 photon heights
% comment out line 40 in ATL03_sub1.m if not applying geophysical correction

close all
clear
clc

FILE_ADDRESS = '/Users/yayu/Desktop/icesat2_reef/';
% FILE_NAME = 'ATL03_20210927122357_00771307_005_01.h5';
FILE_NAME = 'ATL03_20201229012416_00771007_005_01.h5';
% FILE_NAME = 'ATL03_20191001230518_00770507_005_01.h5';
% FILE_NAME = 'ATL03_20190102120556_00770207_005_01.h5';
info = h5info([FILE_ADDRESS, FILE_NAME]);
[track1, track2, track3, orient] = ATL03_read([FILE_ADDRESS, FILE_NAME]);

%% track1/2/3: 3 columns
% lon; lat; corrected photon height with reference to geoid
%% orient: 1-forward, r-strong beam; 0-background, l-strong beam

if (orient<0.5)
    or = 'l';
else
    or = 'r';
end


figure;
plot(track1(:,2), track1(:,3), '.','MarkerSize',0.5,'Color',[0 0 1]);
hold on;
plot(track2(:,2), track2(:,3), '.','MarkerSize',0.5,'Color',[1 0 0]);
hold on;
plot(track3(:,2), track3(:,3), '.','MarkerSize',0.5,'Color',[1 1 0]);
legend(['1',or],['2',or],['3',or]);
xlabel('latitude','FontSize',14);
ylabel('photon height (m)','FontSize',14);
set(gca, 'FontSize',14)




%% plot photons with |height| < 40m

% figure; ind1 = find(abs(track1(:,3))<40); 
% plot(track1(ind1,2), track1(ind1,3), '.','MarkerSize',0.5,'Color',[0 0 1]);
% hold on; ind2 = find(abs(track2(:,3))<40); 
% plot(track2(ind2,2), track2(ind2,3), '.','MarkerSize',0.5,'Color',[1 0 0]);
% hold on; ind3 = find(abs(track3(:,3))<40); 
% plot(track3(ind3,2), track3(ind3,3), '.','MarkerSize',0.5,'Color',[1 1 0]);
% legend(['1',or],['2',or],['3',or]);
% xlabel('latitude','FontSize',14);
% ylabel('photon height (m)','FontSize',14);
% set(gca, 'FontSize',14)



%% lon, lat to kml file 
% Output_address = '/Users/yayu/Documents/MATLAB/ICESAT/kml/';
Output_address = '/Users/yayu/Desktop/icesat2_reef/kml/';
for ind_out = 1:3
    kmlname = [Output_address,'track', int2str(ind_out),or, FILE_NAME(6:29),'.xy'];
    fid = fopen(kmlname,'w');
    track = eval(['track',int2str(ind_out)]);    
    ind = floor(linspace(1,size(track,1),1000));
    fprintf(fid,'%f %f \n',[track(ind,1)'; track(ind,2)']);
    fclose(fid);
end
% cd ../kml
% xy2kmkl.com



%% lon, lat, photon height to .trk file 
              
% Output_address = '/Users/yayu/Documents/MATLAB/ICESAT/trk/';
% for ind_out = 1:3
%     trkname = [Output_address,'track', int2str(ind_out),or, FILE_NAME(6:29),'.trk'];
%     fid = fopen(trkname,'w');
%     ind = eval(['ind',int2str(ind_out)]);
%     track = eval(['track',int2str(ind_out)]);
%     fprintf(fid,'%f %f %f\n',track(ind,:)');
%     fclose(fid);
% end
