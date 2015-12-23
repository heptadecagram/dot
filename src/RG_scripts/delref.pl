#!/usr/bin/perl
# Project  Name: None
# File / Folder: delref.pl
# File Language: perl
# First Created: 2007.01.25 07:29:20
# Last Modified: 2007.01.25 07:31:04

use strict;
use warnings;

use Data::Dumper;

my $k;

$k = {
	"a.bed" => 1,
	"a.keb" => 2,
	"b.jed" => 3,
	"aid" => 4,
	"a.id" => 7,
	"id" => 10,
};

delete @$k{grep /^a\./, keys %$k};

print Dumper($k);
