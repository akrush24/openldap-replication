#!/bin/sh
echo LDAP01
docker exec -ti ldap01 ldapsearch -h ldap01.srv.local:389 -w 123 -x -D cn=config -b cn=config|grep ^olcRootDN
