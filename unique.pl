#!/usr/bin/perl

use warnings;
use strict;

use Benchmark;
use List::MoreUtils qw(uniq);

my @list;
for ( 0..9999 ) {
    push @list, sprintf "%d", 100 * rand ;
}

timethese( 1000, {
    'keys_map'        => sub { my @uniq = keys %{{ map {$_ => 1} @list }}; },
    'grep_seen'       => sub { my %seen; my @uniq = grep ! $seen{$_}++ , @list; },
    'keys_map_undef'  => sub { my @uniq = keys %{{ map {$_ => undef} @list }}; },
    'grep_seen_empty' => sub { my @uniq = do { my %seen; @seen{@list}=(); keys %seen; } }, 
    'grep_seen_undef' => sub { my @uniq = do { my %seen; undef @seen{@list}; keys %seen; } }, 
    'list_more_utils' => sub { my @uniq = uniq @list; },
});

my @nums = (1, 3, 6, 3, 2, 5, 1, 7, 3, 6, 7, 8, 7, 9, 2);

my @uniq = do {
    my %seen;
    undef @seen{@nums};
    keys %seen;
};

print "@nums\n@uniq";
