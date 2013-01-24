#!/bin/sh



file='dateparserresult.xml'

emptyfile=`cat  /dev/null > $file`

( [ -e "$file" ] || touch "$file" ) && [ ! -w "$file" ] && echo cannot write to $file && exit 1

cat _dateType.txt |  while read i


do

#echo $i

format="\"yyyyMMdd\""
dateparser="\"dateparser\""
i="\"$i\""

#MYARG="\"my multiword argument\""

 	y="<exec format=$format from=$i to=$i type=$dateparser/>"
	echo $y >> dateparserresult.xml
done

echo "Finished!"


