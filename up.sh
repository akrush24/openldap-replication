#!/bin/bash
mkdir -v 01/data/db.{1..400}
mkdir -v 02/data/db.{1..400}
mkdir -v 03/data/db.{1..400}

docker-compose up -d --build

# docker exec -ti ldap01 time ./addnewdb.sh
