#!/bin/bash

source /etc/profile.d/rvm.sh && cd ~/myskichalet && bundle exec rake RAILS_ENV=production cache_unavailability
