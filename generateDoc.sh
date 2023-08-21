#!/bin/bash

echo "generate documents"

for f in */;
 do
#    echo  "swift doc generate ./$f/Sources --module-name $f --output ./$f/Documentation --format html";
    dir=$(echo $f | tr "/" "\n")
    echo "--------"
    echo "gen doc $dir"
    swift doc generate ./$dir/Sources --module-name $dir --output ./$dir/Documentation --format html
    echo "--------"
 done



echo "generate documents finish"
