#!/bin/tcsh -f
#
rm *.kml
rm filelist*
cd .
ls track1*.xy > filelist1
foreach fname (`cat filelist1`)
  echo $fname
  gmt gmt2kml $fname -Fl -W3p,blue > $fname.kml
  echo "track $fname done!"
end
#
ls track2*.xy > filelist2
foreach fname (`cat filelist2`)
  echo $fname
  gmt gmt2kml $fname -Fl -W3p,red > $fname.kml
  echo "track $fname done!"
end
#
ls track3*.xy > filelist3
foreach fname (`cat filelist3`)
  echo $fname
  gmt gmt2kml $fname -Fl -W3p,yellow > $fname.kml
  echo "track $fname done!"
end
