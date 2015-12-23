#!/usr/bin/perl

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
