# README

## Dependencies

On macOS:

```
brew install freeimage
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

# FlipKey details

```
1. XML data/feed:
User: mychaletfinder
Pass: LIxoxLol
URL to acess data: http://ws.flipkey.com/pfe/

2. Demo environment for test inquiry posts:
User: mychaletfinder
Pass: 8QXPogvv
https://ws.demo.flipkey.net/pfe/inquiry/inquiry

3. Live/Production for inquiry posts:
User: mychaletfinder
Pass: LIxoxLol
https://ws.flipkey.com/pfe/inquiry/inquiry
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
