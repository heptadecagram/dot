#!/usr/bin/perl

use strict;
use warnings;

use Benchmark qw(cmpthese);

my $string;
my @values = qw(ao oe eu);

cmpthese(-1,
	{
		'com' => sub { $string = 'ao', 'oe', 'eu'; },
		'cat' => sub { $string = 'ao' . 'oe' . 'eu'; },
	}
);
