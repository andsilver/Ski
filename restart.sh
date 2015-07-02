#!/bin/bash
RAILS_ENV=production bin/delayed_job -n 4 stop
touch tmp/restart.txt
RAILS_ENV=production bin/delayed_job -n 4 start
