# blackboard_feed

## Setup
This program requires a few pieces of software to be installed:
* mysql
* ruby version >= 1.9.3

This program requires 3 environment variables to be set:
* DATABASE_USER - the user that will log into the mysql database
* DATABASE_PASS - the password for that user
* FEED_PATH - the absolute path to the blackboard feed files

To get the databases setup please add the direcotry containing these files to your path and run (TODO):
```bash
feed_setup.rb
```

## Usage
Add the directory that contains these files to your path and run:
```bash
update.rb
```
