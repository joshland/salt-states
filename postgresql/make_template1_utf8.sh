#!/bin/bash

# postgres 9.1 is still created with SQL_ASCII as default encoding for
# template0 and templat1 (default template). This conversion from SQL_ASCII
# to UTF-8 is taken from https://coderwall.com/p/j-_mia
psql -c "UPDATE pg_database SET datistemplate=FALSE WHERE datname='template1';"
psql -c "DROP DATABASE template1;"
psql -c "CREATE DATABASE template1 WITH owner=postgres template=template0 encoding='UTF8';"
psql -c "UPDATE pg_database SET datistemplate=TRUE WHERE datname='template1';"
