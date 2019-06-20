#!/bin/bash
export LOG_FILE=hybrisDB.dmp.log
export DUMP_FILE=hybrisDB.dmp
su -p oracle -c "impdp hybris_usr/hybris_pwd dumpfile=$DUMP_FILE directory=oracle_dump logfile=$LOG_FILE schemas=HYBRIS_USER REMAP_TABLESPACE=HYBRIS_DEV_DATA:hybrisspace REMAP_SCHEMA=HYBRIS_USER:HYBRIS_USR"