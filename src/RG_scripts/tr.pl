#!/usr/bin/perl

use strict;
use warnings;

use Benchmark 'cmpthese';

my $string;
my @words = qw(
3.14
414
text
0.0.0
11.34
270000
3i
2.x
);

cmpthese(-1,
	{
		m => sub { $string = /[^\d.]/ foreach @words; },
		y => sub { $string = y/.// foreach @words; },
	}
);
