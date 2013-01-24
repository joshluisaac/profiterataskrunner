#!/bin/sh

grepExpression="updatessetup|noticessetup|kivsetup|instructionssetup|escalationsetup|caseregistrationsetup|alertsetup|abortreasonsetup"
excludeForms="legalabortreasonsetup.frm|legalalertsetup.frm|legalcaseregistrationsetup.frm|legalescalationsetup.frm|legalinstructionssetup.frm|legalkivsetup.frm|legalnoticessetup.frm|legalupdatessetup.frm"

bashstageDir="bashstage"
destinationFile=legalprocesssetupformlisting.txt
rm -rf $bashstageDir/*
echo "Cleaned Up $bashstageDir"
emptyfile=`cat  /dev/null > legalprocesssetupformlisting.txt`
cd clientconfig-legal

ls | grep .frm | grep legal | grep setup | egrep "$grepExpression" | egrep -v "$excludeForms" > ../$destinationFile

echo "Written Form Listing to $destinationFile"

cd ../

grepstring="_CLEAR_BTN"

emptyfile=`cat  /dev/null > clearbtns.txt`


cat legalprocesssetupformlisting.txt | while read i
do

   cp clientconfig-legal/$i $bashstageDir/$i
   grepFind=`grep "_CLEAR_BTN" $bashstageDir/$i | grep "field name=" | cut -f2 -d\"` 
   
   echo "$grepFind"","$i >> clearbtns.txt
   echo "Copied and Greped  $i"

done



cat clearbtns.txt | while read x


do
   
   cd $bashstageDir
   COLUMN_1=`echo $x | cut -f1 -d\,`
   COLUMN_2=`echo $x | cut -f2 -d\,`
   sed -e "s/$COLUMN_1/CLEAR_NULLIFY_ALL/ig" $COLUMN_2 > $COLUMN_2.xml.tmp
   mv $COLUMN_2.xml.tmp $COLUMN_2
   echo "Modified: " $COLUMN_2
   cd ../

done


sleep 5

cp legalprocesssetupformlisting.txt $bashstageDir/
cd $bashstageDir
cat legalprocesssetupformlisting.txt | xargs cp -u -t /media/allihave/ptrworkspace/bimb-poweragency/clientconfig-legal
echo "***Finished File Synchronization!***"

