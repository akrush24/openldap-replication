#!/bin/sh
docker-compose stop
docker-compose rm
sudo rm -rfv 0[123]/data/*
sudo rm -rfv 0[123]/slapd.d/*
##
tree 0[123]
