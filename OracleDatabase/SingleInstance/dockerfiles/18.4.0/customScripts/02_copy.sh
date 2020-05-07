export SHARED_FOLDER=/docker-entrypoint-initdb.d/setup/
export LOG_FILE=hybrisDB.dmp.log
export DUMP_FILE=hybrisDB.dmp
export DB_DIR=/opt/oracle/admin/XE/dpdump/
mkdir -p $DB_DIR
mv /docker-entrypoint-initdb.d/setup/hybrisDB.dmp /tmp