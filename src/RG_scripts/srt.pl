#!/usr/bin/perl
# Project  Name: None
# File / Folder: srt.pl
# File Language: perl
# First Created: 2007.08.29 13:35:14
# Last Modified: 2007.08.29 13:37:36

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
