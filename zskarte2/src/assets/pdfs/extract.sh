#!/bin/sh
for i in $(seq 1 2 $(pdfinfo "$1" | grep Pages | cut -f2 -d:)); do
    pdfjam -q "$1" $i,$(expr $i + 1) -o temp.pdf
    name=$(pdftotext temp.pdf - | head -n1 | sed 's|/|-|g;s/ /_/g')
    name=$(echo $name | sed -E 's/(Objektblatt_Notfalltreffpunkt)_(.*)/\2_\1/')
    echo $name
    mv temp.pdf "$name.pdf"
done
