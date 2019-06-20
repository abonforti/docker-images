--ALTER SESSION SET CONTAINER=CUSTOMSCRIPTS;
create tablespace hybrisSpace datafile '/u01/app/oracle/oradata/XE/hybrisSpace.dat' size 2048M;
create user hybris_usr identified by hybris_pwd default tablespace hybrisSpace quota 2047M on hybrisSpace;
Grant all privileges to hybris_usr;


