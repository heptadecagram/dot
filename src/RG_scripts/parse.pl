#!/usr/bin/perl
# Project  Name: None
# File / Folder: parse.pl
# File Language: perl
# First Created: 2005.06.14 15:08:22
# Last Modified: 2005.06.14 15:39:11

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
