#!/bin/sh
psql -h localhost -p 5433 -U vmuser -d accounts_db -f ./scripts/create.sql