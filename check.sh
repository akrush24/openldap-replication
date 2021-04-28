#!/bin/sh
echo LDAP01
docker exec -ti ldap01 ldapsearch -h ldap01.srv.local:389 -w 123 -x -D cn=config -b cn=config|grep ^olcRootDN|wc -l
echo LDAP02
docker exec -ti ldap02 ldapsearch -h ldap02.srv.local:389 -w 123 -x -D cn=config -b cn=config|grep ^olcRootDN|wc -l
echo LDAP03
docker exec -ti ldap03 ldapsearch -h ldap03.srv.local:389 -w 123 -x -D cn=config -b cn=config|grep ^olcRootDN|wc -l
