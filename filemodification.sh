#!/bin/bash





cd clientconfig-legal
ls |grep .frm| egrep "setuptemplate|setupaddtional|setupadd|setupedit" > filelistings.txt

cat filelistings.txt | while read i

do

#echo "Processing " $i
sed 's/save_18/save1_18/g' < $i > $i.rpcl1
sed 's/close_18/cancel_18/g' < $i.rpcl1 > $i.rpcl2


sed 's/caseregistration/snippet/g' < $i.rpcl2 > $i.rpcl3


rm -f $i
cat $i.rpcl2 > $i
rm -f $i.rpcl1 $i.rpcl2 $i.rpcl3
echo "Replacement completed for $i"

done

echo "Process Complete!"

