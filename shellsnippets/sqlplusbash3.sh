#!/usr/bin/env bash

sqlplus >> logger.log fcsora_dev/profitera1234@192.168.1.44:1521/orcl44bi < test.sql
