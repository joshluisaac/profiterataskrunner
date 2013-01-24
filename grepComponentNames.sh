#!/bin/sh


grepExpressionSearch="generic|sendnotice|kivsetup|bankinstruction|escalationsetup|alertsetup|abortreasonsetup"

excludeUI=".tbl|legalabortreasonsetup.frm|legalalertsetup.frm|legalcaseregistrationsetup.frm|legalescalationsetup.frm|legalinstructionssetup.frm|legalkivsetup.frm|legalnoticessetup.frm|legalupdatessetup.frm|legalgenericsetup.frm"

grepExpression="com.profitera.gui.coll.treatmentworkpad.ListQueryComboEditor|com.profitera.form.editors.TextFieldEditor|com.profitera.form.editors.CheckboxFieldEditor|com.profitera.form.editors.CurrencyEditor|com.profitera.form.editors.LongFieldEditor"


grepstring="_EDIT"
clientconfigDir=clientconfig-legal

emptyfile=`cat  /dev/null > editfields.txt`


egrep -vrl "$excludeUI" ./*.frm |  egrep -rl "$grepExpressionSearch" ./*.frm | egrep -rl "$grepExpression" ./*.frm  | while read i

do

   
   #grepFind=`grep "$grepstring" $clientconfigDir/$i | egrep -v "SAVE|CLOSE|BTN" | grep "field name="`
   #echo "$grepFind" >> editfields.txt
   echo "Copied and Greped  $i"

done
