#!/usr/bin/perl
# Project  Name: None
# File / Folder: pow.pl
# File Language: perl
# First Created: 2005.01.18 13:43:10
# Last Modified: 2005.01.18 13:46:10

use strict;
use warnings;

use Benchmark 'cmpthese';

my $string;
my $number;

cmpthese(-1,
	{
		bit => sub { $number = 40_000.03; $string = $number << 1; },
		pow => sub { $number = 40_000.03; $string = $number**2; },
		mul => sub { $number = 40_000.03; $string = $number*$number; },
	}
);
