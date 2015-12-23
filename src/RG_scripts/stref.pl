#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $a = [
{
	one => [1,2,3],
	seven => 7
},
[4,5,6],
8,
];

my @b = (1, [2,3,4], {a => 5, b => [6,7]});

print $$a[0]{one}[2];
print $$a[1][2];
print $$a[2];

print $b[0];
print $b[2]{a};
