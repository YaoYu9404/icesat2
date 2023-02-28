# icesat2

### download data in a small region: ICESat-2 ATL03 geolocated photon height 

1. go to https://nsidc.org/data/atl03/versions/5 and click NASA Earthdata Search

2. click the square (Search by spatial rectangle) at the right (need to registed for the Earthdata), then put the (lon,lat) of the SW and NE points. For example SW: 5.88, 173.46; NE: 5.93, 173.50. click return and the page will refrash showing matching collection. choosing the one NOT in Earthdata cloud then click "download all".

3. the new page will ask you to select a data access method. I generally do "Direct download". It will lead you to a page ith "Download script" or you can save the download urls. Download data using either the bash script or "wget --user=username --password=yourpassword -i url_file".

4. save the files in a local directory. the files are big, each is about 1-2 GB.

### look at photon heights

2. create a directory called "kml" and a directory called "code" to put 4 matlab *.m files:
main4ATL03.m, ATL03_read.m, ATL03_sub1.m, ATL03_sub2.m

3. 

iceasat2 codes

main4ATL03.m calls ATL03_read.m
               generates .xy path file (need to go to ../kml to generate .kml)

main4ATL12.m calls ATL12_read.m
               generates .xy path file (need to go to terminal to generate .kml)
