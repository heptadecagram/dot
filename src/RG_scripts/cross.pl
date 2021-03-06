#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

sub _CrossProduct {
	my($A, $B) = @_;

	my @Return;
	foreach my $a (@$A) {
		my @a = ref $a ? @$a : ($a);
		push @Return, map { ref() ? [ @a, @$_ ] : [ @a, $_ ] } @$B;
	}
	@Return = @$B unless(@$A);

	\@Return;
}

my @x = (1,2,3,4,5);
my @y = (10,20,30,40,50);
my @z = (100,200,300,400,500);
my @h = ();

print Dumper(_CrossProduct(\@h, \@y) );
