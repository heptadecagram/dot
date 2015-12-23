#!/usr/bin/perl
# Project  Name: None
# File / Folder: collect.pl
# File Language: perl
# First Created: 2006.01.11 12:24:10
# Last Modified: 2006.01.11 12:30:04

use strict;
use warnings;

my $TIMES = shift || 100;
my $TOTAL = shift || '';

my @males;
my @females;

foreach(1 .. $TIMES) {
	my $output = `./stat.pl $TOTAL`;
	$output =~ /Loners: (\d+) male, (\d+) female/;
	push @males, $1;
	push @females, $2;
}

printf "Median(mean) Men  : %f(%f)\n", Median(@males), Mean(@males);
printf "Median(mean) Women: %f(%f)\n", Median(@females), Mean(@females);


sub Median {
	my $Array;
	if(ref $_[0] eq 'ARRAY') {
		$Array = $_[0];
	}
	else {
		$Array = \@_;
	}

	my $Index = @$Array - 1;
	if(@$Array % 2) {
		return $$Array[$Index / 2];
	}
	else {
		return ($$Array[$Index / 2] + $$Array[($Index + 1) / 2]) / 2.0;
	}
}

sub Mean {
	my $Length = 0;
	if(ref $_[0] eq 'ARRAY') {
		my $Array = $_[0];
		$Length = @$Array;
	}
	else {
		$Length = @_;
	}
	return &Sum / $Length;
}
sub Sum {
	my($Sum, $Array);
	if(ref $_[0] eq 'ARRAY') {
		$Array = $_[0];
	}
	else {
		$Array = \@_;
	}
	$Sum += $_ foreach(@$Array);
	$Sum;
}
