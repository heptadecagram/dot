#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

open DA, 't.csv' or die $!;

while(<DA>) {
	chomp;
	my @cap = /("[^"]*"|[^,]*)(?:,|\z)/g;
	print Dumper(\@data);
}

close DA;
