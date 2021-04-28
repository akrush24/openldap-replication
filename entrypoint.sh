#!/bin/sh
/usr/sbin/slapadd -F /etc/openldap/slapd.d -b 'cn=config' -l /etc/openldap/conf.d/slapd.ldif
/usr/sbin/slapd -h "ldapi://%2Fvar%2Frun%2Fopenldap%2Fldapi ldap://${HOSTNAME}:389/" -F /etc/openldap/slapd.d -d 32768
