#!/bin/bash

echo "generate documents"

for f in *;
 do
    echo  "swift doc generate ./$f/Sources --module-name $f --output ./$f/Documentation --format html";
    swift doc generate ./$f/Sources --module-name $f --output ./$f/Documentation --format html
 done



echo "generate documents finish"
