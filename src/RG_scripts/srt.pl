#!/usr/bin/perl

use strict;
use warnings;

my @array = qw(a b c d e);
my %stats;

foreach(1 .. 10_000) {
	$stats{join('', sort { rand() <=> rand() } @array)} += 1;
}
foreach(sort {$stats{$b} <=> $stats{$a} } keys %stats) {
	print "$_: $stats{$_}\n";
}
