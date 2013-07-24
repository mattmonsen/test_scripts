#!/usr/bin/perl

use warnings;
use strict;

use feature 'say';
use List::Util qw(reduce);

my @odds;
my @filtered;

foreach ( qw( a b c d e ) ) {
    push @filtered, $_
      if ord( $_ ) % 2;
}

say for @odds;

######

@odds = grep {
    ord( $_ ) % 2
} qw( a b c d e );

say for @odds;

######

my @chars = qw( a b c f b q r n b d );

my @odds_by_inx = grep {
    ord( $chars[$_] ) % 2
} 0 .. $#chars;

######

sub chars_to_ords {
    my @ords;
    foreach ( @_ ) {
        push @ords, ord $_;
    }
    return @ords;
}

######

my @ords = map { ord $_ } qw( a b c d e );

say map { ord } qw( a b c d e );

# sum an array
my $sum = reduce { our ( $a, $b ); $a + $b } 1 .. 10;
say $sum;

# List::MoreUtils
# any
# pairwise
# all
# part
# natatime

my @values = ( 'a', 'b', 'c' );
my $ignore = join ',', map { "'$_'" } @values;

say $ignore;
