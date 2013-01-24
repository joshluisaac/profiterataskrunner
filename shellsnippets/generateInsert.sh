#!/usr/bin/env bash

database=db
table=tmpfind

find '/media/allihave/ptrworkspace/bimb-poweragency/serverconfig-legal' -name "*.xml" | (

	echo "BEGIN TRANSACTION;"

	while read -r line ; do
		album=${line%/*} 
                album=${album##*/}
		title=${line##*/}
#echo $album
#echo $title

		echo "INSERT INTO \"$table\" VALUES('$album','$title');"
	done

	echo "COMMIT;"

)  | sqlite3 $database
