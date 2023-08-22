#!/bin/bash

echo "generate documents"

for f in */;
 do
#    echo  "swift doc generate ./$f/Sources --module-name $f --output ./$f/Documentation --format html";
    dir=$(echo $f | tr "/" "\n")
    echo "--------"
    echo "gen doc $dir"
    swift doc generate ./$dir/Sources --module-name $dir --output ./Documentation/$dir --base-url /Documentation/$dir/ --format commonmark
    echo "--------"
 done



echo "generate documents finish"
