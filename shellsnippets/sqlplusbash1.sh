#!/usr/bin/env bash

#This script will execute the statements in the .sql files

sqlplus -s admin/password << EOF
whenever sqlerror exit sql.sqlcode;
set echo off 
set heading off

@pl_script_1.sql
@pl_script_2.sql

exit;
EOF
