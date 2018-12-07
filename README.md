SEEFACTS - The Premier League Information Service
-------------------------------------------------

This CLI was written in Ruby and designed as a way for people to access information and statistics about matches and teams from the current Premier League season. The information is pulled from the football-data.org API. The database can be updated whilst running the program to pull in new information as matches are completed.

Features
--------

- Ability to find out information about any of the current Premier League teams, such as team colours and the year the club  was founded in.

- Ability to run search queries for match information, filtering my team and location.

- Ability to search for match results by the date they were played.

- Ability to view the Premier League table in full, based on the current database information.

Stretch Goals (To be added)
---------------------------

- Add in goal scorer information for each match

- Add in ability to see goal scorers in each match

- Add in ability to see how many goals a player has scored

Instructions
------------

Firstly, fork and clone this repo. To start the program, move into the project directory in your terminal and run the command 'ruby bin/run.rb'

Gems Used
---------

This program will install the following Ruby gems if they are not already on your machine:

- sinatra-activerecord, sqlite3, require_all, json, rest-client, terminal-table, rake


Previews:
---------

Team information search:

![](seefacts-info.gif)

Match information search:

![](seefacts-search.gif)

Matches by date search:

![](seefacts-date.gif)

Full table:

![](seefacts-table.gif)

-----------------
