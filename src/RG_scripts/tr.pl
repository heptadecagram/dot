#!/usr/bin/perl
# Project  Name: None
# File / Folder: tr.pl
# File Language: perl
# First Created: 2005.01.12 11:19:16
# Last Modified: 2005.01.12 11:21:33

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
