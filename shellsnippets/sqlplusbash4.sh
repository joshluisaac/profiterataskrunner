#!/bin/bash

#set colsep ,     -- separate columns with a comma
#set pagesize 0   -- only one header row
#set trimspool on -- remove trailing blanks
#set headsep off  -- this may or may not be useful...depends on your headings.
#set linesize X   -- X should be the sum of the column widths
#set numw X       -- X should be the length you want for numbers (avoid scientific notation on IDs)


sqlplus -silent <<SQLScript
fcsora_dev/profitera1234@192.168.1.44:1521/orcl44bi
whenever sqlerror exit sql.sqlcode;
SET PAGESIZE 0
SET NEWPAGE 0
SET SPACE 0
SET LINESIZE 80
SET ECHO OFF
SET FEEDBACK OFF
SET VERIFY OFF
SET HEADING OFF
SET MARKUP HTML OFF SPOOL OFF
SET COLSEP ','




spool sqloutput.txt

DESC  ptrstate_ref;

spool off
exit
SQLScript


#To redirect connection error to a log file include >> filename
#sqlplus -s <<EOF>> logger.log fcsora_dev/profitera1234@192.168.1.44:1521/orcl44bi
#select * from ptruser
#EOF
