#!/usr/bin/env bash


sqlplus -s <<EOF>> logger.log fcsora_dev/profitera1234@192.168.1.44:1521/orcl44bi
select * from ptruser
EOF
