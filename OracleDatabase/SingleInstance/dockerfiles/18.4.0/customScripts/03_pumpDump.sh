#!/bin/bash
export LOG_FILE=hybrisDB.dmp.log
export DUMP_FILE=hybrisDB.dmp
su -p oracle -c "impdp hybris_usr/hybris_pwd dumpfile=$DUMP_FILE directory=oracle_dmp logfile=$LOG_FILE" 
