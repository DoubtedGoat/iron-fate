# iron-fate

Stacks and stacks of janky code to help you manage all your Fire Emblem Fates relationships


# Installin' Shiz (on a new vm
sudo apt-get install git postgresql-dev-all

Change Terminal to be Login Shell

Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash


git clone https://github.com/DoubtedGoat/iron-fate.git
cd iron-fate
bundle install


rackup


# Installin Shiz (on Windoze)
Check ruby version; install everything to match
rubyinstaller on windows version Ruby 2.3.0 http://rubyinstaller.org/downloads/
add ruby to path during installation


Install postgres version doesnt matter at all according to jeremie(9.5.3). Note directory for later
C:\Program Files\PostgreSQL\9.5

password is password
default port
no stackbuilder



Download RubyDevkit(same version as ruby), Put in documents
Admin CMD, 

ruby dk.rb init
ruby dk.rb install

add Postgres bin to Path
C:\Program Files\PostgreSQL\9.5\bin

gem install pg --pre


# Setup Postgres locally
createuser -U postgres -P <username>(creates user for postgres)

<password for new user at prompt>

createdb -U postgres fedb(creates new DB called fedb)

set environment DATABASE_URL to

`postgres://<username>:<password>@localhost:5432/fedb`

cd iron-fate/db/

psql -U matt fedb

> \i schema.ddl

> \i 2016_04_04_growths.ddl

> \q

ruby import_classes.rb

ruby import_characters.rb

ruby import_class_growths.rb

ruby import_char_growths.rb

gem install bundle
bundle install

RACKUP



*Run rackup from iron-fate directory then hit localhost:9292