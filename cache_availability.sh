#!/bin/bash

cd ~/railsapps/myskichalet && bundle exec rake RAILS_ENV=production cache_availability
