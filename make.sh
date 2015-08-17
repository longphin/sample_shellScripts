#!/bin/bash
# Longphi Nguyen

errorMessage="usage: makemake.sh executable_name"
gpp="g++ -ansi -Wall -g -c -O2 -g"
mk="Makefile"

#
# =================== Checks =====================
#

# check if number of inputs is valid
if [ $# -ne 1 ]; then
   echo "Executable name required."
   echo $errorMessage
   exit 1
fi

#
# =================== Use ========================
#

# output file
>$mk #initializes the file (clears all content if exists)
echo -n "$1 : " >> $mk

for fn in *.c; do
   echo -n "${fn%c}o " >> $mk
done

echo -e -n "\n\tg++ -ansi -Wall -g -o $1 -O2 -g " >> $mk

for fn in *.c; do
   echo -n "${fn%c}o " >> $mk
done

echo "" >> $mk

# dependencies
for fn in *.c; do
   echo -e -n "\n${fn%c}o : $fn " >> $mk

   # get dependencies
   dep=`grep -E "^#include[ ]*\".+\"" "$fn"`

   dep2=`echo -e -n "$dep" | sed 's/^#include *"\(.*\)*"/\1/g' | tr '\n' ' '`
   echo -e "$dep2" >> $mk
   echo -e "\t$gpp $fn" >> $mk
done

echo -e -n "\nclean : \n\trm -f $1 " >> $mk

for fn in *.c; do
   echo -n "${fn%c}o " >> $mk
done

echo "" >> $mk

