#!/usr/bin/perl

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
