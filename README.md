# README

## Contributing

See CONTRIBUTING.md.

## Getting started

Copy config/database.sample.yml to config/database.yml and make any edits
as needed. Then install dependencies as below.

## Dependencies

Install Node.js (https://nodejs.org/) and Yarn (https://yarnpkg.com/).

### ImageScience

On macOS:

```
brew install freeimage
```

On Ubuntu:

```
sudo apt-get install libfreeimage3 libfreeimage-dev
```

### expect

On macOS:

```
brew install expect
```

On Ubuntu:

```
sudo apt-get install expect
```

## Running the test suite

We use RSpec.

`bundle exec rspec`

We also use parallel_tests that utilised all your CPU cores:

`rake parallel:spec`

While developing you should use guard which will run tests on your files as you
save changes to them:

`bundle exec guard`

## Deployment

This website is deployed by keeping a git repository on the server and pulling
to it.

## Restarting the app

There is a restart script in the project root directory that should be run
when new code changes are deployed. The restart script tells Passenger
to reload the app, and it also restarts the delayed_job workers.

## Restarting the server

After restarting the server, the web server needs starting as it does not start
by default. This needs changing. But for now, upon restart, run (as root):

```
killall nginx # in case any other installed versions are running
/opt/nginx/sbin/nginx # start the correct web server
```

## Resizing the disk

After resizing the disk through Gandi control panel, run the following as root:

```
resize2fs /dev/sda
reboot
```

## Troubleshooting

Errors you may face during setup:

```
fatal error: FreeImage.h: No such file or directory #include "FreeImage.h"
```

Install image ImageScience dependencies as described above.

Ubuntu Webpacker issues:

```
sudo apt install webpack
```
