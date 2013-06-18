#!/usr/bin/perl

use strict;
use warnings;

use Text::CSV;
use Data::Dumper qw(Dumper);
use feature 'say';

my $filename = $ARGV[0] || '/path/to/file.csv';

my @rows;
open my $fh, '<', $filename or die "$filename: $!";
my $csv = Text::CSV->new( { binary => 1 } );
$csv->column_names( $csv->getline( $fh ) );

while ( my $row = $csv->getline_hr( $fh ) ){
    say Dumper($row);
}

close $fh;
