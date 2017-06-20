#!/usr/bin/env bash

curl -sSL https://get.rvm.io | bash -s stable
source /home/vagrant/.rvm/scripts/rvm
rvm --default use --install 2.3.4
