#!/bin/bash

#client config variables
clientPath="/media/allihave/ptrworkspace/bimb-poweragency/clientconfig-legal/"
legal="legal"
setup="setup"

#server config variables
serverPath="/media/allihave/ptrworkspace/bimb-poweragency/serverconfig-legal/"
eventNameGenericSuffix="legalsetupmanager.setup."
eventNameSourcePrefix="auction"
eventNameDestinationPrefix="generic"


firststringrplcargIN1="AUCTIONS"
firststringrplcargIN2="AUCTION"
firststringrplcargOUT="GENERIC"
secondstringrplcargIN=$eventNameSourcePrefix
secondstringrplcargOUT=$eventNameDestinationPrefix
thirdstringrplcargIN="Auction"
thirdstringrplcargOUT="Generic"

sourceprefix=$legal$eventNameSourcePrefix$setup
destinationprefix=$legal$eventNameDestinationPrefix$setup


arrayUI=(
"addtionaldetails.tbl"
".frm"
".tbl"
"add.frm"
"additionaldetailsadd.frm"
"additionaldetailsedit.frm"
"edit.frm"
"templateadd.frm"
"templateedit.frm"
"template.tbl"
"stageadd.frm"
"stageedit.frm"
"substages.tbl"
)

serverConfigArray=(
".getselected.event"
".getsetupdata.event"
".process.event"
".state.process.event"
)

cd $clientPath




bootstrapUIConfigs(){
for suffixvariable in "${arrayUI[@]}"
do

	cat $clientPath$sourceprefix$suffixvariable > $clientPath$destinationprefix$suffixvariable
	echo "Created $destinationprefix$suffixvariable"
	
	i=$destinationprefix$suffixvariable
	
	sed "s/$firststringrplcargIN1/$firststringrplcargOUT/g" < $i > $i.rpcl1
	sed "s/$firststringrplcargIN2/$firststringrplcargOUT/g" < $i.rpcl1 > $i.rpcl2
	sed "s/$secondstringrplcargIN/$secondstringrplcargOUT/g" < $i.rpcl2 > $i.rpcl3
	sed "s/$thirdstringrplcargIN/$thirdstringrplcargOUT/g" < $i.rpcl3 > $i.rpcl4
	
	rm -f $i
	cat $i.rpcl4 > $i
	rm -f $i.rpcl1 $i.rpcl2 $i.rpcl3 $i.rpcl4
	#echo "Replacement completed for $i"

done

#echo "Successfully Created UI Elements"
#echo "Replacement Completed!"
#echo "UI Replication Process is complete. Please proceed to bootstrapcrudprocesses()"

}


bootstrapUIConfigs


cd $serverPath
bootstrapcrudprocesses(){
for is in "${serverConfigArray[@]}"
do

	cat $serverPath$eventNameGenericSuffix$eventNameSourcePrefix$is > $serverPath$eventNameGenericSuffix$eventNameDestinationPrefix$is
	echo "Created $eventNameGenericSuffix$eventNameDestinationPrefix$is"

done

ls | egrep $eventNameDestinationPrefix > eventfilelistings.txt

cat eventfilelistings.txt | while read i

do
sed "s/$firststringrplcargIN2/$firststringrplcargOUT/g" < $i > $i.rpcl1

	rm -f $i
	cat $i.rpcl1 > $i
	rm -f $i.rpcl1
	#echo "Replacement completed for $i"

done
#echo "Server Configs Replacement Completed!"
#echo "Server Configs Replication Process is complete. Please Check!"
echo "***Done!***"
}

bootstrapcrudprocesses


