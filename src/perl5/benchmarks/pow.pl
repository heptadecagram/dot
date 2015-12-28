#!/usr/bin/perl

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
