#!/bin/bash
RAILS_ENV=production script/delayed_job stop
touch tmp/restart.txt
RAILS_ENV=production script/delayed_job -n 2 start
