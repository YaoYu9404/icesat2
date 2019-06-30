%% main 4 ATL03

FILE_NAME = 'ATL12_20190216000259_07570201_001_01.h5';



[track1, track2, track3] = ATL12_read(FILE_NAME);

figure;
% plot(track1(3293:3485,2), track1(:,3), 'x','MarkerSize',0.5);
% hold on;
% plot(track2(3293:3485,2), track2(:,3), 'x','MarkerSize',0.5);
% hold on;
plot(track3(3293:3485,2), track3(3293:3485,3), 'x','MarkerSize',0.5);

xlabel('latitude','FontSize',14);
ylabel('MSS height (m)','FontSize',14);
set(gca, 'FontSize',14)



%% lon, lat to kml file 
fid = fopen('track1l.xy','w');
ind = floor(linspace(1,size(track1,1),1000));
fprintf(fid,'%f %f \n',[track1(ind,1)'; track1(ind,2)']);
% fprintf(fid,'%f %f \n',[lon(1)'; lat(1)']);
% fprintf(fid,'>\n');
fclose(fid);
% gmt gmt2kml track1l.xy -Fl  -W2p,blue@75 > track1l.kml


fid = fopen('track2l.xy','w');
ind = floor(linspace(1,size(track2,1),1000));
fprintf(fid,'%f %f \n',[track2(ind,1)'; track2(ind,2)']);
% fprintf(fid,'%f %f \n',[lon(1)'; lat(1)']);
% fprintf(fid,'>\n');
fclose(fid);
% gmt gmt2kml track2l.xy -Fl  -W2p,red@75 > track2l.kml


fid = fopen('track3l.xy','w');
ind = floor(linspace(1,size(track3,1),1000));
fprintf(fid,'%f %f \n',[track3(ind,1)'; track3(ind,2)']);
% fprintf(fid,'%f %f \n',[lon(1)'; lat(1)']);
% fprintf(fid,'>\n');
fclose(fid);
% gmt gmt2kml track3l.xy -Fl  -W2p,blue@75 > track3l.kml









