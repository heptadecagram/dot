#!/usr/bin/perl
# Project  Name: None
# File / Folder: group.pl
# File Language: perl
# Copyright (C): 2005 Richard Group, Inc.
# First  Author: Liam Bryan
# First Created: 2005.11.11 11:08:59
# Last Modifier: Liam Bryan
# Last Modified: 2005.11.11 13:44:48

use strict;
use warnings;

my $Previous = 8;

my @people = (1 .. 20);

sub randomize { map{$$_[0]}sort{$$a[1]<=>$$b[1]}map{[$_,rand]}@_; }

my @log;
my %stats;

foreach my $attempt (1 .. 1_000_0) {

	my @teams = randomize(@people);

	my @count;

	foreach(1 .. 4) {
		#$log[$attempt-1][$_-1] = [@teams[5*($_-1) .. 5*$_ - 1] ];
		push @count, scalar grep { $_ <= $Previous } @teams[5*($_-1) .. 5*$_ - 1];
	}
	++$stats{join(' ', sort @count)};

}

foreach(sort { $stats{$b} <=> $stats{$a} } keys %stats) {
	print "$_ : $stats{$_}\n";
}
