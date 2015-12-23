#!/usr/bin/perl

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
