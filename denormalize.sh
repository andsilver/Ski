#!/bin/bash

cd ~/railsapps/myskichalet && bundle exec rake RAILS_ENV=production denormalize
cd ~/railsapps/myskichalet && bundle exec rake RAILS_ENV=production pierre_et_vacances:tidy
