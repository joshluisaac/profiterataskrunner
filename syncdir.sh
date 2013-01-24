#!/bin/bash
# Written by Joshua U Luisaac
# joshluisaac@gmail.com

echo "File Synchronization Will Start In 2 seconds"

sleep 2

cat legalconfig.txt | xargs cp -u -t /media/allihave/ptrworkspace/bimb-poweragency/clientconfig-legal-bak 

#&& cat legalserverconfig.txt | xargs cp -u  -t /media/allihave/ptrworkspace/bimb-poweragency/serverconfig-legal

cat legalconfig.txt | while read filename
do

	rm -f $filename
	echo "Deleting $filename"

done




echo "Finished File Synchronization!"
