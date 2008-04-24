#!/usr/bin/perl
# Project  Name: None
# File / Folder: Statistics.pl
# File Language: perl
# Copyright (C): 2004 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2004.11.06 19:18:47
# Last Modifier: Liam Echlin
# Last Modified: 2008.04.22 10:10:24
package Statistics;

use strict;
use warnings;

use Exporter 'import';
our @ISA = qw(Exporter);
our @EXPORT = qw(Median Mean StandardDeviation Max Min Q1 Q3 Mode);


sub Median {
	my @Array = sort({ $a <=> $b } ref($_[0]) eq 'ARRAY' ? @{$_[0]} : @_);

	my $Index = 1 + scalar @Array;
	if(@Array % 2) {
		return $Array[($Index - 1) / 2];
	}
	else {
		return ($Array[$Index / 2 - 1] + $Array[$Index / 2]) / 2.0;
	}
}

sub Q1 {
	my @Array = sort({ $a <=> $b } ref($_[0]) eq 'ARRAY' ? @{$_[0]} : @_);

	my $Index = 0.25 * (1 + @Array);
	++$Index if($Index - int($Index) >= .5);
	$Index = int $Index;

	$Array[$Index - 1];
}

sub Q3 {
	my @Array = sort({ $a <=> $b } ref($_[0]) eq 'ARRAY' ? @{$_[0]} : @_);

	my $Index = 0.75 * (1 + scalar @Array);
	++$Index if($Index - int($Index) >= .5);
	$Index = int $Index;

	$Array[$Index - 1];
}

sub Mean {
	my $Length = ref($_[0]) eq 'ARRAY' ? scalar @{$_[0]} : scalar @_;

	return &Sum / $Length;
}

sub HarmonicMean {
	my @Array = ref($_[0]) eq 'ARRAY' ? @{$_[0]} : @_;
	my $Sum = 0;

	$Sum += 1.0 / $_ foreach(@Array);
	return 1.0 / ($Sum / @Array);
}

sub Sum {
	my @Array = ref($_[0]) eq 'ARRAY' ? @{$_[0]} : @_;
	my $Sum = 0;

	$Sum += $_ foreach(@Array);
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
	my $Length = ref($_[0]) eq 'ARRAY' ? scalar @{$_[0]} : scalar @_;
	my $Sum = &Sum;

	return sqrt( ($Length * &SumOfSquares - $Sum * $Sum) /
		($Length * $Length) );
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
