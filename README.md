#Kitten OR Puppy?
[![Build Status](https://travis-ci.org/hovancik/kitten-or-puppy.svg?branch=master)](https://travis-ci.org/hovancik/kitten-or-puppy)

answering the question that matters most

##Basisc stuff
Site runs on [LowEndSpirit](http://lowendspirit.com/). It has 256MB RAM, 2 cores (but no idea what kind).

App itself is simple:
* imgur api to get images locations
* sqlite database to save data and votes
* sinatra to make it all work together

###Database
Migrations:
`sequel -m db/migrations sqlite://db/app.db`

###Imgur
`ruby lib/import.rb` will import images data from Imgur to db.
