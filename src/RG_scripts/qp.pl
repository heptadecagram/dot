#!/usr/bin/perl

use strict;
use warnings;

my @Products = (
	'Big Sock',
	'Lesbians',
	'teensy weensy pile of kitty litter',
	'Crickets',
	'Sludge Hammer',
);

foreach(@Products) {
	my $Pattern = (split)[rand tr/ //];
	print "$Pattern\n";
}

