# README

## Gettings started

Copy config/database.sample.yml to config/database.yml and make any edits
as needed. Then install dependencies as below.

## Dependencies

### ImageScience

On macOS:

```
brew install freeimage
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

`bundle exec rspec`

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

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
