#!/usr/bin/perl
# Project  Name: None
# File / Folder: type.pl
# File Language: perl
# First Created: 2005.05.26 10:47:16
# Last Modified: 2005.05.26 11:00:21

use strict;
use warnings;

use Data::Dumper;

sub whatis($) {
	my $thing = \$_[0];

	print length $$thing;
	print "$thing";
	print ref($thing), Dumper($thing);
	print "\n";
}

whatis(23);
whatis(-3);
whatis('23');
