#!/usr/bin/perl
# Project  Name: None
# File / Folder: Statistics.pl
# File Language: perl
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.11.06 19:18:47
# Last Modifier: Liam Bryan
# Last Modified: 2005.10.24 09:39:33
package Statistics;

use strict;
use warnings;


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

sub HarmonicMean {
	my($Sum, $Array);
	if(ref $_[0] eq 'ARRAY') {
		$Array = $_[0];
	}
	else {
		$Array = \@_;
	}
	$Sum += 1.0 / $_ foreach(@$Array);
	return 1.0 / ($Sum / @$Array);
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

sub SumOfSquares {
	my($Sum, $Array);
	if(ref $_[0] eq 'ARRAY') {
		$Array = $_[0];
	}
	else {
		$Array = \@_;
	}
	$Sum += $_ * $_ foreach(@$Array);
	$Sum;
}

# Don't forget: Standard deviations contain 68.26%, 95.46%, 99.73% of the data
# in normal distribution.

sub StandardDeviation {
	my $Array;
	if(ref $_[0] eq 'ARRAY') {
		$Array = $_[0];
	}
	else {
		$Array = \@_;
	}
	my $Sum = &Sum;

	return sqrt( (@$Array * &SumOfSquares - $Sum * $Sum) /
		(@$Array * @$Array) );
}

sub SampleStandardDeviation {
	my $Array;
	if(ref $_[0] eq 'ARRAY') {
		$Array = $_[0];
	}
	else {
		$Array = \@_;
	}
	my $Sum = &Sum;

	return sqrt( (@$Array * &SumOfSquares - $Sum * $Sum) /
		(@$Array * (@$Array - 1) ) );
}

sub Max {
	if(ref $_[0] eq 'ARRAY') {
		my $Array = $_[0];
		return (sort { $b <=> $a } @$Array)[0];
	}
	else {
		return (sort { $b <=> $a } @_)[0];
	}
}

sub Min {
	if(ref $_[0] eq 'ARRAY') {
		my $Array = $_[0];
		return (sort { $a <=> $b } @$Array)[0];
	}
	else {
		return (sort { $a <=> $b } @_)[0];
	}
}

sub Mode {
	my($Array, %Count);
	if(ref $_[0] eq 'ARRAY') {
		$Array = $_[0];
	}
	else {
		$Array = \@_;
	}

	foreach(@$Array) {
		++$Count{$_};
	}
	if(wantarray) {
		my $Max = Max(values %Count);
		return grep { $Count{$_} == $Max } keys %Count;
	}
	else {
		return (sort { $Count{$b} <=> $Count{$a} } keys %Count)[0];
	}
}

1;
