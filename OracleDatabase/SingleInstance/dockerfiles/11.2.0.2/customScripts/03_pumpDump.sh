#!/bin/bash
export SHARED_FOLDER=/u01/app/oracle/scripts/setup
export LOG_FILE=hybrisDB.dmp.log
export DUMP_FILE=hybrisDB.dmp
export DB_DIR=/u01/app/oracle/admin/XE/dpdump/
echo $DB_DIR
#cp /u01/app/oracle/scripts/setup/hybrisDB.dmp $DB_DIR
su -p oracle -c "impdp hybris_usr/hybris_pwd dumpfile=$DUMP_FILE logfile=$LOG_FILE schemas=HYBRIS_USER directory=DATA_PUMP_DIR REMAP_TABLESPACE=HYBRIS_DEV_DATA:hybrisspace REMAP_SCHEMA=HYBRIS_USER:HYBRIS_USR"