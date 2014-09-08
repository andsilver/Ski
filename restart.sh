#!/bin/bash
RAILS_ENV=production bin/delayed_job stop
touch tmp/restart.txt
RAILS_ENV=production bin/delayed_job -n 3 start
