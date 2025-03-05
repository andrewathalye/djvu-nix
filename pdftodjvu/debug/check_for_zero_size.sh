#!/usr/bin/env bash
while read LINE
do
   IFS=',' read -a array <<< "$LINE"
   # h1 v1 h2 v2

   if [[ ${array[0]} -eq ${array[2]} ]] then
      echo $LINE
      echo HCOORDS
      exit
   fi

   if [[ ${array[1]} -eq ${array[3]} ]] then
      echo $LINE
      echo VCOORDS
      exit
   fi

done <<< `xsltproc print_coords.xml $1`
