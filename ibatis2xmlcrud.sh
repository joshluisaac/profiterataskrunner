#!/bin/bash

#Developed By joshluisaac@gmail.com


#clone_like

# Check 3 arguments are given #
if [ $# -lt 2 ]
then
        echo "Usage : $0 inputfilename outputfilename"
        exit
fi

# Check the given file is exist #
if [ ! -f $1 ]
then
        echo "Filename given \"$1\" doesn't exist"
        exit
fi

tmpFileName="tmp.txt"
cat /dev/null > $tmpFileName
cat /dev/null > $2
i=0
iclone=$i

#echo "Please enter your table name: "
#read TABLENAME;
#echo "Do you have a sequence to autogenerate your primary keys? (Y|N): "
#read SEQUENCE_NAME_ANS

#if [ $SEQUENCE_NAME_ANS == "Y" ] || [ $SEQUENCE_NAME_ANS == "N" ]
#  then 
#    echo "Enter your sequence name: "
#    read SEQUENCE_NAME
#else 
#    echo "Enter a valid answer. Options are (Y|N). Y for Yes, N for No"
#    read SEQUENCE_NAME_ANS
#fi

tablename="PTRWLG_ACCOUNT_HOST_HISTORY"
tblalias="pahh"
sequenceName="PTRWLG_ACC_HOST_HISTORY_ID"
selectQuery="getWlgAccountHostHistory"
insertQuery="insertWlgAccountHostHistory"
updateQuery="updateWlgAccountHostHistory"
deleteQuery="deleteWlgAccountHostHistory"

egrep -vie  "ptr|\)" $1 | cut -f1 -d\ >> $tmpFileName

maxRowCount=`wc -l $tmpFileName | cut -f1 -d\ ` 


SCRIPT_NAME=$0
ARG_1=$1
ARGS_ALL=$*

function stuff {
  # use script args via the variables you saved
  # or the function args via $
  echo $0 $*
}




function generateinsert(){

echo " <insert id=\"$insertQuery\" parameterClass=\"map\">" >> $2
echo  "   <selectKey resultClass=\"long\" keyProperty=\"ID\">" >> $2
echo   "    <include refid=\"sequencePrefix\"/>$sequenceName<include refid=\"sequenceSuffix\"/>" >> $2
echo  "   </selectKey>" >> $2

i=`expr $i + 1`
echo "  INSERT INTO $tablename (" >> $2
cat $tmpFileName | while read l

do

 if [ "$i" -lt $maxRowCount ]; then
    echo "   "$l"," >> $2
   i=`expr $i + 1`
 elif [ "$i" -eq $maxRowCount ]; then
   echo "   "$l") VALUES" >> $2
   i=0
 fi
 
done


echo "  (" >> $2
cat $tmpFileName | while read h

do

 if [ "$i" -lt $maxRowCount ]; then
   echo "   ""#"$h"#," >> $2
   i=`expr $i + 1` 
 elif [ "$i" -eq $maxRowCount ]; then
   echo "   ""#"$h"#"")" >> $2
   i=0 
 fi
 
done

echo " </insert>" >> $2

#echo "No. of lines in inputfile: $maxRowCount" 
#echo "Name of input file $1"
echo "Output written to $2"

echo "Ibatis mapping: Generated insert fragment"
}


function generateselect(){
echo " " >> $2
echo "<resultMap id=\"$selectQuery\" class=\"hmap\">" >> $2
egrep -vie  "ptr|\)"  $1 | awk -F" " '{ print $1,$2 }' | while read gs1

do

FIELD_NAME=`echo $gs1 | cut -f1 -d\ `
DATA_TYPE=`echo $gs1 | cut -f2 -d\ | cut -f1 -d\,`

case "$DATA_TYPE" in

int|INT|bigint|BIGINT|NUMERIC|NUMBER|LONG) 
    DATA_TYPE="java.lang.Long"
    ;;
SMALLINT|smallint) 
    DATA_TYPE="java.lang.Long"
    ;;
db) 
    DATA_TYPE="java.math.BigDecimal"
    ;;
date|DATE|Date) 
    DATA_TYPE="java.util.Date"
    ;;
TIMESTAMP|timestamp) 
    DATA_TYPE="java.sql.Timestamp"
    ;;
string|VARCHAR) 
     DATA_TYPE="java.lang.String"
    ;;
*) echo "Invalid option replaced with java.lang.String" 
   DATA_TYPE="java.lang.String"
   ;;
esac


echo "<result property=\"$FIELD_NAME\" javaType=\"$DATA_TYPE\"/>"  >> $2

done

echo "</resultMap>" >> $2


echo " " >> $2
echo "<select id=\"$selectQuery\" resultMap=\"$selectQuery\" parameterClass=\"map\">" >> $2
echo "SELECT" >> $2
egrep -vie  "ptr|\)"  $1 | awk -F" " '{ print $1,$2 }' | while read gs1

do

FIELD_NAME=`echo $gs1 | cut -f1 -d\ `


echo $tblalias"."$FIELD_NAME","  >> $2

done

echo "FROM $tablename $tblalias"  >> $2
echo "</select>" >> $2
echo "Ibatis mapping: Generated select fragment"
}





function generateupdate(){

echo " " >> $2
echo "<update id=\"$updateQuery\" parameterClass=\"map\">" >> $2
echo "UPDATE $tablename SET" >> $2
egrep -vie  "ptr|\)"  $1 | awk -F" " '{ print $1,$2 }' | while read update

do

FIELD_NAME=`echo $update | cut -f1 -d\ `


echo "$FIELD_NAME" " = "  "#"$FIELD_NAME"#,"  >> $2

done

echo "WHERE ID = #ID#"  >> $2
echo "</update>" >> $2
echo "Ibatis mapping: Generated update fragment"
}


function generatedelete(){

echo "xxxx"

}


generateinsert $1 $2
generateselect $1 $2
generateupdate $1 $2

echo "Output written to $2"
#stuff $2

