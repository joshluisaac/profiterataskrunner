#!/bin/sh



filepath="/media/allihave/ptrworkspace/bimb-poweragency/clientconfig/"

cd $filepath

cat /dev/null > fileout.txt
cat /dev/null > fileout2.txt
cat /dev/null > fileout3.txt
grep -rl "com.profitera."  ./*.frm | while read i

do

	grep "implementation=" $i | cut -f2 -d\" >> fileout.txt

done


sort  fileout.txt | uniq > fileout2.txt


cat fileout2.txt | while read x

do 

i="\"$x\""

y="<keep pattern=$i />"
echo $y >> fileout3.txt

done


