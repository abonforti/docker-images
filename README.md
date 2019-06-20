### How to configure Oracle XE

Following this instructions you will be able to configure Oracle Database XE (Express Edition) supporting the following versions:

 - 11.2.0.2
 - 18.4.0

# Files Needed

Depending on the version you are building, you will require:

*   oracle-database-xe-18c-1.0-1.x86_64.rpm 

		SHA256: 308c044444342b9a3a8d332c68b12c540edf933dc8162d8eda3225e662433f1b

*   oracle-xe-11.2.0-1.0.x86_64.rpm.zip
		SHA256: b5039fad2e4f92c68778dcabbd0b4622a6cb025f25f7d6222f9e9de53ebab531
		
* Dump file of Hybris database that **must be called** hybrisDB.dmp

# Build the container
For 11g execute the following command:
```
cd ${REPO_PATH}/OracleDatabase\SingleInstance\dockerfiles
./buildDockerImage.sh -x -v 11.2.0.2 -i -o "--memory=1g --memory-swap=2g"
```

For 18c execute the following command:
```
cd ${REPO_PATH}/OracleDatabase\SingleInstance\dockerfiles
./buildDockerImage.sh -x -v 18.4.0 -i -o "--memory=1g --memory-swap=2g"
```

Once you have built it, identify a folder on your host system where to store the persisted database (e.g. it will not be recreated at the next container restart, in this example, it's supposed to be ~/Development/database)

Running a 11g container:

```
docker run --name oracle-xe -p 1521:1521 -p 5500:5500 -e ORACLE_PWD=oracle -v ${REPO_PATH}\OracleDatabase\SingleInstance\dockerfiles\11.2.0.2\customScripts:/u01/app/oracle/scripts/setup --shm-size="2g"  oracle/database:11.2.0.2-xe
```

Running a 18c container:

```
docker run --name oracle-xe-18c -p 1521:1521 -p 5500:5500 -e ORACLE_SID=XE -e ORACLE_PWD=oracle -v ~/Development/database:/opt/oracle/oradata -v ${REPO_PATH}/OracleDatabase/SingleInstance/dockerfiles/18.4.0/customScripts:/docker-entrypoint-initdb.d/setup --shm-size="2g" oracle/database:18.4.0-xe
```

Finally, connect hybris using the following properties:
```
db.driver=oracle.jdbc.driver.OracleDriver
db.username=hybris_usr
db.password=hybris_pwd
db.url=jdbc:oracle:thin:@localhost:1521:XE
```

Put the following json file under your ${HYBRIS_DIR}/bin/platform and name it *systemupdate.json*:

```json
{
  "init": "Go",
  "initmethod": "update",
  "essential": "true",
  "localizetypes": "true",
  "backoffice_sample": "true",
  "hmcore_sample": "true",
  "hmbackoffice_sample": "true",
  "basecommerce_create geocoding cron job": [
    "no"
  ],
  "hmcore_hm-asia": [
    "yes"
  ],
  "hmcore_hm-mktp": [
    "yes"
  ],
  "hmcore_hm-america": [
    "yes"
  ],
  "hmcore_hm-europe3": [
    "yes"
  ],
  "hmcore_hm-europe2": [
    "yes"
  ],
  "hmcore_hm-europe5": [
    "yes"
  ],
  "hmcore_hm-europe": [
    "yes"
  ],
  "hmcore_2": [
    "yes"
  ],
  "hmcore_3": [
    "no"
  ],
  "hmcore_1": [
    "yes"
  ],
  "hmcore_4": [
    "no"
  ],
  "hmcore_5": [
    "yes"
  ],
  "hmcore_6": [
    "no"
  ],
  "hmcockpits_importCustomReports": [
    "yes"
  ],
  "filteredPatches": "true"
}
```
And perform a full system update via ant command
```
cd ${HYBRIS_DIR}/bin/platform
. ./setantenv.sh
ant updatesystem -DconfigFile=systemupdate.json
```

# Hint
To start the container in detached mode and auto start it when the OS starts, add the following parameters: *--restart always --detach* just after the aforementioned *-p argument*