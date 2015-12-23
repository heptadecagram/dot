#!/usr/bin/perl
# Project  Name: None
# File / Folder: undef.pl
# File Language: perl
# First Created: 2004.12.16 15:27:29
# Last Modified: 2004.12.16 15:29:45

use strict;
use warnings;

sub p{
	my $m = @_;
	my $p = shift;
	print "p: $p\n" if defined $p || $m;
}

p(undef);
p(1);
p(0);
p();
