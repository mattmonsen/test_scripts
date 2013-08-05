#!/usr/bin/env perl

use warnings;
use strict;

use Date::Parse;
use DateTime;
use feature 'say';

my $timestamp = str2time("Sun, 04 Aug 2013 13:31:04 +0000");

say $timestamp;

my $dt = DateTime->from_epoch( epoch => $timestamp );

say $dt; 

$dt->set_time_zone('America/Denver');

say $dt;
