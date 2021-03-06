alter session set "_ORACLE_SCRIPT"=true;
create or replace directory oracle_dmp as '/tmp';
create tablespace hybrisSpace datafile '/opt/oracle/oradata/XE/hybrisSpace.dat' size 2048M;
create user hybris_usr identified by hybris_pwd default tablespace hybrisSpace quota 2047M on hybrisSpace;
Grant all privileges to hybris_usr;
