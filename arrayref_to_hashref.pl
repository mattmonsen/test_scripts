#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;

=head1 DESCRIPTION

Create a hashref of arrayrefs based on a value of a given key in 
an arrayref of hashrefs using for and push

=cut

my $arrayref = [
    { a => 1, b => 2 },
    { a => 2, b => 1 },
    { a => 1, c => 2 },
    { a => 2, c => 1 },
];

print Dumper($arrayref);

my $hashref;
for my $row (@$arrayref) {
    push @{ $hashref->{$row->{'a'}} }, $row;
}

print Dumper($hashref);

$hashref = {};
push @{ $hashref->{$_->{'a'}} }, $_ for @$arrayref;

print Dumper($hashref);
