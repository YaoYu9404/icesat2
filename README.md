# ICESat-2

### download data in a small region: ICESat-2 ATL03 geolocated photon height 

1. go to https://nsidc.org/data/atl03/versions/5 and click NASA Earthdata Search

2. click the square (Search by spatial rectangle) at the right (need to registed for the Earthdata), then put the (lon,lat) of the SW and NE points. For example SW: 5.88, 173.46; NE: 5.93, 173.50. click return and the page will refrash showing matching collection. choosing the one NOT in Earthdata cloud then click "download all".

3. the new page will ask you to select a data access method. I generally do "Direct download". It will lead you to a page ith "Download script" or you can save the download urls. Download data using either the bash script or "wget --user=username --password=yourpassword -i url_file".

4. save the files in a local directory. the files are big, each is about 1-2 GB.

### look at photon heights in Matlab

1. create a directory called "kml" and put xy2kml.com there. Create a directory called "code" to put 4 matlab *.m files:
main4ATL03.m, ATL03_read.m, ATL03_sub1.m, ATL03_sub2.m, main4ATL03_batch.m

2. In main4ATL03.m, you can change the FILE_ADDRESS (where you save files), FILE_NAME, Output_address (where you want to put kml files). You can exam the photon height from each file by running main4ATL03.m. 

3. In ATL03_sub1.m, you can change the confidence level of output photon heights at line 44. 0-noise, 1-buffer, 2-low confidence signal, 3-medium confidence signal, 4-high confidence signal. To examine the topography of coral reef we need all output (default).

4. In ATL03_sub2.m, you can change and decide what geophysical corrections to apply. By default, we will apply ocean tide and DAC corrections. 

5. After running main4ATL03.m, there will be a .xy file containing the lon, lat of three strong beams saved in the kml directory. You can process many ATL03 files using main4ATL03_batch.m. Be sure to make direcotries correct. After processing, go to the kml directory and run ./xy2kml.com, which will create kml files of the lat, lon of each file.

6. Look at the kml using Google Earth and see which file passes through your interested area. Look at that specific file inmain4ATL03.m.



