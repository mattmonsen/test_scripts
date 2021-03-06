Test scripts that I use often or need to reference
============

###############
anyevent_dbi.pl
###############

    Using AnyEvent and DBI to run a time while waiting for the database to return

###############
mojo_lite_basic
###############

    Basic script to start a Mojolicious::Lite app

###############
perlmail.pl 
###############

    Pass incoming mail to this script to parse the image and save it to disk, 
    useful for sending photos from a smart phone and storing them online.

###############
ports.pl
###############

    Script to test and see if a given port is open through the firewall

###############
hash2mysql.pl
###############

    Take a hash and pass it to this function to dynamically generate the insert 
    or the update for that table

###############
DbixConnector.pm
###############
 
    Plugin for mojolicious to use DBIx::Connector for handling DBI connections when forking

###############
crypt.pl
###############

    Validate a user from a password stored in a db using the encrypt method provided

###############
csv.pl
###############

    Load any csv file in, dynamically get the headers, and dump out each row as it is read in

###############
authentication.pl
###############

    Using the authentication plugin for Mojolicious

###############
arrayref_to_hashref.pl
###############

    Convert arrayref of hashrefs to a hashref of arrayrefs from a value in a key from the hashrefs

###############
filter.pl
###############

    Examples of using map/grep/sort

###############
dbi_reconnect.pl
###############

    Daemon example of how to keep retrying to connect to DBI if the connection goes away 
    or dies for some reason

###############
multi_line_strings.pl
###############

    Examples of mulit-line strings using here-documents and qq

###############
datetime.pl
###############

    Examples of parsing a datetime string and setting the timezone

###############
unique.pl
###############

    Examples of how to unique a list
