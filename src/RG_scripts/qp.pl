#!/usr/bin/perl
# Project  Name: None
# File / Folder: qp.pl
# File Language: perl
# First Created: 2005.01.19 15:24:59
# Last Modified: 2005.01.19 15:25:15

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

