#!/bin/bash
mkdir -vp 01/data/db.{1..99}

docker-compose up -d --build
sleep 1
docker exec -ti ldap01 time ./addnewdb.sh
