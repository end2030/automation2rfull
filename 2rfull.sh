#!/bin/bash
# A script to upscale small bitmaps in PNG format.
echo "Nama Customer :"
read nama
cd $nama
ls | while read upName; do loName=`echo "${upName}" | tr '[:upper:]' '[:lower:]'`; mv "$upName" "$loName"; done
for fimg in *.png; do mv "$fimg" "$(basename "$fimg" .png).jpg"; done
c=1; for b in *.jpg; do new=$(printf "%d.jpeg" "$c"); mv -i -- "$b" "$new"; ((c++)); done
echo "Edit FOTO?"
read edit
i=1
for img in *.jpeg; do
 mogrify -resize 720x1080! $img
convert -brightness-contrast 2x2 $img copy$i.jpeg
composite copy$i.jpeg -gravity center ../image/bgfull2r.png a_$i.jpg
echo $img
rm -rf copy$i.jpeg

((i++))
done
mkdir backup
mv *.jpeg backup/
# echo "next merge horizontal?"
# read yes
c=1
d=2
e=3
h=1
for img in *.jpg; do
convert a_$c.jpg a_$d.jpg +append h_$h.png
convert h_$h.png a_$e.jpg +append h_$h.png
((c=c+3))
echo $c
((d=d+3))
echo $d
((e=e+3))
echo $e
((h=h+1))
echo $h
done
rm -rf *.jpg
# echo "next merge vertical?"
# read yes
x=1
y=2
z=3
r=1
for img in *.png; do
convert h_$x.png h_$y.png -append r_$r.jpg
convert r_$r.jpg h_$z.png -append r_$r.jpg
((x=x+3))
echo $x
((y=y+3))
echo $y
((z=z+3))
echo $z
((r=r+1))
echo $r
done
for img in r*.jpg; do
composite $img ../image/a4.jpg -geometry +160+60 $img
done
rm -rf *.png
convert "*.{jpg}" -quality 100 ${PWD##*/}.pdf
rm -rf *.jpg
cd ../
