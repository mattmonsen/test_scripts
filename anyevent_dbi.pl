#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use AnyEvent;
use DBI;

my $dbh = DBI->connect('dbi:mysql:', undef, undef, {
    PrintError => 0,
    RaiseError => 1,
});

my $count = 1;
my $cond = AnyEvent->condvar;
my $sth = $dbh->prepare('SELECT SLEEP(10), 3', { async => 1 });
$sth->execute;

my $timer = AnyEvent->timer(
    interval => 1,
    cb       => sub {
        say 'timer fired! ' . $count++;
    },
);

my $mysql_watcher = AnyEvent->io(
    fh   => $dbh->mysql_fd,
    poll => 'r',
    cb   => sub {
        say 'got data from MySQL';
        say join(' ', $sth->fetchrow_array);
        $cond->send;
    },
);

$cond->recv;
undef $sth;
$dbh->disconnect;
