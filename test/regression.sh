#!/bin/bash

#   Name: Oshan Karki                   Year: Spring 2021
#   Course: Compiler Construction       

#   set assignment number
hw=hw6

for FILE in test_files/${hw}_test_files/*.c-; do 
  
    echo -e '\n'
    touch test_files/output.out
    file_name=$(basename -- "$FILE")

    echo "====================================" >> test_files/output.out
    echo "FILE: $file_name" >> test_files/output.out
    output_file=${file_name%.*}
  
    ./c- -M $FILE >> test_files/output.out
    diff --width=230 -y test_files/output.out test_files/${hw}_test_files/${output_file}.out

    rm test_files/output.out

done


# done
