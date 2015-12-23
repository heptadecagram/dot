#!/usr/bin/perl
# Project  Name: None
# File / Folder: c.pl
# File Language: perl
# First Created: 2004.12.28 10:05:20
# Last Modified: 2004.12.28 10:13:39

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
