#!/bin/sh


grepExpression="legalabortreasonsetupadditionaldetailsadd.frm|legalabortreasonsetupadditionaldetailsedit.frm|legalabortreasonsetuptemplateadd.frm|legalabortreasonsetuptemplateedit.frm|legalalertsetupadditionaldetailsadd.frm|legalalertsetupadditionaldetailsedit.frm|legalalertsetuptemplateadd.frm|legalalertsetuptemplateedit.frm|legalescalationsetupadditionaldetailsadd.frm|legalescalationsetupadditionaldetailsedit.frm|legalescalationsetuptemplateadd.frm|legalescalationsetuptemplateedit.frm|legalkivsetupadditionaldetailsadd.frm|legalkivsetupadditionaldetailsedit.frm|legalkivsetuptemplateadd.frm|legalkivsetuptemplateedit.frm"

clientconfigDir=clientconfig-legal

cd $clientconfigDir
destinationFile=fordelete.txt

ls | egrep $grepExpression > ../$destinationFile 

cd ../

cd $clientconfigDir
cat ../$destinationFile | while read i

do
 
  rm -rf $i
  echo "Deleted:  $i"

done

