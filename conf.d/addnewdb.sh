#!/bin/sh

PROVIDER1=ldap://ldap01.srv.local:389
PROVIDER2=ldap://ldap02.srv.local:389
PROVIDER3=ldap://ldap03.srv.local:389
RID=1

DB_COUNT="${1:-333}"

for ID in $(seq 1 ${DB_COUNT}); do
  RID1="$(printf %03d ${RID})"
  RID=$((RID+1))
  RID2="$(printf %03d ${RID})"
  RID=$((RID+1))
  RID3="$(printf %03d ${RID})"
  DBDIR=/var/lib/openldap/openldap-data/db.${ID}
  mkdir -p ${DBDIR}
  SUFFIX="dc=devmail${ID},dc=srv,dc=local"

  ldapmodify -a -H ldapi://%2Fvar%2Frun%2Fopenldap%2Fldapi -Y EXTERNAL <<EOF!
dn: olcDatabase={${ID}}mdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcDatabase: {${ID}}mdb
olcSuffix: ${SUFFIX}
olcDbMaxSize: 1073741824
olcRootDN: cn=admin,${SUFFIX}
olcRootPW: 123
olcDbDirectory: ${DBDIR}
olcDbIndex: objectClass eq
olcSyncRepl:
  rid=${RID1}
  provider=${PROVIDER1}
  binddn=cn=admin,${SUFFIX}
  bindmethod=simple
  credentials=123
  searchbase=${SUFFIX}
  type=refreshAndPersist
  retry="5 5 300 5"
  timeout=1
olcSyncRepl:
  rid=${RID2}
  provider=${PROVIDER2}
  binddn=cn=admin,${SUFFIX}
  bindmethod=simple
  credentials=123
  searchbase=${SUFFIX}
  type=refreshAndPersist
  retry="5 5 300 5"
  timeout=1
olcSyncRepl:
  rid=${RID3}
  provider=${PROVIDER3}
  binddn=cn=admin,${SUFFIX}
  bindmethod=simple
  credentials=123
  searchbase=${SUFFIX}
  type=refreshAndPersist
  retry="5 5 300 5"
  timeout=1
olcMirrorMode: TRUE

dn: olcOverlay=syncprov,olcDatabase={${ID}}mdb,cn=config
objectClass: olcOverlayConfig
objectClass: olcSyncProvConfig
olcOverlay: syncprov
EOF!

  ldapadd -H ldapi://%2Fvar%2Frun%2Fopenldap%2Fldapi -x -D "cn=admin,${SUFFIX}" -w 123 <<EOF!
dn: ${SUFFIX}
changetype: add
objectClass: top
objectClass: dcObject
objectClass: organization
dc: devmail${ID}
o: Example Corporation
description: The Example Corporation

dn: ou=users,${SUFFIX}
changetype: add
objectClass: top
objectClass: organizationalUnit
ou: Users
description: Simple Group

dn: cn=user01,ou=users,${SUFFIX}
changetype: add
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: user01
ou: Users
userPassword: 01010101
description: Simple User
EOF!

done
