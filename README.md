# README

## Setup
`./bin/setup` will setup your local version.

You will need to procure `master.key` from a trusted user and place it in `config` in order to use the encrypted credentials. Or update `storage.yml` with your Google Cloud Service credentials.

When testing the audio upload feature locally you will need to Disable Cross Origin Restrictions in your web browser. In Safari you can do this from the Develop menu.

You should also set CORS for your Google bucket by doing `gsutil cors set google_cloud_storage_cors.json gs://[bucket]`

You will need to setup Sidekiq on your server for running background jobs. To do this on an Ubuntu server you should first install redis with `sudo apt-get install redis-server`.

You will also need to install ffmpeg for the AudioExtraction `sudo apt-get install ffmpeg`

When testing locally you will want to run sidekiq in addition to `bundle exec rails s` by running `bundle exec sidekiq` to enable the Audio and Video transcription tasks.

On production you will want to setup a service to run Sidekiq in `/lib/systemd/system/sidekiq-digitalhub.service`

```
#
# systemd unit file for CentOS 7, Ubuntu 15.04
#
# Customize this file based on your bundler location, app directory, etc.
# Put this in /usr/lib/systemd/system (CentOS) or /lib/systemd/system (Ubuntu).
# Run:
#   - systemctl enable sidekiq
#   - systemctl {start,stop,restart} sidekiq
#
# This file corresponds to a single Sidekiq process.  Add multiple copies
# to run multiple processes (sidekiq-1, sidekiq-2, etc).
#
# See Inspeqtor's Systemd wiki page for more detail about Systemd:
# https://github.com/mperham/inspeqtor/wiki/Systemd
#
[Unit]
Description=sidekiq
# start us only once the network and logging subsystems are available,
# consider adding redis-server.service if Redis is local and systemd-managed.
After=syslog.target network.target

# See these pages for lots of options:
# http://0pointer.de/public/systemd-man/systemd.service.html
# http://0pointer.de/public/systemd-man/systemd.exec.html
[Service]
Type=simple
WorkingDirectory=/var/www/digitalhub/current
# If you use rbenv:
# ExecStart=/bin/bash -lc 'bundle exec sidekiq -e production'
# If you use the system's ruby:
ExecStart=/home/digitalhub/.rvm/wrappers/default/bundle exec sidekiq -e staging
User=digitalhub
Group=digitalhub
UMask=0002

# if we crash, restart
RestartSec=1
Restart=on-failure

# output goes to /var/log/syslog
StandardOutput=syslog
StandardError=syslog

# This will default to "bundler" if we don't specify it
SyslogIdentifier=sidekiq-digitalhub

[Install]
WantedBy=multi-user.target
```

## Testing
System tests can be run on multiple platforms via BrowserStack by using the BROWSER variable.

`BROWSER='iphone' bundle exec rspec`

Valid options include: internet_explorer, chrome, android. Unfortunately Safari using devices do not seem to be compatible with the localtesting setup.

By default rack-test and headless_chrome will be used to run system tests in local development.

## Data Validator
Data validation can be run via rake task:
`$ rake db:validate`

To test the validator, you can run:
`$ rake db:create_invalid_data`

This will create 3 invalid objects (an Announcement, a Report and an Event) with errors.

Correct invalid data in `/hubadmin`, and check your results by clicking on `Validate Data` in `/hubadmin/taggings`



## CMS Instructions

### Home Page

To add content on the home page below the interruption bar
("below the fold"), an editor must add a new page part called "Bottom", with the
slug "bottom".

### Process Timeline

To add phases to the process timeline you must create a new page part with the word "Phase" in it. The phases will be ordered in the order that these page parts are added to the page. The page must also use the "Process Timeline" view template.

## Automatated Browser Testing
Thanks to BrowserStack we have automated testing to make sure this site works on all platforms and is mobile responsive.
![BrowserStack Logo](https://raw.githubusercontent.com/MAPC/digitalhub/develop/browserstack-logo-600x315.png)
